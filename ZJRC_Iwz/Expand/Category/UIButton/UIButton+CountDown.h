//
//  UIButton+CountDown.h
//  ZJRC_Iwz
//
//  Created by Wynter on 15/12/4.
//  Copyright © 2015年 Wynter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountDown)
-(void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle;
@end
