//
//  NTAESEncrypt.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/6/30.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import "NTAESEncrypt.h"
#import "NSString+AES256.h"
#import "NSData+AES256.h"
@implementation NTAESEncrypt
/** 加密部分    */
+(NSString *)stringNTAES256EncryptContent:(NSString *)content withKey:(NSString *)key{

    return [content aes256EncryptWithKey:key];
    
}
+(NSData *)dataNTAES256EncryptContent:(NSData *)content withKey:(NSString *)key{
    return [content aes256EncryptWithKey:key];
}

/** 解密部分    */
+(NSString *)stringNTAES256DecryptContent:(NSString *)content withKey:(NSString *)key{
    return [content aes256DecryptWithKey:key];
}

+(NSData *)dataNTAES256DecryptContent:(NSData *)content withKey:(NSString *)key{
    return [content aes256DecryptWithKey:key];
}

@end
