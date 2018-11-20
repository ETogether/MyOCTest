//
//  NTAESEncrypt.h
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/6/30.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NTAESEncrypt : NSObject


/** 加密  */
+(NSString *)stringNTAES256EncryptContent:(NSString *)content withKey:(NSString *)key;
+(NSData *)dataNTAES256EncryptContent:(NSData *)content withKey:(NSString *)key;


/** 解密  */
+(NSString *)stringNTAES256DecryptContent:(NSString *)content withKey:(NSString *)key;
+(NSData *)dataNTAES256DecryptContent:(NSData *)content withKey:(NSString *)key;

@end
