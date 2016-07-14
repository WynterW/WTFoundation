//
//  DataTool.m
//  ZJRC_Iwz
//
//  Created by Wynter on 15/11/23.
//  Copyright © 2015年 Wynter. All rights reserved.
//

#import "DataTool.h"

@implementation DataTool

#pragma mark - UserDefaults
+ (id)itemForKey:(NSString *)itemKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:itemKey];
}

+ (void)saveItemData:(id)data itemKey:(NSString *)itemKey
{
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:itemKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - jsonKit

+ (NSDictionary *)dictionaryTOJsonData:(NSData*)jsonData{
    NSDictionary *resultDict = [jsonData objectFromJSONData];
    DLog(@"返回结果：%@",resultDict);
    return resultDict;
}

+ (NSString *)stringToDictionary:(NSDictionary *)dic{
    
    NSString *jsonStr = [dic JSONString];
    DLog(@"返回结果：%@",jsonStr);
    return jsonStr;
}



@end
