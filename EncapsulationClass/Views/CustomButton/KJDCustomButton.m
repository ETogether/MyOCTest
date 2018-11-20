//
//  KJDCustomButton.m
//  SmartHome
//
//  Created by apple on 2018/1/22.
//  Copyright © 2018年 cn.zgkjd. All rights reserved.
//

#import "KJDCustomButton.h"

@implementation KJDCustomButton
//view出现的时候 才会调用 
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (!CGRectIsEmpty(self.titleRect) && !CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return self.titleRect;
    }
    CGRect rect = [super titleRectForContentRect:contentRect];
    return rect;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    if (!CGRectIsEmpty(self.imageRect) && !CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return self.imageRect;
    }
    CGRect rect = [super imageRectForContentRect:contentRect];
    return rect;
}


@end
