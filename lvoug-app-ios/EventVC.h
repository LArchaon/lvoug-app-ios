#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface EventVC : UIViewController

@property(strong, nonatomic) NSNumber *chosenEvent;
-(void)setEvent:(NSNumber *)eventId;
@property (weak, nonatomic) IBOutlet UITextView *eventTitle;
@property (weak, nonatomic) IBOutlet UITextView *eventText;
@property (weak, nonatomic) IBOutlet MKMapView *eventMap;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;

@end
