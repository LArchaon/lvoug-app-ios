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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *title;
    NSString *image;
    
    if (indexPath.row == 0) {
        title = @"Home";
        image = @"ico_home.png";
    } else if (indexPath.row == 1) {
        title = @"News";
        image = @"ico_news.png";
    } else if (indexPath.row == 2) {
        title = @"Past Events";
        image = @"ico_events.png";
    } else if (indexPath.row == 3) {
        title = @"About";
        image = @"ico_about.png";
    } else if (indexPath.row == 4) {
        title = @"Twitter";
        image = @"ico_twitter.png";
    }
    
    cell.textLabel.text = [NSString stringWithFormat:title, indexPath.row];
    UIImage *uiImage = [UIImage imageNamed:image];
    //cell.imageView.image = [self imageWithImage:uiImage scaledToSize:CGSizeMake(30.0, 30.0)];
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
    
    if (indexPath.row == 4) {
        BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?id=lvoug"]];
        
        if (canOpen) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?id=lvoug"]];
        } else {
            NSURL *url = [NSURL URLWithString:@"https://www.twitter.com/lvoug"];
            [[UIApplication sharedApplication] openURL:url];
        }
    } else if (indexPath.row == 3) {
        
        UIViewController *aboutViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"aboutViewController"];
        
        aboutViewController.title = @"About";
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:aboutViewController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

    } else {
        DemoViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DemoViewController"];
        demoViewController.title = [NSString stringWithFormat:@"Demo #%d-%d", indexPath.section, indexPath.row];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:demoViewController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
}

@end