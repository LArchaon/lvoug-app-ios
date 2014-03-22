#import "SideMenuVC.h"
#import "MFSideMenu.h"
#import "ArticlesVC.h"
#import "EventsVC.h"
#import "DataService.h"

@implementation SideMenuVC

NSArray * menuItems;

- (void)viewDidLoad
{
    [super viewDidLoad];
    menuItems = [DataService getMenuItems];
    
    // upper margin hack
    [self.tableView setContentInset:UIEdgeInsetsMake(20, self.tableView.contentInset.left, self.tableView.contentInset.bottom, self.tableView.contentInset.right)];
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
    return [menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *menuItem = menuItems[indexPath.row];
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
        
    NSDictionary *menuItem = menuItems[indexPath.row];
    NSString *controllerId = [menuItem objectForKey:@"controllerId"];

    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:controllerId];
    controller.title = [menuItem objectForKey:@"title"];
    
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    NSArray *controllers = [NSArray arrayWithObject:controller];
    navigationController.viewControllers = controllers;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

@end