#import "ArticlesVC.h"
#import "DataService.h"
#import "DateHelper.h"
#import "ArticleVC.h"
#import "Article.h"

@implementation ArticlesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.articles = [[DataService instance] articles];
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.0-1.0 green:0.0-1.0 blue:0.0-1.0 alpha:0.5f]];
}

- (NSArray*)articles
{
    if (_articles == nil) {
        _articles = [[NSArray alloc]init];
    }
    return _articles;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.articles count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2)
        return 90;
    else
        return 60;
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
        [cell.textLabel setNumberOfLines:2];
    } else {
        [cell.textLabel setNumberOfLines:1];
    }
    
    Article *article = self.articles [indexPath.row];
    cell.textLabel.text = article.title;
    cell.detailTextLabel.text = [DateHelper getStringDateFromApiFormat:article.date];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"openArticle"]) {
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        Article *article = [self.articles objectAtIndex:ip.row];
        [segue.destinationViewController setArticle:article.id];
    }
}

@end
