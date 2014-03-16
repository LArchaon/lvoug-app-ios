#import "ArticleVC.h"
#import "DataService.h"
#import "Article.h"
#import "ImageHelper.h"
#import "DateHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ArticleVC

NSNumber * chosenArticle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Article *article = [[DataService instance] article:chosenArticle];
    
    self.articleTitle.text = article.title;
    self.articleText.text = article.text;
    self.articleDate.text = [DateHelper getStringDateTimeFromApiFormat:article.date];
    [self.articleImage setImageWithURL:[NSURL URLWithString:article.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
}

- (void)setArticle:(NSNumber *)articleId
{
    chosenArticle = articleId;
}

@end
