//
//  RootViewController.m
//  ZJRC_Iwz
//
//  Created by Wynter on 16/7/14.
//  Copyright © 2016年 Wynter. All rights reserved.
//

#import "RootViewController.h"
#import "BasicNavigationController.h"
#import "HomeViewController.h"
#import "MyCenterViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundColor:DEFAULT_SEARCHBAR_COLOR];
    [self.tabBar setTintColor:DEFAULT_GREEN_COLOR];
    self.tabBarController.tabBar.delegate = self;
    self.delegate = self;
    [self initChildViewControllers];
}

- (void) initChildViewControllers
{
    
    [self setupChildNavigationControllerWithClass:[BasicNavigationController class] tabBarImageName:@"tabbar_mainframe" rootViewControllerClass:[HomeViewController class] rootViewControllerTitle:@"首页"];

    [self setupChildNavigationControllerWithClass:[BasicNavigationController class] tabBarImageName:@"tabbar_me" rootViewControllerClass:[MyCenterViewController class] rootViewControllerTitle:@"我"];
}

- (void)setupChildNavigationControllerWithClass:(Class)class tabBarImageName:(NSString *)name rootViewControllerClass:(Class)rootViewControllerClass rootViewControllerTitle:(NSString *)title
{
    UIViewController *rootVC = [[rootViewControllerClass alloc] init];
    rootVC.title = title;
    UINavigationController *navVc = [[class  alloc] initWithRootViewController:rootVC];
    navVc.tabBarItem.image = [UIImage imageNamed:name];
    navVc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@HL", name]];
    [self addChildViewController:navVc];
}

//push 多层隐藏TableBar
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
}

#pragma mark -- UITabBarDelegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)Item{
    
    
}


@end
