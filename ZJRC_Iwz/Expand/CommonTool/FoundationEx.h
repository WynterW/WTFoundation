//
//  FoundationEx.h
//  ZJRC_Iwz
//
//  Created by Wynter on 16/7/14.
//  Copyright © 2016年 Wynter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoundationEx : NSObject


//自动布局
+ (CGRect)autoSizeScale:(CGRect)frame;

+ (float)autoScaleY;


//时间格式转换
+(NSDate*)getDateFromString:(NSString*)myDate;

//检查字符串是否为数字
+(BOOL)isNumber:(NSString*)string;

#pragma mark --- 保存图片相关操作

// 根据图片路径保存图片 返回图片名称
+(NSString *)saveImageAtPath:(UIImage *)img;

//获取目录下文件大小
+(long long) fileSizeAtPath:(NSString*) fileName;

// 根据相对路径加载图片
+(UIImage *)loadImageAtPath:(NSString *)imageNmae;

//清除缓存
+ (BOOL)removeImageAtPath;

/**
 *  根据色值和大小生生Image
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

#pragma mark --- 保存图片相关操作



//检查是否有特殊字符(< > & % $ ^ ~ \\\\)如果有按照服务端规则替换
+(NSString*)checkSendString:(NSString*)string;
//检查收到的字符，如果有转化的字符串，反处理
+(NSString*)checkReceiveString:(NSString*)string;


//json解析
+(NSDictionary*)DXParseJSON:(NSData*)data;

#pragma mark - 限制系统表情
+ (BOOL)stringContainsEmoji:(NSString *)string;


@end
