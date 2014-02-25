#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface EventVC : UIViewController

@property(strong, nonatomic) NSNumber *chosenEvent;
-(void)setEvent:(NSNumber *)eventId;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventText;
@property (weak, nonatomic) IBOutlet MKMapView *eventMap;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;

@end
