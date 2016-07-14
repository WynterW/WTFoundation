//
//  UserConfig.h
//  ZJRC_PinZhong
//
//  Created by Wynter on 16/1/23.
//  Copyright © 2016年 Wynter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserConfig : NSObject{

    NSMutableDictionary *_userConfigs;

}
singleton_interface(UserConfig);


/**
 *  保存用户账号和密码
 *
 *  @param userName 用户账号
 *  @param password 用户密码
 */
- (void)saveUserName:(NSString *)userName password:(NSString *)password;

/**
 *  获取用户账号
 *
 *  @return 用户账号
 */
-(NSString*)getUserNumber;

/**
 *  请求用户密码
 *
 *  @return 返回用户密码
 */
-(NSString*)getUserPassword;

/**
 *  是否自动登陆
 *
 *  @return YES或NO
 */
-(BOOL)isAutoLogin;

/**
 *  是否保存密码
 *
 *  @return YES或NO
 */
-(BOOL)isSavePassword;

/**
 *  设置自动登陆状态
 *
 *  @param bAutoLogin
 */
-(void)setAutoLogin:(BOOL)bAutoLogin;

/**
 *  设置保存密码状态
 *
 *  @param bSavePassword 
 */
-(void)setSavePassword:(BOOL)bSavePassword;


/**
 *  删除用户密码
 *
 *  @param userName 用户名称
 */
-(void)deletePasswordWithUserName:(NSString*)userName;

@end
