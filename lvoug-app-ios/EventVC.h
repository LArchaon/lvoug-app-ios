#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface EventVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventText;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UILabel *eventDate;
@property (weak, nonatomic) IBOutlet UIButton *eventPageButton;
@property (weak, nonatomic) IBOutlet UILabel *eventAddress;

@property (weak, nonatomic) IBOutlet UITableView *eventMaterials;
@property (weak, nonatomic) IBOutlet UITableView *eventContacts;
@property (weak, nonatomic) IBOutlet UITableView *eventSponsors;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eventMaterialsConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eventContactsConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eventSponsorsConstraint;

- (void)setEvent:(NSNumber *)eventId;

@end
