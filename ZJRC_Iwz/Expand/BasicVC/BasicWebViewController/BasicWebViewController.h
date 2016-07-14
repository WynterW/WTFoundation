//
//  BasicWebViewController.h
//  ZJRC_Iwz
//
//  Created by Wynter on 15/11/23.
//  Copyright © 2015年 Wynter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"
@interface BasicWebViewController : UIViewController<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (nonatomic,strong) UIWebView *webView;
@end
