//
//  NSData+AES256.h
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/6/29.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>


@interface NSData (AES256)

-(NSData *)aes256EncryptWithKey:(NSString *)key;
-(NSData *)aes256DecryptWithKey:(NSString *)key;

@end
