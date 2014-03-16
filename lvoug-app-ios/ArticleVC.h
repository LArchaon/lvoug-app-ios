#import <UIKit/UIKit.h>

@interface ArticleVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *articleText;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *articleDate;
@property (weak, nonatomic) IBOutlet UIScrollView *articleScrollView;

- (void)setArticle:(NSNumber *)articleId;

@end
