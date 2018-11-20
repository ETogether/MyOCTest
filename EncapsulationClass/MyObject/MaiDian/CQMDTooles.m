//
//  CQMDTooles.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2018/4/2.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import "CQMDTooles.h"

#import "objc/runtime.h"

@implementation CQMDTooles
+(void)cqMDWithClass:(Class)processedClass originalSelector:(SEL)originSelector mdSelector:(SEL)mdSelector{
    //原类方法 获取可能存在类或超类(父类)中的原类方法
    Method originMethod = class_getClassMethod(processedClass, originSelector);
    //埋点类方法(新增) 获取可能存在类或超类(父类)中的原类方法(一般是新增的一个类方法)
    Method mdMethod = class_getClassMethod(processedClass, mdSelector);
    
    //Adds a new method to a class with a given name and implementation.   要新增的方法已经存在，则class_addMethod 返回YES,不存在返回NO
    BOOL didAddMethod = class_addMethod(processedClass, originSelector, method_getImplementation(mdMethod), method_getTypeEncoding(mdMethod));
    
    if (didAddMethod) {
        //Replaces the implementation of a method for a given class.替换给定类的实现方法
        class_replaceMethod(processedClass, mdSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        //Exchanges the implementations of two methods.交换两个方法的实现(方法)
        method_exchangeImplementations(originMethod, mdMethod);
    }
}

+(void)cqMDWithInstanceClass:(Class)processedClass originalSelector:(SEL)originSelector mdSelector:(SEL)mdSelector{
    Method originMethod = class_getInstanceMethod(processedClass, originSelector);
    Method mdMethod = class_getInstanceMethod(processedClass, mdSelector);
    BOOL didAddMethod = class_addMethod(processedClass, originSelector, method_getImplementation(mdMethod), method_getTypeEncoding(mdMethod));
    if (didAddMethod) {//添加成功
        //把“新增”的方法实现，替换成原始方法的实现
        class_replaceMethod(processedClass, mdSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        //交换两个方法
        method_exchangeImplementations(originMethod, mdMethod);
    }
}


@end











