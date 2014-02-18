#import "NewsVC.h"
#import "APIClient.h"
#import "ArticleVC.h"

@implementation NewsVC

#pragma mark -
#pragma mark - UITableViewDataSource

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *articleList = [[APIClient instance] news];
    
    for (id article in articleList) {
        [self.articles addObject:article];
    }
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.0-1.0 green:0.0-1.0 blue:0.0-1.0 alpha:0.5f]];
    // full length item delimiter hack
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
}

-(NSMutableArray*)articles
{
    if (_articles == nil) {
        _articles = [[NSMutableArray alloc]init];
    }
    return _articles;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.articles count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    
    NSDictionary *article = self.articles [indexPath.row];
    cell.textLabel.text = [article objectForKey:@"title"];
    cell.detailTextLabel.text = [article objectForKey:@"description"];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [article objectForKey:@"image"]]];
    cell.imageView.image = [UIImage imageWithData: imageData];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"openArticle"]) {
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        NSDictionary *article = [self.articles objectAtIndex:ip.row];
        [segue.destinationViewController setArticle:[article objectForKey:@"id"]];
    }
}

@end
