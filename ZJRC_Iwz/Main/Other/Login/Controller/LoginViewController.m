//
//  LoginViewController.m
//  ZJRC_iSale
//
//  Created by xiaoming on 13-11-21.
//  Copyright (c) 2013年 xiaoming. All rights reserved.
//

#import "LoginViewController.h"
#import "UserConfig.h"
#import "UserData.h"
#import "3DESencrypt.h"
#import<CoreTelephony/CTTelephonyNetworkInfo.h>
#import<CoreTelephony/CTCarrier.h>
#import "NSString+RegexCategory.h"

@interface LoginViewController (){
    NSString *password;
}

@property (nonatomic,strong) LoginView* loginView;


@end

@implementation LoginViewController
@synthesize versionUrl;
 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.navigationController.navigationBarHidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBarHidden = NO;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIControl* c = [[UIControl alloc] initWithFrame:self.view.frame];
    [c addTarget:self action:@selector(actiondo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:c];
    
    [self createLoginView];

    _bOnKeyboard = NO;
    
    
    NSString* userPhoneNumber = [[UserConfig sharedUserConfig] getUserNumber];
    NSString* userPassWord = [[UserConfig sharedUserConfig] getUserPassword];
    if ([userPhoneNumber length] > 0 && [userPassWord length] > 0 && [[UserConfig sharedUserConfig] isAutoLogin])
    {
        [self loginRep];
    }
    
}

-(void)actiondo:(id)sender
{
    [self.view endEditing:YES];
    
    
    [self clickedKeyBoard:NO];
    
    
    
}

-(void)autoLogin
{
    [self didSelectButtonWithType:LoginButton];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)createLoginView
{
    
    CGRect frame = CGRectMake(0.f, 100.f, App_Frame_Width, 360.f);
    
    self.loginView = [[LoginView alloc] initWithFrame:frame];
    self.loginView.backgroundColor = [UIColor whiteColor];
    self.loginView.delegate = self;
    [self.view addSubview:self.loginView];
    
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT-25, SCREEN_WIDTH-20, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"中国移动";
    label.textColor = RGBA(0xbb, 0xbb, 0xbb, 1);
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    

   
}


-(void)didSelectButtonWithType:(ButtonType)type
{
    
    
    switch (type)
    {
        case LoginButton:
        {
            NSString* phone = self.loginView.phoneNumberTextField.text;
            NSString* pwd = self.loginView.passwordTextField.text;
            if (phone.length == 0)
            {
                [MBProgressHUD showText:@"手机号码不能为空" view:self.view afterDelay:2];
                return;
            }
            if (pwd.length == 0)
            {
 
                [MBProgressHUD showText:@"密码不能为空" view:self.view afterDelay:2];
                return;
            }
            
            if (pwd.length > 12 || pwd.length < 6)
            {
                [MBProgressHUD showText:@"密码长度为6-12位" view:self.view afterDelay:2];
                return;
            }
            
            BOOL isOK = [phone isMobileNumber];
            if (!isOK)
            {

                [MBProgressHUD showText:@"请输入正确的手机号码" view:self.view afterDelay:2];
                return;
            }
            
            
            [self loginRep];
            
        }
            break;
        case TouchView:
        {
            [self actiondo:nil];
        }
            break;
        case FPasswordButton:
        {
            //忘记密码

            
        }
            break;
        default:
            break;
    }
}


-(void)loginRep
{
    /*
     {
     "phoneno": "手机号码",
     "password": "加密后的密码",
     "devicecode": "手机内码/sim卡imsi号",
     "devicetype": 客户端类型(0:android 1:ios)
     }
     */
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];

    params[@"loginname"] = self.loginView.phoneNumberTextField.text;
    NSString* pass = self.loginView.passwordTextField.text;
    NSString* passWord = [_DESencrypt TripleDES:pass encryptOrDecrypt:kCCEncrypt];


    params[@"password"] = passWord;
    params[@"devicetype"] = @"1";
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在登录...";
    [hud hide:YES afterDelay:20];
    
    NSString* userPhoneNumber = self.loginView.phoneNumberTextField.text;
    NSString* userPassWord = self.loginView.passwordTextField.text;
    BOOL rememberPwdCheckType = NO;//去配置文件获取
    rememberPwdCheckType = [[UserConfig sharedUserConfig] isSavePassword];
    if (!rememberPwdCheckType) {
        //登陆成功后 进入主页并且记录登陆信息
        [[UserConfig sharedUserConfig] saveUserName:userPhoneNumber password:userPassWord];
        [[UserConfig sharedUserConfig] setAutoLogin:YES];
    }else{
        [[UserConfig sharedUserConfig] setAutoLogin:NO];
        [[UserConfig sharedUserConfig] saveUserName:userPhoneNumber password:@""];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
        [UIManage showMianPage];
    });

    
}


#pragma mark -
#pragma mark keyBoard
//Hide the keyboard
-(void)clickedKeyBoard:(BOOL)isEdit
{
    [UIView beginAnimations:@"edit change" context:nil];
    [UIView setAnimationDuration:0.5];
    [self putOnEdit:isEdit];
    [UIView commitAnimations];
    [self.view endEditing:YES];
    
}
#pragma mark -
#pragma mark textfield
-(void)resetViewSize
{
    float y = 60;
    
    if (_bOnKeyboard)
    {
        self.loginView.frame = CGRectMake(self.loginView.frame.origin.x, self.loginView.frame.origin.y - y, self.loginView.frame.size.width, self.loginView.frame.size.height);
        
        
        self.loginView.iconImageView.frame = CGRectMake((App_Frame_Width-self.loginView.iconImageView.frame.size.width/2)/2, self.self.loginView.iconImageView.frame.origin.y, self.loginView.iconImageView.frame.size.width/2, self.loginView.iconImageView.frame.size.height/2);
        
        self.loginView.userNameViewBg.frame = CGRectMake(35, CGRectGetMaxY(self.loginView.iconImageView.frame)+16, App_Frame_Width-70, 45);
        
        self.loginView.passViewBg.frame = CGRectMake(35, CGRectGetMaxY(self.loginView.userNameViewBg.frame)+20, App_Frame_Width-70, 45);
        
        self.loginView.goWorkButton.frame = CGRectMake(35, CGRectGetMaxY(self.loginView.passViewBg.frame)+20, App_Frame_Width-70, 45);
        
        
        self.loginView.fPassBtn.frame  = CGRectMake((App_Frame_Width-80)/2, CGRectGetMaxY(self.loginView.goWorkButton.frame)+15, 80.f, 20.f);
        
    }
    else
    {
        
        self.loginView.frame = CGRectMake(self.loginView.frame.origin.x, self.loginView.frame.origin.y + y, self.loginView.frame.size.width, self.loginView.frame.size.height);
        
        UIImage* iconImage = self.loginView.iconImageView.image;
        self.loginView.iconImageView.frame = CGRectMake((App_Frame_Width-iconImage.size.width)/2, 0, iconImage.size.width, iconImage.size.height);
        
        self.loginView.userNameViewBg.frame = CGRectMake(35, CGRectGetMaxY(self.loginView.iconImageView.frame)+50, App_Frame_Width-70, 45);
        
        self.loginView.passViewBg.frame = CGRectMake(35, CGRectGetMaxY(self.loginView.userNameViewBg.frame)+25, App_Frame_Width-70, 45);
        
        self.loginView.goWorkButton.frame = CGRectMake(35, CGRectGetMaxY(self.loginView.passViewBg.frame)+24, App_Frame_Width-70, 45);
        
        self.loginView.fPassBtn.frame  = CGRectMake((App_Frame_Width-80)/2, CGRectGetMaxY(self.loginView.goWorkButton.frame)+15, 80.f, 20.f);
        
        
        
    }
    
}

-(void)putOnEdit:(BOOL)bOn
{
    if (_bOnKeyboard != bOn)
    {
        //键盘弹出时试图往上挪
        _bOnKeyboard = bOn;
        
        [self resetViewSize];
        
    }
    
}

- (BOOL)LoginViewTextFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"edit change" context:nil];
    [UIView setAnimationDuration:0.5];
    [self putOnEdit:YES];
    [UIView commitAnimations];
    
    return YES;
}
- (BOOL)LoginViewTextFieldShouldReturn:(UITextField *)textField
{
    [UIView beginAnimations:@"edit change" context:nil];
    [UIView setAnimationDuration:0.5];
    [self putOnEdit:NO];
    [UIView commitAnimations];
    
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
    
    return YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
