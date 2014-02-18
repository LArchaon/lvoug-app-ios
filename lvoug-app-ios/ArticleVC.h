#import <UIKit/UIKit.h>

@interface ArticleVC : UIViewController

@property(strong, nonatomic) NSString *chosenArticle;
-(void)setArticle:(NSString *)articleId;
@property (weak, nonatomic) IBOutlet UITextView *articleTitle;
@property (weak, nonatomic) IBOutlet UITextView *articleText;

@end
