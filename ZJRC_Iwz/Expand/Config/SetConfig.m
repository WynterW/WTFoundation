//
//  SetConfig.m
//  ZJRC_Iwz
//
//  Created by Wynter on 15/11/23.
//  Copyright © 2015年 Wynter. All rights reserved.
//

#import "SetConfig.h"
#import "SDImageCache.h"

@implementation SetConfig

#pragma mark - SDImageCache
+ (NSString *)cacheString{
    
    float  cacheSize;
    SDImageCache *cache = [[SDImageCache alloc]init];
    NSInteger cacheDate = [cache getSize];
    if (cacheDate >0) {
        cacheSize = cacheDate/1000000;
    }else{
        cacheSize = 0;
    }
    NSString *cacheStr = (NSString *)[NSString stringWithFormat:@"%.2f",cacheSize];
    DLog(@"缓存数据工：%@MB",cacheStr);
    return cacheStr;
}

+ (void)clearCache:(void(^)())_block{
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^(){
        DLog(@"清除完成");
        _block();
    }];
}

#pragma mark - 

@end
