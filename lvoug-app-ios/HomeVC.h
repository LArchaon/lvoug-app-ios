#import "BaseFirstLevelVC.h"

@interface HomeVC : BaseFirstLevelVC
@property (weak, nonatomic) IBOutlet UIView *latestEvent;
@property (weak, nonatomic) IBOutlet UIView *latestArticle;
@property (weak, nonatomic) IBOutlet UILabel *latestEventTitle;
@property (weak, nonatomic) IBOutlet UILabel *latestArticleTitle;
@property (weak, nonatomic) IBOutlet UILabel *latestArticleDate;
@property (weak, nonatomic) IBOutlet UILabel *latestEventDate;
@property (weak, nonatomic) IBOutlet UIImageView *latestEventArrow;

@end
