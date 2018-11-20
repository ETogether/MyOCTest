//
//  NSObject+CQKVO.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2018/4/9.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import "NSObject+CQKVO.h"

#import <objc/message.h>

@implementation NSObject (CQKVO)


-(void)cq_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    
    //动态生成一个类
    //1、拼接类名
    NSString *originName = NSStringFromClass([self class]);
    NSString *newName = [NSString stringWithFormat:@"CQKVO%@", originName];
    
    //2、创建类
    Class NewClass = objc_getClass(newName.UTF8String);
    if (NewClass == nil) {
        NewClass = objc_allocateClassPair([self class], newName.UTF8String, 0);
        //2.1、添加set方法 -- 重写父类方法
        //v@:@:@对应方法(setNameMethod)  v表示返回值为空(void) @表示参数，有几@就有几个参数 ，不放代码也行，空串
        class_addMethod(NewClass, @selector(setName:), (IMP)setNameMethod, "v@:@:@");
        //2.2、注册类
        objc_registerClassPair(NewClass);
    }
    
    
    
    
    
    //3、修改观察者的isa指针
    object_setClass(self, NewClass);
    
}

void setNameMethod(id self, SEL _cmd, NSString *name){
    NSLog(@"重写了父类方法 %@", name);
}

@end
