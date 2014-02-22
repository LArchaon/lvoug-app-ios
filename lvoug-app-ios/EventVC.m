#import "EventVC.h"
#import "DataService.h"

@interface EventVC ()

@end

@implementation EventVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Event *event = [[DataService instance] event:_chosenEvent];
    
    self.eventTitle.text = event.title;
    self.eventText.text = event.text;
    
    id latitude = event.address_latitude;
    id longitude = event.address_longitude;
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
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 20000, 20000);
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = self.eventTitle.text;
    
    [self.eventMap setRegion:viewRegion animated:YES];
    [self.eventMap addAnnotation:annotationPoint];
}

-(void)setEvent:(NSNumber *)eventId
{
    _chosenEvent = eventId;
}

@end
