#import "BaseFirstLevelVC.h"

@interface HomeVC : BaseFirstLevelVC
@property (weak, nonatomic) IBOutlet UIView *latestEvent;
@property (weak, nonatomic) IBOutlet UIView *latestArticle;
@property (weak, nonatomic) IBOutlet UILabel *latestEventTitle;
@property (weak, nonatomic) IBOutlet UILabel *latestArticleTitle;

@end
