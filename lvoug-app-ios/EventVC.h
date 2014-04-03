#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TTTAttributedLabel.h"

@interface EventVC : UIViewController<UITableViewDataSource,UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, TTTAttributedLabelDelegate>

@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *eventText;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UILabel *eventDate;
@property (weak, nonatomic) IBOutlet UIButton *eventPageButton;
@property (weak, nonatomic) IBOutlet UILabel *eventAddress;
@property (weak, nonatomic) IBOutlet UIImageView *mapIcon;

@property (weak, nonatomic) IBOutlet UITableView *eventMaterials;
@property (weak, nonatomic) IBOutlet UICollectionView *eventContacts;
@property (weak, nonatomic) IBOutlet UICollectionView *eventSponsors;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eventMaterialsConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eventContactsConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eventSponsorsConstraint;

@property (weak, nonatomic) IBOutlet UILabel *materialsHeading;
@property (weak, nonatomic) IBOutlet UILabel *sponsorsHeading;
@property (weak, nonatomic) IBOutlet UILabel *contactsHeading;
- (void)setEvent:(NSNumber *)eventId;

@end
