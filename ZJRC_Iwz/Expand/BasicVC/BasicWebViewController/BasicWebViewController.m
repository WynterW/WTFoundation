//
//  BasicWebViewController.m
//  ZJRC_Iwz
//
//  Created by Wynter on 15/11/23.
//  Copyright © 2015年 Wynter. All rights reserved.
//

#import "BasicWebViewController.h"
#import "NJKWebViewProgressView.h"
@interface BasicWebViewController (){

    UIWebView *_webView;
    
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

@property (nonatomic, weak) UIButton * backItem;
@property (nonatomic, weak) UIButton * closeItem;

@end

@implementation BasicWebViewController
@synthesize webView = _webView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setHidesBottomBarWhenPushed:YES];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    [_webView setDelegate:self];
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self initNaviBar];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_progressView removeFromSuperview];
}

- (void)initNaviBar{
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 56, 44)];
    [backItem setImage:[UIImage imageNamed:@"navigation_button_back"] forState:UIControlStateNormal];
    [backItem setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backItem setTitle:@"返回" forState:UIControlStateNormal];
    [backItem setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backItem setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.000] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(clickedBackItem:) forControlEvents:UIControlEventTouchUpInside];
    self.backItem = backItem;
    [backView addSubview:backItem];
    
    UIButton * closeItem = [[UIButton alloc]initWithFrame:CGRectMake(44+12, 0, 44, 44)];
    [closeItem setTitle:@"关闭" forState:UIControlStateNormal];
    [closeItem setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.000] forState:UIControlStateNormal];
    [closeItem addTarget:self action:@selector(clickedCloseItem:) forControlEvents:UIControlEventTouchUpInside];
    closeItem.hidden = YES;
    self.closeItem = closeItem;
    [backView addSubview:closeItem];
    
    UIBarButtonItem * leftItemBar = [[UIBarButtonItem alloc]initWithCustomView:backView];
    self.navigationItem.leftBarButtonItem = leftItemBar;
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    DLog(@"url: %@", request.URL.absoluteURL.description);
    
    if (self.webView.canGoBack) {
        self.closeItem.hidden = NO;
    }
    return YES;
}

#pragma mark - clickedBackItem
- (void)clickedBackItem:(UIBarButtonItem *)btn{
    if (self.webView.canGoBack) {
        [self.webView goBack];
        self.closeItem.hidden = NO;
    }else{
        [self clickedCloseItem:nil];
    }
}

#pragma mark - clickedCloseItem
- (void)clickedCloseItem:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}



@end
