#import "NewsVC.h"
#import "MFSideMenu.h"

@implementation NewsVC

#pragma mark -
#pragma mark - UITableViewDataSource

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self.names addObject:@"news1"];
    [self.names addObject:@"news2"];
    [self.names addObject:@"news3"];
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
    
    cell.textLabel.text = self.names [indexPath.row];
    cell.detailTextLabel.text = @"wow details";
    cell.imageView.image = [UIImage imageNamed:@"ico_news.png"];
    return cell;
}

@end
