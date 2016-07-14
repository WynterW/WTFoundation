//
//  SettingViewController.m
//  ShowManyProducts
//
//  Created by nil on 16/2/24.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

#import "SettingViewController.h"
#import "GuidePageViewController.h"
#import "ChangePassWordViewController.h"
#import "FeedbackViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    UIImage *image = [UIImage imageNamed:@"setIcon"];
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.frame = CGRectMake((SCREEN_WIDTH-imageWidth)/2, 64+31, imageWidth, imageHeight);
    logoImageView.image = image;
    
    [self.view addSubview:logoImageView];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake((SCREEN_WIDTH-180)/2,  CGRectGetMaxY(logoImageView.frame)+25, 180, 20);
    label1.textColor = RGBA(0x12, 0x12, 0x12, 1);
    label1.text = @"品众";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake((SCREEN_WIDTH-100)/2,  CGRectGetMaxY(label1.frame)+10, 100, 20);
    label2.text = [NSString stringWithFormat:@"版本 V%@",APPBundleVersion];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = RGBA(0x88, 0x88, 0x88, 1);
    label2.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label2];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame)+25, SCREEN_WIDTH, 150) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"ident";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    cell.textLabel.textColor = UIColorFromRGB(0x353535);
    cell.textLabel.font = [UIFont systemFontOfSize:14];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"引导页";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"修改密码";
    }else if (indexPath.row == 2){
    cell.textLabel.text = @"意见反馈";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        GuidePageViewController *vc = [[GuidePageViewController alloc]init];
        vc.imageAry = @[@"LaunchImage-800-667h",@"LaunchImage-800-667h",@"LaunchImage-800-667h"];
        [self presentViewController:vc animated:YES completion:^{}];

    }else if (indexPath.row == 1) {
        ChangePassWordViewController *changePasswordVC = [ChangePassWordViewController new];
        [self.navigationController pushViewController:changePasswordVC animated:YES];
    }else if (indexPath.row == 2){
        FeedbackViewController *vc = [[FeedbackViewController alloc]init];
        [self presentViewController:vc animated:YES completion:^{}];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
