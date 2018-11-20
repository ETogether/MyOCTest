//
//  PushTransition.h
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/11/17.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseController.h"
//创建继承NSObject类，并遵守UIViewControllerAnimatedTransitioning协议，及实现其方法（只有两个都实现了）
@interface PushTransition : NSObject<UIViewControllerAnimatedTransitioning>


@end
