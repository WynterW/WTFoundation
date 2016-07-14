//
//  LoginView.m
//  ZJRC_iSale
//
//  Created by xiaoming on 13-11-26.
//  Copyright (c) 2013年 xiaoming. All rights reserved.
//

#import "LoginView.h"
#import "UserConfig.h"

@interface LoginView()
- (void)createMainView;
@end

@implementation LoginView 
@synthesize phoneNumberTextField,passwordTextField,delegate;


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        UIControl* c = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [c addTarget:self action:@selector(viewActiondo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:c];
        
        [self createMainView];
        
        
    }
    return self;
}


-(void)createMainView
{
    
    
    UIImage* iconImage = [UIImage imageNamed:@"loginIcon"];
    self.iconImageView =[[UIImageView alloc] initWithFrame:CGRectMake((App_Frame_Width-iconImage.size.width)/2, 0, iconImage.size.width, iconImage.size.height)];
    self.iconImageView.image = iconImage;
    [self addSubview:self.iconImageView];
    
    //用户背景
    self.userNameViewBg = [[UIView alloc] initWithFrame:CGRectMake(35, CGRectGetMaxY(self.iconImageView.frame)+50, App_Frame_Width-70, 45)];
    self.userNameViewBg.backgroundColor = RGBA(0xf5, 0xf5, 0xf5, 1);
    self.userNameViewBg.layer.cornerRadius = 22;//设置那个圆角的有多圆
//    self.userNameViewBg.layer.borderWidth = 5;//设置边框的宽度，当然可以不要
    self.userNameViewBg.layer.borderColor = [[UIColor clearColor] CGColor];//设置边框的颜色
    self.userNameViewBg.layer.masksToBounds = NO;//设为NO去试试
    [self addSubview:self.userNameViewBg];

    
    self.passViewBg = [[UIView alloc] initWithFrame:CGRectMake(35, CGRectGetMaxY(self.userNameViewBg.frame)+25, App_Frame_Width-70, 45)];
    self.passViewBg.backgroundColor = RGBA(0xf5, 0xf5, 0xf5, 1);
    self.passViewBg.layer.cornerRadius = 22;//设置那个圆角的有多圆
    self.passViewBg.layer.borderColor = [[UIColor clearColor] CGColor];//设置边框的颜色
    self.passViewBg.layer.masksToBounds = NO;//设为NO去试试
    [self addSubview:self.passViewBg];
  
    
    
    self.phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(22, 0, self.userNameViewBg.frame.size.width-44, self.userNameViewBg.frame.size.height)];
    self.phoneNumberTextField.placeholder = @"用户名";
    self.phoneNumberTextField.backgroundColor = [UIColor clearColor];
    self.phoneNumberTextField.delegate = self;
    self.phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumberTextField.textAlignment = NSTextAlignmentCenter;
    self.phoneNumberTextField.font = [UIFont systemFontOfSize:16.0];
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    //到配置库里获取手机号
    NSString* userPhoneNumber = [[UserConfig sharedUserConfig] getUserNumber];
    self.phoneNumberTextField.text = userPhoneNumber;

    
    [self.userNameViewBg addSubview:self.phoneNumberTextField];
    
    //密码
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(22, 0, self.passViewBg.frame.size.width-44, self.passViewBg.frame.size.height)];
    self.passwordTextField.placeholder = @"密码";
    self.passwordTextField.backgroundColor = [UIColor clearColor];
    self.passwordTextField.delegate = self;
    self.passwordTextField.keyboardType = UIKeyboardTypeDefault;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.textAlignment = NSTextAlignmentCenter;
    self.passwordTextField.font = [UIFont systemFontOfSize:16.0];
    [self.passViewBg addSubview:self.passwordTextField];
    
    //默认记住密码的
    BOOL rememberPwdCheckType = [[UserConfig sharedUserConfig] isSavePassword];//去配置文件获取
    UIImage* btnlockImage = [UIImage imageNamed:@"btn_lock"];
    if (rememberPwdCheckType)
    {
        btnlockImage = [UIImage imageNamed:@"btn_unlock"];
    }
    
    UIButton *passwordButton =[[UIButton alloc] initWithFrame:CGRectMake(2, 2, btnlockImage.size.width, btnlockImage.size.height)];
    [passwordButton setImage:btnlockImage forState:UIControlStateNormal];
    [passwordButton addTarget:self action:@selector(isSavePasswordButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.passViewBg addSubview:passwordButton];
    
    //获取的记住密码
    if (!rememberPwdCheckType && [userPhoneNumber length] >0)
    {
        NSString* userPassWord = [[UserConfig sharedUserConfig] getUserPassword];
        if ([userPassWord length]  > 0)
        {
            self.passwordTextField.text = userPassWord;
        }
        
    }
    
    self.goWorkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.goWorkButton.backgroundColor = RGBA(0xff, 0x94, 0x2a, 1);
    [self.goWorkButton setTitle:@"登 录" forState:UIControlStateNormal];
    self.goWorkButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.goWorkButton.layer setMasksToBounds:YES];
    [self.goWorkButton.layer setCornerRadius:22]; //设置矩形四个圆角半径
    [self.goWorkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.goWorkButton.frame = CGRectMake(35, CGRectGetMaxY(self.passViewBg.frame)+24, App_Frame_Width-70, 45);
    self.goWorkButton.tag = LoginButton;
    [self.goWorkButton addTarget:self action:@selector(didSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.goWorkButton];

    
    
    //忘记密码
    self.fPassBtn = [[UIButton alloc] initWithFrame:CGRectMake((App_Frame_Width-80)/2, CGRectGetMaxY(self.goWorkButton.frame)+15, 80.f, 20.f)];
    self.fPassBtn.backgroundColor = [UIColor clearColor];
    self.fPassBtn.tag = FPasswordButton;
    [self.fPassBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.fPassBtn setTitleColor:RGBA(0xbb, 0xbb, 0xbb, 1) forState:UIControlStateNormal];
    self.fPassBtn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [self.fPassBtn addTarget:self action:@selector(didSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.fPassBtn];


}

-(void)isSavePasswordButton:(id)sender
{
    
    UIButton* passwordButton = (UIButton*)sender;
    
    BOOL rememberPwdCheckType = [[UserConfig sharedUserConfig] isSavePassword];//去配置文件获取
    
    UIImage* btnlockImage = [UIImage imageNamed:@"btn_lock"];
    if (!rememberPwdCheckType)
    {
        btnlockImage = [UIImage imageNamed:@"btn_unlock"];
    }
    [passwordButton setImage:btnlockImage forState:UIControlStateNormal];
    
    [[UserConfig sharedUserConfig] setSavePassword:!rememberPwdCheckType];

}

-(void)viewActiondo:(id)sender
{
    if ([delegate respondsToSelector:@selector(didSelectButtonWithType:)]) {
        [delegate didSelectButtonWithType:TouchView];
    }

}

- (void)didSelectButton:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    ButtonType type = (int)btn.tag;
    if ([delegate respondsToSelector:@selector(didSelectButtonWithType:)]) {
        [delegate didSelectButtonWithType:type];
    }
}




#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneNumberTextField) {
        if ((range.location+string.length)>11) {
            return NO;
        }
    }
    
    return YES;
}



// return NO to disallow editing.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    if ([delegate respondsToSelector:@selector(LoginViewTextFieldShouldBeginEditing:)])
    {
        [delegate LoginViewTextFieldShouldBeginEditing:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if ([delegate respondsToSelector:@selector(LoginViewTextFieldShouldReturn:)])
    {
        [delegate LoginViewTextFieldShouldReturn:textField];
    }
    
    
    return YES;
}


@end
