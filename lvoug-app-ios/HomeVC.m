//
//  HomeVC.m
//  lvoug-app-ios
//
//  Created by Daniel Louchansky on 16/02/14.
//  Copyright (c) 2014 LVOUG. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.names addObject:@"home1"];
    [self.names addObject:@"home2"];
    [self.names addObject:@"home3"];
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
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    
    cell.textLabel.text = self.names [indexPath.row];
    cell.detailTextLabel.text = @"wow details";
    cell.imageView.image = [UIImage imageNamed:@"ico_news.png"];
    return cell;
}

@end
