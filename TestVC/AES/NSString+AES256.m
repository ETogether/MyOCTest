//
//  NSString+AES256.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/6/29.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import "NSString+AES256.h"




@implementation NSString (AES256)


/** 加密  */
-(NSString *)aes256EncryptWithKey:(NSString *)key{
    
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    //对数据进行加密
    NSData *result = [data aes256EncryptWithKey:key];
    
    //转换为2进制字符串
    if (result && result.length > 0) {
        Byte *datas = (Byte *)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for (int i = 0; i < result.length; i++) {
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    
    return nil;
}


/** 解密  */
-(NSString *)aes256DecryptWithKey:(NSString *)key{
    
    //转换为2进制Data
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    unsigned char wholeByte;
    char byteChars[3] = {'\0', '\0', '\0'};
    for (int i = 0; i < [self length] / 2; i ++) {
        byteChars[0] = [self characterAtIndex:i * 2];
        byteChars[1] = [self characterAtIndex:i * 2 + 1];
        wholeByte = strtol(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    
    //对数据进行解密
    NSData *result = [data aes256DecryptWithKey:key];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}

@end
