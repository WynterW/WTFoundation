//
//  BasicViewController.m
//  CurrentFundationModel
//
//  Created by Wynter on 15/11/17.
//  Copyright © 2015年 Wynter. All rights reserved.
//

#import "BasicViewController.h"

@implementation BasicViewController
- (void) viewDidLoad
{
    [self.view setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
    
    [self setHidesBottomBarWhenPushed:YES];

    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 60, 30);
    [backBtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = item;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
