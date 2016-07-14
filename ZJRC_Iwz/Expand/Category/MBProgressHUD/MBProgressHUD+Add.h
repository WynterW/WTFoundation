//
//  MBProgressHUD+Add.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)


/**
 *  显示错误
 *
 *  @param error 错误内容
 *  @param view  加载的View
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;

/**
 *  显示成功
 *
 *  @param success 成功提示语
 *  @param view    加载的View
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
/**
 *  自定义提示框
 *
 *  @param text 显示文本
 *  @param icon 显示图片
 *  @param view 加载的View
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

/**
 *  普通的加载提示框带菊花
 *
 *  @param message 显示文本
 *  @param view    加载的视图
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;

/**
 *  纯文本提示框
 *
 *  @param text  显示文本
 *  @param view  加载的视图
 *  @param delay 几秒后消失
 */
+ (void)showText:(NSString *)text view:(UIView *)view afterDelay:(CGFloat)delay;
@end
