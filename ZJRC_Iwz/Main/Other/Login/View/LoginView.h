//
//  LoginView.h
//  ZJRC_iSale
//
//  Created by xiaoming on 13-11-26.
//  Copyright (c) 2013年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma mark - 按钮类型
typedef enum
{
    //登录界面
    LoginButton = 10,       //登录按钮
    RememberButton,         //记住密码
    FPasswordButton,             //忘记密码
    TouchView, //点击空白的view
}ButtonType;

@protocol LoginViewDelegate <NSObject>

-(void)didSelectButtonWithType:(ButtonType)type;

- (BOOL)LoginViewTextFieldShouldBeginEditing:(UITextField *)textField;
- (BOOL)LoginViewTextFieldShouldReturn:(UITextField *)textField;
@end


@interface LoginView : UIView<UITextFieldDelegate>
{
    __unsafe_unretained id<LoginViewDelegate> delegate;
    UITextField* phoneNumberTextField;
    UITextField* passwordTextField;
}
@property (nonatomic,assign)    id<LoginViewDelegate> delegate;
@property (strong,nonatomic) UITextField* phoneNumberTextField;
@property (strong,nonatomic) UITextField* passwordTextField;

@property (strong,nonatomic) UIImageView *iconImageView;
@property (strong,nonatomic) UIView* userNameViewBg;
@property (strong,nonatomic) UIView* passViewBg;
@property (strong,nonatomic) UIButton *goWorkButton;
@property (strong,nonatomic) UIButton* fPassBtn;

@end
