//
//  UserData.m
//  ShowManyProducts
//
//  Created by Wynter on 16/2/22.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

#import "UserData.h"

@implementation UserData
singleton_implementation(UserData);

- (void)outLogin{
        
    UserData *userData = [[UserData alloc]init];
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; ++i) {
        Ivar ivar = ivars[i];
        object_setIvar(userData, ivar, nil);
    }
    free(ivars);
}
@end
