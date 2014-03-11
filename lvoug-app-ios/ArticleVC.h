#import <UIKit/UIKit.h>

@interface ArticleVC : UIViewController

@property(strong, nonatomic) NSNumber *chosenArticle;
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *articleText;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;

- (void)setArticle:(NSNumber *)articleId;

@end
