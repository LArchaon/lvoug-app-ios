#import "EventVC.h"
#import "DataService.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface EventVC ()

@end

@implementation EventVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Event *event = [[DataService instance] event:_chosenEvent];
    
    self.eventTitle.text = event.title;
    
    NSMutableString * toString = [[NSMutableString alloc] initWithString:@"Event object contents: ["];
    [toString appendString:@"\nID:"];
    [toString appendString:[event.id stringValue]];
    [toString appendString:@"\nTitle:"];
    [toString appendString:event.title];
    [toString appendString:@"\nText:"];
    [toString appendString:event.text];
    [toString appendString:@"\nDate:"];
    [toString appendString:[event.date stringByAbbreviatingWithTildeInPath]];
    [toString appendString:@"\nLogo:"];
    [toString appendString:event.logo];
    [toString appendString:@"\nPage:"];
    [toString appendString:event.event_page];
    [toString appendString:@"\nAddress:"];
    [toString appendString:event.address];
    [toString appendString:@"\nLatitude:"];
    [toString appendString:[event.address_latitude stringValue]];
    [toString appendString:@"\nLongitude:"];
    [toString appendString:[event.address_longitude stringValue]];
    [toString appendString:@"\n]."];
    
    for (id material in event.eventMaterials) {
        Material * eventMaterial = (Material *)material;
        [toString appendString:@"\nMaterial:"];
        [toString appendString:[eventMaterial.id stringValue]];
        [toString appendString:@" "];
        [toString appendString:eventMaterial.url];
    }
    
    for (id contact in event.eventContacts) {
        Contact * eventContact = (Contact *)contact;
        [toString appendString:@"\nContact:"];
        [toString appendString:[eventContact.id stringValue]];
        [toString appendString:@" "];
        [toString appendString:eventContact.name];
    }
    
    for (id sponsor in event.eventSponsors) {
        Sponsor * eventSponsor = (Sponsor *)sponsor;
        [toString appendString:@"\nSponsor:"];
        [toString appendString:[eventSponsor.id stringValue]];
        [toString appendString:@" "];
        [toString appendString:eventSponsor.name];
    }
    
    
    
    self.eventText.text = toString;

    
    id latitude = event.address_latitude;
    id longitude = event.address_longitude;
    
    if (latitude != nil && longitude != nil)
        [self initMapWithLatitude:[latitude doubleValue] andWithLongitude:[longitude doubleValue]];
    
    [self.eventImage setImageWithURL:[NSURL URLWithString:event.logo] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [self.eventImage sizeToFit];
    [self.eventTitle sizeToFit];
    [self.eventText sizeToFit];
}

- (void)initMapWithLatitude:(double)latitude andWithLongitude:(double)longitude
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

- (void)setEvent:(NSNumber *)eventId
{
    _chosenEvent = eventId;
}

@end
