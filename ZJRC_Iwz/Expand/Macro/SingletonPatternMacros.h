//
//  SingletonPatternMacros.h
//  ZJRC_Iwz
//
//  Created by Wynter on 15/11/19.
//  Copyright © 2015年 Wynter. All rights reserved.
//  单例模式宏定义


#ifndef SingletonPatternMacros_h
#define SingletonPatternMacros_h

// @interface
#define singleton_interface(className) \
+ (className *)shared##className;

// @implementation
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}


#endif /* SingletonPatternMacros_h */
