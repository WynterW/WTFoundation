//
//  BasicTableViewController.m
//  CurrentFundationModel
//
//  Created by Wynter on 15/11/17.
//  Copyright © 2015年 Wynter. All rights reserved.
//

#import "BasicTableViewController.h"

@implementation BasicTableViewController
- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[UIView new]];
    [self.view setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
    [self.tableView setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
    
    [self setHidesBottomBarWhenPushed:YES];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
@end
