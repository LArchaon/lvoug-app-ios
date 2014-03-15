#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface EventVC : UIViewController

@property(strong, nonatomic) NSNumber *chosenEvent;

@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventText;
@property (weak, nonatomic) IBOutlet MKMapView *eventMap;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UILabel *eventDate;
@property (weak, nonatomic) IBOutlet UIButton *eventPageButton;

- (void)setEvent:(NSNumber *)eventId;

@end
