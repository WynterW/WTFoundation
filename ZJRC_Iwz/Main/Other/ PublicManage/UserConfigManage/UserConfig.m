//
//  UserConfig.m
//  ZJRC_PinZhong
//
//  Created by Wynter on 16/1/23.
//  Copyright © 2016年 Wynter. All rights reserved.
//

#import "UserConfig.h"
#import "3DESencrypt.h"
#import "AGSecurity.h"

#define _IS_SAVE_PASSWORD_KEY @"ISSAVEPASSWORD"
#define _IS_AUTO_LOGIN_KEY    @"ISAUTOLOGIN"
#define _USER_NAME_KEY        @"USERNAME"
#define _PASSWORD_KEY         @"PASSWORD"

@implementation UserConfig
singleton_implementation(UserConfig);

-(id)init
{
    _userConfigs = [[NSMutableDictionary alloc] initWithContentsOfFile:[self getConfigFile]];
    if (_userConfigs == nil)
    {
        _userConfigs = [[NSMutableDictionary alloc] initWithCapacity:10];
        
//        [self setAutoLogin:NO];
//        [self setSavePassword:NO];
        
        [self saveConfigerData];
    }
    
    return self;
}

#pragma mark 保存用户账号密码
- (void)saveUserName:(NSString *)userName password:(NSString *)password{
    
    if (![self isSavePassword]) {
        
        NSString* userNameDES = [_DESencrypt TripleDES:userName encryptOrDecrypt:kCCEncrypt];
        NSString* passWordDES = [_DESencrypt TripleDES:password encryptOrDecrypt:kCCEncrypt];
        [_userConfigs setObject:userNameDES forKey:_USER_NAME_KEY];
        
        
        if (password)
        {
            //存密码至 keychain
            NSError* error = nil;
            [SFHFKeychainUtils storeUsername:userNameDES
                                 andPassword:passWordDES
                              forServiceName:_PASSWORD_KEY
                              updateExisting:YES error:&error];
            if (error)
            {
                NSLog(@"stroe error: = %@",error);
            }
        }
    }else{
        
        NSString* userNameDES = [_DESencrypt TripleDES:userName encryptOrDecrypt:kCCEncrypt];
        [_userConfigs setObject:userNameDES forKey:_USER_NAME_KEY];
        
        NSString* phoneNumber = [NSString stringWithFormat:@"%@",[_userConfigs objectForKey:_USER_NAME_KEY]];
        [self deletePasswordWithUserName:phoneNumber];
    
    }
    
    [self saveConfigerData];

}


-(NSString*)getUserNumber
{
    NSString* phoneNumber = [NSString stringWithFormat:@"%@",[_userConfigs objectForKey:_USER_NAME_KEY]];
    NSString* userNameDES = [_DESencrypt TripleDES:phoneNumber  encryptOrDecrypt:kCCDecrypt];
    return userNameDES;
}


-(NSString*)getUserPassword;
{
    
    NSString* phoneNumber = [NSString stringWithFormat:@"%@",[_userConfigs objectForKey:_USER_NAME_KEY]];
    NSString* password = [self passwordWithUserName:phoneNumber];
    NSString* passwordDES = [_DESencrypt TripleDES:password  encryptOrDecrypt:kCCDecrypt];
    return passwordDES;
}


#pragma mark -
#pragma mark 获得用户配置的方法

-(BOOL)isAutoLogin
{
    BOOL isAutoLogin = [(NSNumber*)[_userConfigs objectForKey:_IS_AUTO_LOGIN_KEY] boolValue];
    return isAutoLogin;
    
}

-(BOOL)isSavePassword
{
    BOOL isSavePassword = [(NSNumber*)[_userConfigs objectForKey:_IS_SAVE_PASSWORD_KEY] boolValue];
    return isSavePassword;
}


#pragma mark -
#pragma mark 设置用户配置的方法
-(void)setAutoLogin:(BOOL)bAutoLogin
{
    [_userConfigs setObject:[NSNumber numberWithBool:bAutoLogin] forKey:_IS_AUTO_LOGIN_KEY];
    [self saveConfigerData];
}

-(void)setSavePassword:(BOOL)bSavePassword
{
    [_userConfigs setObject:[NSNumber numberWithBool:bSavePassword] forKey:_IS_SAVE_PASSWORD_KEY];
    if (!bSavePassword) {
        NSString* phoneNumber = [NSString stringWithFormat:@"%@",[_userConfigs objectForKey:_USER_NAME_KEY]];
        [self deletePasswordWithUserName:phoneNumber];
    }
    [self saveConfigerData];
}

#pragma mark 得到存储用户数据的plist文件
-(NSString*)getConfigFile
{
    return [NSString stringWithFormat:@"%@/userConfig.plist",kPathDocument];

}

#pragma mark 保存用户配置数据
-(void)saveConfigerData
{
    [_userConfigs writeToFile:[self getConfigFile] atomically:YES];
}

#pragma mark keychain操作
//得到keychain中用户的密码
-(NSString*)passwordWithUserName:(NSString*)userName
{
    NSString* strPassword =	[SFHFKeychainUtils getPasswordForUsername:userName
                                                       andServiceName:_PASSWORD_KEY
                                                                error:nil];
    return strPassword;
}

//删除keychain中密码
-(void)deletePasswordWithUserName:(NSString*)userName
{
    if ([userName length] > 0)
    {
        [SFHFKeychainUtils deleteItemForUsername:userName andServiceName:_PASSWORD_KEY error:nil];
    }
}
@end
