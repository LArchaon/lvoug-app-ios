//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "DemoViewController.h"

@implementation SideMenuViewController

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
}


//wtf
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
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *title = self.titles [indexPath.row];
    NSString *image = self.icons [indexPath.row];

    
    cell.textLabel.text = [NSString stringWithFormat:title, indexPath.row];
    UIImage *uiImage = [UIImage imageNamed:image];
    cell.imageView.image = uiImage;
    if (indexPath.row == 0) {
        cell.imageView.highlightedImage = uiImage;
    }
    
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 4.0;
    //cell.imageView.backgroundColor = [UIColor colorWithRed:0.0-1.0 green:0.0-1.0 blue:0.0-1.0 alpha:0.5f];

    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
        
        UITableViewController *newsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"demoViewController"];
        
        newsViewController.title = self.titles [indexPath.row];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:newsViewController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

    } else {
        UITableViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"demoViewController"];
        
        demoViewController.title = self.titles [indexPath.row];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:demoViewController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
}

@end