//
//  MyCenterViewController.m
//  CurrentFundationModel
//
//  Created by Wynter on 15/11/17.
//  Copyright © 2015年 Wynter. All rights reserved.
//

#import "MyCenterViewController.h"
#import "SettingViewController.h"

@implementation MyCenterViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"设置" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(setAction:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
}

- (void)setAction:(id)sender{
    SettingViewController *vc = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

@end
