#import "SideMenuVC.h"
#import "MFSideMenu.h"
#import "ArticlesVC.h"
#import "EventsVC.h"

@implementation SideMenuVC

#pragma mark -
#pragma mark - UITableViewDataSource

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.menuItems addObject:@{@"title":@"Home", @"img":@"ico_home.png", @"controllerId": @"homeVC"}];
    [self.menuItems addObject:@{@"title":@"News", @"img":@"ico_news.png", @"controllerId": @"articlesVC"}];
    [self.menuItems addObject:@{@"title":@"Past events", @"img":@"ico_events.png", @"controllerId": @"eventsVC"}];
    [self.menuItems addObject:@{@"title":@"About", @"img":@"ico_about.png", @"controllerId": @"aboutVC"}];
    [self.menuItems addObject:@{@"title":@"Twitter", @"img":@"ico_twitter.png"}];
    
    // upper margin hack
    [self.tableView setContentInset:UIEdgeInsetsMake(20, self.tableView.contentInset.left, self.tableView.contentInset.bottom, self.tableView.contentInset.right)];
    
    // full length item delimiter hack
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
}

-(NSMutableArray*)menuItems
{
    if (_menuItems == nil) {
        _menuItems = [[NSMutableArray alloc]init];
    }
    return _menuItems;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self. menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *menuItem = self.menuItems [indexPath.row];
    NSString *title = [menuItem objectForKey:@"title"];
    NSString *image = [menuItem objectForKey:@"img"];
    UIImage *uiImage = [UIImage imageNamed:image];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftNavCell"];
    cell.textLabel.text = [NSString stringWithFormat:title, indexPath.row];
    cell.imageView.image = uiImage;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // hack for deselecting item after it was clicked
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 4) { // twitter
        
        BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?id=lvoug"]];
        if (canOpen) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?id=lvoug"]];
        } else {
            NSURL *url = [NSURL URLWithString:@"https://www.twitter.com/lvoug"];
            [[UIApplication sharedApplication] openURL:url];
        }
        
    } else {
        
        NSDictionary *menuItem = self.menuItems [indexPath.row];
        NSString *controllerId = [menuItem objectForKey:@"controllerId"];

        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:controllerId];
        controller.title = [menuItem objectForKey:@"title"];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:controller];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        
    }
}

@end