#import "ArticleVC.h"
#import "DataService.h"
#import "Article.h"
#import "ImageHelper.h"

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
    
    [self.articleImage sizeToFit];
    [self.articleTitle sizeToFit];
    [self.articleText sizeToFit];
}

-(void)setArticle:(NSNumber *)articleId
{
    _chosenArticle = articleId;
}

@end
