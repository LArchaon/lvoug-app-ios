//
//  BaseFirstLevelVC.m
//  lvoug-app-ios
//
//  Created by Daniel Louchansky on 13/02/14.
//  Copyright (c) 2014 LVOUG. All rights reserved.
//

#import "BaseFirstLevelTVC.h"
#import "MFSideMenu.h"

@interface BaseFirstLevelTVC ()

@end

@implementation BaseFirstLevelTVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)showLeftMenuPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
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

@end
