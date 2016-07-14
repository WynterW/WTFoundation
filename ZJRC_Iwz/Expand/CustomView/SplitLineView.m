//
//  SplitLineView.m
//  ZJRC_Iwz
//
//  Created by Wynter on 16/7/14.
//  Copyright © 2016年 Wynter. All rights reserved.
//

#import "SplitLineView.h"

@implementation SplitLineView
@synthesize firstColor,secondColor;

-(void)dealloc
{
    self.firstColor = nil;
    self.secondColor = nil;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    if (self.firstColor == nil) {
        self.firstColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    }
    if (self.secondColor == nil) {
        self.secondColor = [UIColor colorWithRed:56/255.0 green:56/255.0 blue:56/255.0 alpha:1];
    }
    
    
    CGContextSetFillColorWithColor(context, self.firstColor.CGColor);
    CGContextFillRect(context, rect);
    if (rect.size.width > rect.size.height)
    {
        //横线
        CGRect rcConver = CGRectMake(0, rect.size.height/2, rect.size.width, rect.size.height/2);
        CGContextSetFillColorWithColor(context, self.secondColor.CGColor);
        CGContextFillRect(context, rcConver);
    }
    else
    {
        //竖线
        CGRect rcConver = CGRectMake( rect.size.width/2,0, rect.size.width/2, rect.size.height);
        CGContextSetFillColorWithColor(context, self.secondColor.CGColor);
        CGContextFillRect(context, rcConver);
    }
    
}

@end

