//
//  ButtonInsetsController.h
//  MyOCTest
//
//  Created by Sougu on 2018/10/24.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import "BaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ButtonInsetsController : BaseController

///backBlock
@property (nonatomic,copy) void(^backBlock)(NSString *backName);

@end

NS_ASSUME_NONNULL_END
