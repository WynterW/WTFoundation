//
//  LoginViewController.h
//  ZJRC_Iwz
//
//  Created by xiaoming on 13-11-21.
//  Copyright (c) 2013年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginView.h"


@interface LoginViewController : UIViewController<LoginViewDelegate,UIAlertViewDelegate>
{
    BOOL _bOnKeyboard;
    NSString* versionUrl;
    
    UIScrollView *_scrollView;
}
@property (nonatomic, copy) NSString* versionUrl;

@end
