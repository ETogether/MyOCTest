//
//  UIView+CQLayout.m
//  MyOCTest
//
//  Created by huitouke on 2018/5/15.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import "UIView+CQLayout.h"

@implementation UIView (CQLayout)

//x、y坐标 宽高
-(void)setCqX:(CGFloat)cqX{
    CGRect frame = self.frame;
    frame.origin.x = cqX;
    self.frame = frame;
}
-(CGFloat)cqX{
    return self.frame.origin.x;
}

-(void)setCqY:(CGFloat)cqY{
    CGRect frame = self.frame;
    frame.origin.y = cqY;
    self.frame = frame;
}
-(CGFloat)cqY{
    return self.frame.origin.y;
}

-(void)setCqW:(CGFloat)cqW{
    CGRect frame = self.frame;
    frame.size.width = cqW;
    self.frame = frame;
}
///获取视图宽度
-(CGFloat)cqW{
    return self.frame.size.width;
}
///设置视图高度
-(void)setCqH:(CGFloat)cqH{
    CGRect frame = self.frame;
    frame.size.height = cqH;
    self.frame = frame;
}
///获取视图高度
-(CGFloat)cqH{
    return self.frame.size.height;
}

//x坐标w宽和 y坐标h高和
-(CGFloat)cqXW{
    return self.frame.origin.x + self.frame.size.width;
}
-(CGFloat)cqYH{
    return self.frame.origin.y + self.frame.size.height;
}

//size origin
-(void)setCqS:(CGSize)cqS{
    CGRect frame = self.frame;
    frame.size = cqS;
    self.frame = frame;
}
-(CGSize)cqS{
    return self.frame.size;
}
- (void)setCqO:(CGPoint)cqO{
    CGRect frame = self.frame;
    frame.origin = cqO;
    self.frame = frame;
}
-(CGPoint)cqO{
    return self.frame.origin;
}

//bounds中心点
- (CGPoint)cqBC{
    return CGPointMake(self.center.x - self.cqX, self.center.y - self.cqY);
}
-(void)setCqBC:(CGPoint)cqBC{
    self.center = cqBC;
}
//中心点 x y Frame Bounds
-(CGFloat)cqFCX{
    return self.center.x;
}
-(void)setCqFCX:(CGFloat)cqFCX{
    self.center = CGPointMake(cqFCX, self.center.y);
}
-(CGFloat)cqFCY{
    return self.center.y;
}
-(void)setCqFCY:(CGFloat)cqFCY{
    self.center = CGPointMake(self.center.x, cqFCY);
}
//相对自己 bounds
-(CGFloat)cqBCX{
    return self.center.x - self.cqX;
}
-(void)setCqBCX:(CGFloat)cqBCX{
    self.center = CGPointMake(cqBCX, self.center.y);
}
-(CGFloat)cqBCY{
    return self.center.y - self.cqY;
}
-(void)setCqBCY:(CGFloat)cqBCY{
    self.center = CGPointMake(self.center.x, cqBCY);
}

@end
