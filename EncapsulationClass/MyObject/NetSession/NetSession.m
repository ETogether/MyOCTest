//
//  NetSession.m
//  MyOCTest
//
//  Created by huitouke on 2018/7/13.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import "NetSession.h"

//#import <<#header#>>
@interface NetSession(){
    
    
}

@property (nonatomic,strong) NSURLSession *urlSession;

@end


@implementation NetSession
static NetSession *_session = nil;
#pragma mark - Property声明




#pragma mark - Private方法
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _session = [super allocWithZone:zone];
        
    });
    return _session;
}



#pragma mark - Public方法
//************>>>>>>>>>>>单例
+(instancetype)share{
    
    return  [[self alloc] init];
}


@end
