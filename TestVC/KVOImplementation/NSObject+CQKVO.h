//
//  NSObject+CQKVO.h
//  MyOCTest
//
//  Created by netvox-ios1 on 2018/4/9.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CQKVO)
- (void)cq_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
@end
