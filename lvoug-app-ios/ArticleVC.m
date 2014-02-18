#import "ArticleVC.h"
#import "APIClient.h"

@interface ArticleVC ()

@end

@implementation ArticleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *article = [[APIClient instance] article:_chosenArticle];
    
    self.articleTitle.text = [article objectForKey:@"title"];
    self.articleText.text = [article objectForKey:@"description"];
}

-(void)setArticle:(NSString *)articleId
{
    _chosenArticle = articleId;
}

@end
