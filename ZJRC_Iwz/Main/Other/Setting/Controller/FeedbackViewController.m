//
//  FeedbackViewController.m
//  ShowManyProducts
//
//  Created by Wynter on 16/5/26.
//  Copyright © 2016年 xiaoming. All rights reserved.
//

#import "FeedbackViewController.h"
#import "MBProgressHUD+Add.h"
#import "IQKeyboardManager.h"

@interface FeedbackViewController ()
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (strong, nonatomic) IBOutlet UITextView *bodyTF;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bodyViewConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lableWidthConstraint;
- (IBAction)sendAction:(id)sender;
- (IBAction)backAction:(id)sender;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _lableWidthConstraint.constant = SCREEN_WIDTH - 30;
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
}

- (IBAction)sendAction:(id)sender {
    
     [_bodyTF resignFirstResponder];
    
    NSString *reason = _bodyTF.text;
    if (reason.length == 0 ) {
        [MBProgressHUD showText:@"反馈内容不能为空" view:self.view afterDelay:2];
        return;
    }else if (reason.length <= 15){
        [MBProgressHUD showText:@"反馈内容不能少于15个字" view:self.view afterDelay:2];
        return;
    }else if (reason.length > 300){
        [MBProgressHUD showText:@"反馈内容不能超过300个字" view:self.view afterDelay:2];
        return;
    }


    
}

- (void)textViewDidChange:(UITextView *)textView
{
    DLog(@"textView === %@",NSStringFromCGSize(textView.contentSize))
    [self setNeedsFocusUpdate];
    if (textView.contentSize.height < 63) {
        _bodyViewConstraint.constant = 63;
    } else {
        _bodyViewConstraint.constant = textView.contentSize.height+3;
    }
    
}

#pragma merk - textViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _placeholderLabel.hidden = YES;
   
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([_bodyTF.text length] == 0)
    {
       _placeholderLabel.hidden = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (textView == _bodyTF) {
        if (text.length == 0) return YES;
        if ([text isEqualToString:@"\n"]) {
            [_bodyTF resignFirstResponder];
            return NO;
        }
        NSInteger existedLength = textView.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = text.length;
        if (existedLength - selectedLength + replaceLength > 300) {
            return NO;
        }
    }
    
    return YES;
}

- (IBAction)backAction:(id)sender {
    [_bodyTF resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}



- (void)dealloc{
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
