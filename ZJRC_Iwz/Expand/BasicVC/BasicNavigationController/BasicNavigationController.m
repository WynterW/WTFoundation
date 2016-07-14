//
//  BasicNavigationController.m
//  ZJRC_Iwz
//
//  Created by Wynter on 16/7/14.
//  Copyright © 2016年 Wynter. All rights reserved.
//

#import "BasicNavigationController.h"

@interface BasicNavigationController ()

@end

@implementation BasicNavigationController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:DEFAULT_NAVBAR_COLOR];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.view setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

@end
