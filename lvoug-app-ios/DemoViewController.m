//
//  DemoViewController.m
//  MFSideMenuDemoStoryboard
//
//  Created by Michael Frederick on 4/9/13.
//  Copyright (c) 2013 Michael Frederick. All rights reserved.
//

#import "DemoViewController.h"
#import "MFSideMenu.h"

@implementation DemoViewController

#pragma mark -
#pragma mark - UITableViewDataSource

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self.names addObject:@"Daniel"];
    [self.names addObject:@"Alex"];
    [self.names addObject:@"Deemah"];
}

- (IBAction)showLeftMenuPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
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
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"reusableCell1"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reusableCell1"];
    }
    
    cell.textLabel.text = self.names [indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"ico_news.png"];
    return cell;
}

@end
