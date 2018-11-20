//
//  CQMDTooles.h
//  MyOCTest
//
//  Created by netvox-ios1 on 2018/4/2.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import <Foundation/Foundation.h>

///埋点工具

@interface CQMDTooles : NSObject

/**
 埋点添加互换类方法

 @param processedClass 要加工的类(要处理的类)
 @param originSelector 原类方法
 @param mdSelector 埋点的类方法
 */
+(void)cqMDWithClass:(Class)processedClass originalSelector:(SEL)originSelector mdSelector:(SEL)mdSelector;


/**
 埋点添加互换类的实例方法

 @param processedClass 要加工的类(要处理的类)
 @param originSelector 原类方法
 @param mdSelector 埋点的类方法
 */
+(void)cqMDWithInstanceClass:(Class)processedClass originalSelector:(SEL)originSelector mdSelector:(SEL)mdSelector;

@end
