#import "EventVC.h"
#import "DataService.h"
#import "DateHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation EventVC

NSString * eventPage;
NSNumber * eventLatitude;
NSNumber * eventLongitude;
NSNumber * chosenEvent;

- (void)viewDidLoad
{
    [super viewDidLoad];

    Event *event = [[DataService instance] event:chosenEvent];
    
    self.eventTitle.text = event.title;
    self.eventText.text = event.text;
    
    NSMutableString * address = [[NSMutableString alloc] init];
    [address appendString:event.address];
    [address appendString:@" (get directions)"];
    self.eventAddress.text = address;
    self.eventDate.text = [DateHelper getStringDateTimeFromApiFormat:event.date];
    
    [self.eventImage setImageWithURL:[NSURL URLWithString:event.logo] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    eventPage = event.event_page;
    self.eventPageButton.backgroundColor = [UIColor colorWithRed:255/255.0f green:129/255.0f blue:127/255.0f alpha:1.0f];
    [self.eventPageButton addTarget:self action:@selector(openUrlOnButtonPress) forControlEvents:UIControlEventTouchUpInside];
    
    eventLatitude = event.address_latitude;
    eventLongitude = event.address_longitude;

    if (eventLatitude != nil && eventLongitude != nil) {
        self.eventAddress.textColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        self.eventAddress.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openMapOnAddressPress)];
        [self.eventAddress addGestureRecognizer:tapGesture];
    }
}

- (void)openUrlOnButtonPress
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: eventPage]];
}

- (void)openMapOnAddressPress
{
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        CLLocationCoordinate2D coordinate =
        CLLocationCoordinate2DMake([eventLatitude doubleValue], [eventLongitude doubleValue]);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:@"Venue"];
        
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking};
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
                       launchOptions:launchOptions];
    }
}

- (void)setEvent:(NSNumber *)eventId
{
    chosenEvent = eventId;
}

@end
