#import "EventVC.h"
#import "APIClient.h"
#define METERS_PER_MILE 1609.344

@interface EventVC ()

@end

@implementation EventVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *event = [[APIClient instance] event:_chosenEvent];
    
    self.eventTitle.text = [event objectForKey:@"title"];
    self.eventText.text = [event objectForKey:@"description"];
    
    id latitude = [event objectForKey:@"address_latitude"];
    id longitude = [event objectForKey:@"address_longitude"];
    [self initMapWithLatitude:[latitude doubleValue] andWithLongitude:[longitude doubleValue]];

}

-(void)initMapWithLatitude:(double)latitude andWithLongitude:(double)longitude
{
    CLLocationCoordinate2D annotationCoord;
    annotationCoord.latitude = latitude;
    annotationCoord.longitude = longitude;
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = latitude;
    zoomLocation.longitude = longitude;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = self.eventTitle.text;
    
    [self.eventMap setRegion:viewRegion animated:YES];
    [self.eventMap addAnnotation:annotationPoint];
}

-(void)setEvent:(NSString *)eventId
{
    _chosenEvent = eventId;
}

@end
