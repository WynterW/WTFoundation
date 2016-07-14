//
//  UIManage.m
//  ZJRC_Iwz
//
//  Created by Wynter on 16/7/14.
//  Copyright © 2016年 Wynter. All rights reserved.
//

#import "UIManage.h"
#import "LoginViewController.h"
#import "RootViewController.h"
#import "BasicNavigationController.h"
#import "AppDelegate.h"

@implementation UIManage
+ (void)showLoginPage{
    
    LoginViewController* loginPage = [[LoginViewController alloc] init];
    BasicNavigationController* nav = [[BasicNavigationController alloc] initWithRootViewController:loginPage];
    APPDELEGETE.window.rootViewController = nav;
}

+ (void)showMianPage{
    
    RootViewController *rootVC = [[RootViewController alloc]init];
    APPDELEGETE.window.rootViewController = rootVC;
}


+ (void)showNewFeaturesPage{
    
    
}

#pragma mark 退出登录
+ (void)outLogin{

}
@end
