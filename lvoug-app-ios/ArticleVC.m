#import "ArticleVC.h"
#import "APIClient.h"
#import "Article.h"

@interface ArticleVC ()

@end

@implementation ArticleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Article *article = [[APIClient instance] article:_chosenArticle];
    
    self.articleTitle.text = article.title;
    self.articleText.text = article.text;
}

-(void)setArticle:(NSNumber *)articleId
{
    _chosenArticle = articleId;
}

@end
