//
//  SetConfig.h
//  ZJRC_Iwz
//
//  Created by Wynter on 15/11/23.
//  Copyright © 2015年 Wynter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetConfig : NSObject
/**
 *  获取缓存大小
 */
+ (NSString *)cacheString;

/**
 *  清除缓存
 */
+ (void)clearCache:(void(^)())_block;
@end
