//
//  APIStringMacros.h
//  ZJRC_Iwz
//
//  Created by Wynter on 15/11/19.
//  Copyright © 2015年 Wynter. All rights reserved.
//

#ifndef APIStringMacros_h
#define APIStringMacros_h
#ifdef DEBUG
//Debug状态下的测试API
#define API_BASE_URL_STRING     @"http://www.test.com/api/"

#else
//Release状态下的线上API
#define API_BASE_URL_STRING     @"http://www.test2.com/api/"

#endif

// 接口路径全拼
#define PATH(_path) [NSString stringWithFormat:_path, API_BASE_URL_STRING]

//接口
#define LOGINOUT               PATH(@"common/logout")           //登出

#endif /* APIStringMacros_h */
