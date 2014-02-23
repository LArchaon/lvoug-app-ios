#import "ArticleVC.h"
#import "DataService.h"
#import "Article.h"

@interface ArticleVC ()

@end

@implementation ArticleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Article *article = [[DataService instance] article:_chosenArticle];
    
    self.articleTitle.text = article.title;
    self.articleText.text = article.text;
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: article.image]];
    self.articleImage.image = [UIImage imageWithData: imageData];
}

-(void)setArticle:(NSNumber *)articleId
{
    _chosenArticle = articleId;
}

@end
