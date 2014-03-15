#import "ArticleVC.h"
#import "DataService.h"
#import "Article.h"
#import "ImageHelper.h"
#import "DateHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ArticleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Article *article = [[DataService instance] article:_chosenArticle];
    
    self.articleTitle.text = article.title;
    self.articleText.text = article.text;
    self.articleDate.text = [DateHelper getStringDateTimeFromApiFormat:article.date];
    [self.articleImage setImageWithURL:[NSURL URLWithString:article.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [self.articleImage sizeToFit];
    [self.articleTitle sizeToFit];
    [self.articleDate sizeToFit];
    [self.articleText sizeToFit];
}

- (void)setArticle:(NSNumber *)articleId
{
    _chosenArticle = articleId;
}

@end
