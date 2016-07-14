//
//  UserData.h
//  ShowManyProducts
//
//  Created by Wynter on 16/2/22.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface UserData : NSObject

singleton_interface(UserData);


@property (nonatomic,strong) NSString  *username;/**< 用户名称*/

@property (nonatomic,assign) NSInteger  userid;/**< 用户id*/

@property (nonatomic,strong) NSString  *upgrade;/**< 自动强制升级(0:否 1:是)*/

@property (nonatomic,assign) NSInteger deptid;/**< 部门ID(Integer)*/

@property (nonatomic,strong) NSString  *clientdownloadurl;/**< 客户端下载地址*/

@property (nonatomic,strong) NSString  *clientversion;/**< 客户端下载版本号*/

@property (nonatomic,strong) NSString  *datascope;/**< 数据范围*/

@property (nonatomic,strong) NSString  *deptlevelcode;/**< 部门等级编码*/

@property (nonatomic,strong) NSString  *isaudit;/**< 模块审核权限*/

@property (nonatomic,strong) NSString  *nowdate;/**< 登录服务端时间*/

@property (nonatomic,strong) NSString  *rolemodel;/**< 角色查看模式*/

@property (nonatomic,strong) NSString  *token;/**< 用户token*/

@property (nonatomic,strong) NSString  *loginName;/**< IM用户Id*/

// 未校验
@property (nonatomic,strong) NSString  *userIcon;/**< 用户头像*/

@property (nonatomic,strong) NSString  *PhoneNumber;/**< 手机号码*/

@property (nonatomic,strong) NSString  *grade;/**< 等级*/

@property (nonatomic,strong) NSString  *department;/**< 部门*/

@property (nonatomic,strong) NSString  *integralNumber;/**< 积分值*/

@property (nonatomic,strong) NSString  *contributNumber;/**< 贡献值*/

@property (nonatomic,strong) NSString  *productNumber;/**< 产品数量*/

@property (nonatomic,assign) NSInteger userRoot;/**< 用户权限*/

@property (nonatomic,strong) NSString  *userAddres;/**< 用户位置*/



/**
 *  注销登陆
 */
- (void)outLogin;
@end

