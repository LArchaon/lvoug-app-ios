#import "ArticleVC.h"
#import "DataService.h"
#import "Article.h"
#import "ImageHelper.h"
#import "DateHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NavigationHelper.h"

@implementation ArticleVC

NSNumber * chosenArticle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Article *article = [[DataService instance] article:chosenArticle];
    
    self.articleTitle.text = article.title;
    
    self.articleDate.text = [DateHelper getStringDateTimeFromApiFormat:article.date];
    [self.articleImage setImageWithURL:[NSURL URLWithString:article.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    self.articleText.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    self.articleText.delegate = self;
    self.articleText.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
    self.articleText.text = article.text;
}

- (void)setArticle:(NSNumber *)articleId
{
    chosenArticle = articleId;
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    [NavigationHelper openUrl:[url absoluteString]];
}

@end
