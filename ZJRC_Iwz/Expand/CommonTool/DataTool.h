//
//  DataTool.h
//  ZJRC_Iwz
//
//  Created by Wynter on 15/11/23.
//  Copyright © 2015年 Wynter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTool : NSObject
#pragma mark -UserDefaults 数据存取
/**
 *  获取内容
 *
 *  @param itemKey key
 *
 *  @return 返回key对应内容
 */
+ (id)itemForKey:(NSString *)itemKey;

/**
 *  保存内容
 *
 *  @param data    要存储的内容个
 *  @param itemKey 存储的key
 */
+ (void)saveItemData:(id)data itemKey:(NSString *)itemKey;

/**
 *  jsonData转字典
 *
 *  @param jsonData json类型的data
 *
 *  @return 返回字典
 */
+ (NSDictionary *)dictionaryTOJsonData:(NSData*)jsonData;

/**
 *  字典转字符串
 *
 *  @param dic 字典
 *
 *  @return 字符串
 */
+ (NSString *)stringToDictionary:(NSDictionary *)dic;

@end
