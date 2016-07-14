//
//  3DESencrypt.h
//  ZJRC_iSale
//
//  Created by xiaoming on 15/8/10.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface _DESencrypt : NSObject


+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt;

@end
