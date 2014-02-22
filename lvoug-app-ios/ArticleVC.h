#import <UIKit/UIKit.h>

@interface ArticleVC : UIViewController

@property(strong, nonatomic) NSNumber *chosenArticle;
-(void)setArticle:(NSNumber *)articleId;
@property (weak, nonatomic) IBOutlet UITextView *articleTitle;
@property (weak, nonatomic) IBOutlet UITextView *articleText;

@end
