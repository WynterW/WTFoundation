//
//  GuidePageViewController.m
//  ShowManyProducts
//
//  Created by Wynter on 16/5/3.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

#import "GuidePageViewController.h"
#import "UIView+Frame.h"

@interface GuidePageViewController ()<UIScrollViewDelegate>{
    UIButton *nextBtn;
    UIButton *jumpBtn;
}

@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _imageAry.count, SCREEN_HEIGHT);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    for (NSInteger i = 0; i < _imageAry.count; ++i) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imgView.image = [UIImage imageNamed:_imageAry[i]];
        [scrollView addSubview:imgView];
        
        NSInteger imgMax = _imageAry.count-1;
        if (i == imgMax) {
            nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [nextBtn addTarget:self action:@selector(jumpAction:) forControlEvents:UIControlEventTouchUpInside];
            nextBtn.frame = CGRectMake(SCREEN_WIDTH*_imageAry.count - (SCREEN_WIDTH/2 + 60), SCREEN_HEIGHT - 100, 120, 30);
            [nextBtn setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            nextBtn.tag = 1003;
            [scrollView addSubview:nextBtn];
        }

    }
    
    jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jumpBtn addTarget:self action:@selector(jumpAction:) forControlEvents:UIControlEventTouchUpInside];
    jumpBtn.frame = CGRectMake(SCREEN_WIDTH - 25 - 40, 40, 40, 40);
    [jumpBtn setBackgroundImage:[UIImage imageNamed:@"jump"] forState:UIControlStateNormal];
    jumpBtn.tag = 1001;
    [self.view addSubview:jumpBtn];
    [self.view bringSubviewToFront:jumpBtn];
}

- (void)jumpAction:(UIButton *)btn{
    
        [self dismissViewControllerAnimated:YES completion:^(){}];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index=scrollView.contentOffset.x/scrollView.frame.size.width;
    NSInteger imgMax = _imageAry.count-1;
    if (index == imgMax) {
        
        [UIView animateWithDuration:.5 animations:^{

            nextBtn.hidden = NO;
            nextBtn.transform = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(1.f, 1.f));
            jumpBtn.transform = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(0.f, 0.f));
            jumpBtn.hidden = YES;
        }];
     
    }else{
        [UIView animateWithDuration:.5 animations:^{
            jumpBtn.hidden = NO;
            jumpBtn.transform = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(1.f, 1.f));
            nextBtn.transform = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(0.f, 0.f));
            nextBtn.hidden = YES;
            
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
