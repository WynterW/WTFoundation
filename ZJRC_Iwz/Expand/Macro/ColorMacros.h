//
//  ColorMacros.h
//  ZJRC_Iwz
//
//  Created by Wynter on 15/11/19.
//  Copyright © 2015年 Wynter. All rights reserved.
//  色值宏定义

#ifndef ColorMacros_h
#define ColorMacros_h

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f                                                                                                         alpha:a]
#define RGB(r,g,b)                                                                                                                                                                        RGBA(r,g,b,1.0f)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define     DEFAULT_NAVBAR_COLOR            [UIColor colorWithRed:20.0/255.0 green:20.0/255.0 blue:20.0/255.0                                                                             alpha:0.9]
#define     DEFAULT_BACKGROUND_COLOR        [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:246.0/255.0                                                                          alpha:1.0]
#define     DEFAULT_SEARCHBAR_COLOR         [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0                                                                          alpha:1.0]
#define     DEFAULT_GREEN_COLOR             [UIColor colorWithRed:31.0/255 green:185.0/255  blue:34.0/255                                                                                 alpha:1.0f]
#define     DEFAULT_TEXT_GRAY_COLOR         [UIColor                                                                                                                                      grayColor]
#define     DEFAULT_LINE_GRAY_COLOR         [UIColor colorWithRed:188.0/255 green:188.0/255  blue:188.0/255                                                                               alpha:0.6f]

//常用黑色
#define     kTEXT_BLACK_COLOR               [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0                                                                                             alpha:1.0]

//常用背景颜色
#define     kBACKGROUND_COLOR               [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0                                                                                             alpha:1.0]

//浅黑色
#define     kTEXT_LIGHT_BlACK_COLO

#endif /* ColorMacros_h */
