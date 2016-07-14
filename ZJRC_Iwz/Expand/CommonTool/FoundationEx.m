//
//  FoundationEx.m
//  ZJRC_Iwz
//
//  Created by Wynter on 16/7/14.
//  Copyright © 2016年 Wynter. All rights reserved.
//

#import "FoundationEx.h"

@implementation FoundationEx


+ (CGRect)autoSizeScale:(CGRect)frame
{
    
    float autoSizeScaleX = 0;
    float autoSizeScaleY = 0;
    
    if(Main_Screen_Height > 568)
    {
        
        autoSizeScaleX = Main_Screen_Width/320;
        
        autoSizeScaleY = Main_Screen_Height/568;
        
    }else{
        
        autoSizeScaleX = 1.0;
        
        autoSizeScaleY = 1.0;
        
    }
    
    CGRect rect = CGRectMake(frame.origin.x*autoSizeScaleX, frame.origin.y*autoSizeScaleY, frame.size.width*autoSizeScaleX, frame.size.height*autoSizeScaleY);
    
    return rect;
    
}

+ (float)autoScaleY
{
    float autoSizeScaleY = 1.0;
    
    if(Main_Screen_Height > 568)
    {
        
        autoSizeScaleY = Main_Screen_Height/568;
        
    }
    
    return autoSizeScaleY;
    
}




+(NSDate*)getDateFromString:(NSString*)myDate;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date=[formatter dateFromString:myDate];
    return date;
}


//检查字符串是否为数字
+(BOOL)isNumber:(NSString*)string
{
    if (string == nil || [string length] == 0) {
        return NO;
    }
    
    BOOL  hasDOt = NO;
    for (int i=0; i<[string length]; i++)
    {
        int c =  [string characterAtIndex:i];
        if (c == '.') {
            if (hasDOt) {
                return NO;
            }
            hasDOt = YES;
            continue;
        }
        if (c >= '0' && c <= '9') {
            continue;
        }else
            return  NO;
    }
    
    return YES;
}

#pragma mark --- 保存图片

// 根据图片路径保存图片 返回图片名称
+(NSString *)saveImageAtPath:(UIImage *)img
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // 图片名
    NSString *imgName = [NSString stringWithFormat:@"%d.png", (int)[[NSDate date] timeIntervalSince1970]];
    
    NSString* subPath = [documentsDirectory stringByAppendingFormat:@"/planImages"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:subPath isDirectory:nil])
    {
        NSError* error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:subPath withIntermediateDirectories:YES attributes:nil error:&error ];
        if (error) {
            DLog(@"create document error");
        }
    }
    
    NSData *data = UIImagePNGRepresentation(img);
    NSString* path = [subPath stringByAppendingFormat:@"/%@",imgName];
    
    // 创建成功返回相对路径
    if ([data writeToFile:path atomically:YES])
    {
        return imgName;
    }
    
    // 创建失败返回空
    return @"";
}

+ (long long) fileSizeAtPath:(NSString*) fileName
{
    NSFileManager* manager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *popusPath = [documentsDirectory stringByAppendingFormat:@"/planImages/%@",fileName];
    
    if ([manager fileExistsAtPath:popusPath]){
        return [[manager attributesOfItemAtPath:popusPath error:nil] fileSize];
    }
    return 0;
}

// 根据相对路径加载图片
+(UIImage *)loadImageAtPath:(NSString *)imageNmae
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *popusPath = [documentsDirectory stringByAppendingFormat:@"/planImages/%@",imageNmae];
    if (popusPath) {
        return [UIImage imageWithContentsOfFile:popusPath];
    }
    return nil;
}


// 根据路径清除Document下缓存图片
+ (BOOL)removeImageAtPath
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *popusPath = [documentsDirectory stringByAppendingFormat:@"/planImages"];
    
    // 移除临时目录里的图片
    if (popusPath)
    {
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSError *error;
        if ([fileMgr removeItemAtPath:popusPath error:&error] != YES)
        {
            DLog(@"Unable to delete file: %@", [error localizedDescription]);
        }
        else
        {
            return YES;
        }
    }
    return NO;
}

// 根据色值和大小生成Image
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect;
    if (size.width == 0) {
        rect = CGRectMake(0, 0, 1, 1);
    }else{
        rect = CGRectMake(0, 0, size.width, size.height);
    }
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


//检查是否有特殊字符(< > & % $ ^ ~ \\\\)如果有按照服务端规则替换
+(NSString*)checkSendString:(NSString*)string
{
    string = [string stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    string = [string stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    string = [string stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
    string = [string stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    return string;
    
}
//检查收到的字符，如果有转化的字符串，反处理
+(NSString*)checkReceiveString:(NSString*)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    return string;
}



+(NSDictionary*)DXParseJSON:(NSData*)data
{
    NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    NSLog(@"%@",result);
    NSString *json_string1=[result stringByReplacingOccurrencesOfString:@"\r"withString:@""];
    NSString *json_str = [json_string1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData* jsonData = [json_str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary  *dic  = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    return dic;
    
}

#pragma mark - 限制系统表情
+(BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         
         NSLog(@"UTF16 [%@]",[NSString stringWithFormat:@"0x%1X ",hs]);
         // surrogate pair
         if (hs == 0x263a || hs == 0xd83e || hs == 0x2639 || hs == 0x270c || hs == 0x2a || hs == 0x23)
         {
             returnValue = YES;
             
         }else  if(0x30 <= hs && hs <= 0x39){
             returnValue = YES;
         }
         // surrogate pair
         else
             if (0xd800 <= hs && hs <= 0xdbff) {
                 if (substring.length > 1) {
                     const unichar ls = [substring characterAtIndex:1];
                     const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                     if (0x1d000 <= uc && uc <= 0x1f77f) {
                         returnValue = YES;
                     }
                 }
             } else if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 if (ls == 0x20e3) {
                     returnValue = YES;
                 }
                 
             } else {
                 // non surrogate
                 if (0x2100 <= hs && hs <= 0x27ff) {
                     returnValue = YES;
                 } else if (0x2B05 <= hs && hs <= 0x2b07) {
                     returnValue = YES;
                 } else if (0x2934 <= hs && hs <= 0x2935) {
                     returnValue = YES;
                 } else if (0x3297 <= hs && hs <= 0x3299) {
                     returnValue = YES;
                 } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                     returnValue = YES;
                 }
             }
     }];
    
    return returnValue;
}
@end
