#import "NewsVC.h"
#import "MFSideMenu.h"
#import "APIClient.h"

@implementation NewsVC

#pragma mark -
#pragma mark - UITableViewDataSource

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    id client = [APIClient restClient];
    NSMutableArray *articles = [client news];
    
    for (id article in articles) {
        [self.names addObject:article];
    }
}

//lazy instantiation
-(NSMutableArray*)names
{
    if (_names == nil) {
        _names = [[NSMutableArray alloc]init];
    }
    return _names;
}

//table view
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.names count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    [tableView setSeparatorColor:[UIColor colorWithRed:0.0-1.0 green:0.0-1.0 blue:0.0-1.0 alpha:0.5f]];
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    
    NSDictionary *article = self.names [indexPath.row];
    cell.textLabel.text = [article objectForKey:@"title"];
    cell.detailTextLabel.text = [[article objectForKey:@"description"] substringWithRange:NSMakeRange(0, 5)];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [article objectForKey:@"image"]]];
    cell.imageView.image = [UIImage imageWithData: imageData];
    
    return cell;
}

@end
