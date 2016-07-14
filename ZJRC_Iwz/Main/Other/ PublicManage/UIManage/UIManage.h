//
//  UIManage.h
//  ZJRC_Iwz
//
//  Created by Wynter on 16/7/14.
//  Copyright © 2016年 Wynter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIManage : NSObject
/**
 *  显示登陆界面
 */
+ (void)showLoginPage;

/**
 *  登陆后的界面
 */
+ (void)showMianPage;

/**
 *  新特性界面(功能介绍页)
 */
+ (void)showNewFeaturesPage;

/**
 *  退出登陆切换到登陆界面
 */
+ (void)outLogin;
@end
