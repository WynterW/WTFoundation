//
//  ChangePassWordViewController.m
//  ShowManyProducts
//
//  Created by nil on 16/2/24.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import "3DESencrypt.h"
#import "LoginViewController.h"
#import "UIView+Frame.h"
#import "MBProgressHUD+Add.h"
@interface ChangePassWordViewController ()<UITextFieldDelegate,UIAlertViewDelegate> {
    //当前密码
    NSString *_currentPassword;
    //新密码
    NSString *_newPassword;
    //确认密码
    NSString *_confirmPassword;
}

@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"修改密码";
    
    CGFloat textFieldHeight = 40;
    UIView *textView = [[UIView alloc]initWithFrame:CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT + 20, SCREEN_WIDTH, textFieldHeight*3)];
    textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textView];
    
    NSArray *titleArray = @[@"旧密码",@"新密码",@"确认密码"];
    NSArray *placeholderArray = @[@"请输入原始密码",@"请输入新密码",@"再次输入新密码"];
    for (int i=0; i<3; i++) {
        
        UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, i*textFieldHeight, 55, textFieldHeight)];
        titleLb.font = [UIFont systemFontOfSize:13];
        titleLb.textColor = UIColorFromRGB(0x353535);
        titleLb.text = titleArray[i];
        [textView addSubview:titleLb];

        UITextField *passWordField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLb.frame)+15, textFieldHeight*i, SCREEN_WIDTH-CGRectGetMaxX(titleLb.frame)-30, 40)];
        if (i==0) {
            [passWordField becomeFirstResponder];
        }
        passWordField.tag = 300+i;
        passWordField.delegate = self;
        passWordField.borderStyle = UITextBorderStyleNone;
        passWordField.secureTextEntry = YES;
        passWordField.backgroundColor = [UIColor clearColor];
        passWordField.textColor = UIColorFromRGB(0x888888);
        passWordField.placeholder = placeholderArray[i];
        passWordField.font = [UIFont systemFontOfSize:13];
        [textView addSubview:passWordField];
        
        UILabel *linkLb = [[UILabel alloc]initWithFrame:CGRectMake(15, i*textFieldHeight, SCREEN_WIDTH - 30, .5)];
        linkLb.backgroundColor = UIColorFromRGB(0xe2e2e2);
         [textView addSubview:linkLb];
        if (i == 0) {
            linkLb.x = 0;
            linkLb.width = SCREEN_WIDTH;
        }
        
    }
    
    UILabel *linkLb = [[UILabel alloc]initWithFrame:CGRectMake(0, textFieldHeight*3, SCREEN_WIDTH , .5)];
    linkLb.backgroundColor = UIColorFromRGB(0xe2e2e2);
    [textView addSubview:linkLb];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(30, CGRectGetMaxY(textView.frame)+20, SCREEN_WIDTH - 60, 40);
    [saveButton addTarget:self action:@selector(savePasswordButton:) forControlEvents:UIControlEventTouchUpInside];
    saveButton.layer.cornerRadius = 4;
    [saveButton setTitle:@"完成" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton setBackgroundColor:RGBA(248, 134, 55, 1)];
    [self.view addSubview:saveButton];
    
    
    //给屏幕添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTap)];
    [self.view addGestureRecognizer:tap];
    
    
}

- (void)screenTap {
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 300) {
        _currentPassword = textField.text;
    }else if (textField.tag == 301) {
        _newPassword = textField.text;
    }else if (textField.tag == 302) {
        _confirmPassword = textField.text;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 12) {
        return NO;
    }
    return YES;

}

- (void)savePasswordButton:(UIButton *)button {
    [self.view endEditing:YES];
    
    if (_currentPassword.length == 0) {
        [MBProgressHUD showText:@"请输入原密码" view:self.view afterDelay:2];
        return ;
    }
    
    if (_currentPassword.length > 12 || _currentPassword.length <6) {
        [MBProgressHUD showText:@"请输入6-12位原密码" view:self.view afterDelay:2];
        return ;
    }
    
    if (_newPassword.length == 0) {
        [MBProgressHUD showText:@"请输入新密码" view:self.view afterDelay:2];
        return;
    }
    if (_newPassword.length > 12 || _newPassword.length <6) {
        
        [MBProgressHUD showText:@"请输入6-12位新密码" view:self.view afterDelay:2];
        return ;
    }
    
    if (_confirmPassword.length == 0) {
        
        [MBProgressHUD showText:@"请输入确认密码" view:self.view afterDelay:2];
        return;
    }
    
    if (_confirmPassword.length > 12 || _confirmPassword.length <6) {
        [MBProgressHUD showText:@"请输入6-12位确认密码" view:self.view afterDelay:2];
        return ;
    }
    
    if (![_newPassword isEqualToString:_confirmPassword]) {
        
        [MBProgressHUD showText:@"您两次输入的密码不同" view:self.view afterDelay:2];
        return;
    }
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
