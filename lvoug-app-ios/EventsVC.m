//
//  EventsVC.m
//  lvoug-app-ios
//
//  Created by Daniel Louchansky on 14/02/14.
//  Copyright (c) 2014 LVOUG. All rights reserved.
//

#import "EventsVC.h"

@interface EventsVC ()

@end

@implementation EventsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//table view
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"eventsCell"];
    
    cell.textLabel.text = @"dsdfdsfs";
    cell.detailTextLabel.text = @"wow details";
    cell.imageView.image = [UIImage imageNamed:@"ico_news.png"];
    return cell;
}

@end
