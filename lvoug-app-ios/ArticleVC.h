#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"

@interface ArticleVC : UIViewController<TTTAttributedLabelDelegate>

@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *articleText;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *articleDate;
@property (weak, nonatomic) IBOutlet UIScrollView *articleScrollView;

- (void)setArticle:(NSNumber *)articleId;

@end
