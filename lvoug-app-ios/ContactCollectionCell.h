#import <UIKit/UIKit.h>

@interface ContactCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *contactView;
@property (weak, nonatomic) IBOutlet UILabel *contactNameSurname;
@property (weak, nonatomic) IBOutlet UILabel *contactPhone;
@property (weak, nonatomic) IBOutlet UILabel *contactEmail;

@end
