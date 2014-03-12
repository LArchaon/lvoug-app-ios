#import "ArticleVC.h"
#import "DataService.h"
#import "Article.h"
#import "ImageHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ArticleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Article *article = [[DataService instance] article:_chosenArticle];
    
    self.articleTitle.text = article.title;

    NSMutableString * toString = [[NSMutableString alloc] initWithString:@"Article object contents: ["];
    [toString appendString:@"\nID:"];
    [toString appendString:[article.id stringValue]];
    [toString appendString:@"\nTitle:"];
    [toString appendString:article.title];
    [toString appendString:@"\nText:"];
    [toString appendString:article.text];
    [toString appendString:@"\nDate:"];
    [toString appendString:[article.date stringByAbbreviatingWithTildeInPath]];
    [toString appendString:@"\nImage:"];
    [toString appendString:article.image];
    [toString appendString:@"\n]."];
    self.articleText.text = toString;
    
    [self.articleImage setImageWithURL:[NSURL URLWithString:article.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [self.articleImage sizeToFit];
    [self.articleTitle sizeToFit];
    [self.articleText sizeToFit];
}

- (void)setArticle:(NSNumber *)articleId
{
    _chosenArticle = articleId;
}

@end
