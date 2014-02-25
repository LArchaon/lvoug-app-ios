#import <UIKit/UIKit.h>

@interface ArticleVC : UIViewController

@property(strong, nonatomic) NSNumber *chosenArticle;
-(void)setArticle:(NSNumber *)articleId;

@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *articleText;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;

@end
