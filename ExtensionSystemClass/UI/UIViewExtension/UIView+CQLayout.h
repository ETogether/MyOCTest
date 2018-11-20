//
//  UIView+CQLayout.h
//  MyOCTest
//
//  Created by huitouke on 2018/5/15.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import "BaseController.h"

@interface UIView (CQLayout)

//x、y坐标 宽高
@property(nonatomic, assign)CGFloat cqX;
@property(nonatomic, assign)CGFloat cqY;
@property(nonatomic, assign)CGFloat cqW;
@property(nonatomic, assign)CGFloat cqH;

//x坐标w宽和 y坐标h高和
@property(nonatomic, assign, readonly)CGFloat cqXW;
@property(nonatomic, assign, readonly)CGFloat cqYH;

//size origin
@property(nonatomic, assign)CGSize cqS;
@property(nonatomic, assign)CGPoint cqO;

//中心点 bounds
@property (nonatomic,assign) CGPoint cqBC;
//中心点 x y
@property (nonatomic,assign) CGFloat cqFCX;
@property (nonatomic,assign) CGFloat cqFCY;
@property (nonatomic,assign,readonly) CGFloat cqBCX;
@property (nonatomic,assign,readonly) CGFloat cqBCY;

@end
