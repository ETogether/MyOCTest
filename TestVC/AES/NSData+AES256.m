//
//  NSData+AES256.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/6/29.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import "NSData+AES256.h"

@implementation NSData (AES256)

/** 加密  */
-(NSData *)aes256EncryptWithKey:(NSString *)key{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    //TODO: malloc 与 free是成对存在的
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [self bytes], dataLength, buffer, bufferSize, &numBytesEncrypted); //kCCOptionPKCS7Padding | kCCOptionECBMode
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    //TODO: malloc 与 free是成对存在的
    free(buffer);
    
    return nil;
}

/** 解密  */
-(NSData *)aes256DecryptWithKey:(NSString *)key{
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    //TODO: malloc 与 free是成对存在的
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [self bytes], dataLength, buffer, bufferSize, &numBytesDecrypted); //kCCOptionPKCS7Padding | kCCOptionECBMode
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    //TODO: malloc 与 free是成对存在的
    free(buffer);
    
    
    
    return nil;
}


@end
