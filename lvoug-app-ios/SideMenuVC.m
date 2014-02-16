#import "SideMenuVC.h"
#import "MFSideMenu.h"
#import "NewsVC.h"
#import "EventsVC.h"

@implementation SideMenuVC

#pragma mark -
#pragma mark - UITableViewDataSource

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.titles addObject:@"Home"];
    [self.titles addObject:@"News"];
    [self.titles addObject:@"Past events"];
    [self.titles addObject:@"About"];
    [self.titles addObject:@"Twitter"];
    
    [self.icons addObject:@"ico_home.png"];
    [self.icons addObject:@"ico_news.png"];
    [self.icons addObject:@"ico_events.png"];
    [self.icons addObject:@"ico_about.png"];
    [self.icons addObject:@"ico_twitter.png"];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(20, self.tableView.contentInset.left, self.tableView.contentInset.bottom, self.tableView.contentInset.right)];
}

-(NSMutableArray*)titles
{
    if (_titles == nil) {
        _titles = [[NSMutableArray alloc]init];
    }
    return _titles;
}

-(NSMutableArray*)icons
{
    if (_icons == nil) {
        _icons = [[NSMutableArray alloc]init];
    }
    return _icons;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    
    static NSString *CellIdentifier = @"leftNavCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *title = self.titles [indexPath.row];
    NSString *image = self.icons [indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:title, indexPath.row];
    UIImage *uiImage = [UIImage imageNamed:image];
    cell.imageView.image = uiImage;
    
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 4.0;
    
    return cell;
}


#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 4) { // twitter
        
        BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?id=lvoug"]];
        if (canOpen) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?id=lvoug"]];
        } else {
            NSURL *url = [NSURL URLWithString:@"https://www.twitter.com/lvoug"];
            [[UIApplication sharedApplication] openURL:url];
        }
        
    } else if (indexPath.row == 3) { // about
        
        UIViewController *aboutViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"aboutViewController"];
        aboutViewController.title = self.titles [indexPath.row];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:aboutViewController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        
    } else if (indexPath.row == 1) { // news
        
        NewsVC *newsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"newsVC"];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:newsVC];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        
    } else if (indexPath.row == 2) { // events
        
        EventsVC *eventsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"eventsVC"];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:eventsVC];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

    } else { // home
        
        UITableViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeViewController"];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:demoViewController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        
    }
}

@end