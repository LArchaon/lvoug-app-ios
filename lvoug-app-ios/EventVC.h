#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface EventVC : UIViewController

@property(strong, nonatomic) NSString *chosenEvent;
-(void)setEvent:(NSString *)eventId;
@property (weak, nonatomic) IBOutlet UITextView *eventTitle;
@property (weak, nonatomic) IBOutlet UITextView *eventText;
@property (weak, nonatomic) IBOutlet MKMapView *eventMap;

@end
