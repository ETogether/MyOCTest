//
//  NSString+AES256.h
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/6/29.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#import "NSData+AES256.h"

@interface NSString (AES256)

/** 加密  */
-(NSString *)aes256EncryptWithKey:(NSString *)key;
/** 解密  */
-(NSString *)aes256DecryptWithKey:(NSString *)key;



@end
