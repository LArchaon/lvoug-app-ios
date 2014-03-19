#import "ArticlesVC.h"
#import "DataService.h"
#import "DateHelper.h"
#import "ArticleVC.h"
#import "Article.h"

@implementation ArticlesVC

NSArray * _articles;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _articles = [[DataService instance] articles];
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.0-1.0 green:0.0-1.0 blue:0.0-1.0 alpha:0.5f]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshView)
                                                 name:@"articlesUpdated"
                                               object:nil];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_articles count];
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
    
    Article *article = _articles [indexPath.row];
    cell.textLabel.text = article.title;
    cell.detailTextLabel.text = [DateHelper getStringDateFromApiFormat:article.date];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"openArticle"]) {
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        Article *article = [_articles objectAtIndex:ip.row];
        [segue.destinationViewController setArticle:article.id];
    }
}

@end
