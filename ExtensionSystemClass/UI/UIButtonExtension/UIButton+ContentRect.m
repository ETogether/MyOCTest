//
//  UIButton+ContentRect.m
//  MyOCTest
//
//  Created by huitouke on 2018/6/8.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import "UIButton+ContentRect.h"

//导入runtime 用关联对象给类别添加属性
#import <objc/runtime.h>


#import "CQMDTooles.h"//埋点工具类


static char *titleRectName = "titleRect";
static char *imageRectName = "imageRect";

@implementation UIButton (ContentRect)

-(void)setTitleRect:(CGRect)titleRect{
    NSValue *rect = [NSValue valueWithCGRect:titleRect];//NSStringFromCGRect(<#CGRect rect#>)
    objc_setAssociatedObject(self, titleRectName, rect, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CGRect)titleRect{
    return [objc_getAssociatedObject(self, titleRectName) CGRectValue];
}

-(void)setImageRect:(CGRect)imageRect{
    NSValue *rect = [NSValue valueWithCGRect:imageRect];//NSStringFromCGRect(<#CGRect rect#>)
    objc_setAssociatedObject(self, imageRectName, rect, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CGRect)imageRect{
    return [objc_getAssociatedObject(self, imageRectName) CGRectValue];
}


//修改方法
+(void)load{
    [super load];
    //添加线程锁
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        //1、获取系统方法  -- 调用实例方法
//        Method titleRectForContent = class_getInstanceMethod(self, @selector(titleRectForContentRect:));
//        Method imageRectForContent = class_getInstanceMethod(self, @selector(imageRectForContentRect:));
//
//        //2、获取自定义方法
//        Method customTitleRect = class_getInstanceMethod(self, @selector(redrawTitleRectForContentRect:));
//        Method customImageRect = class_getInstanceMethod(self, @selector(redrawImageRectForContentRect:));
//
//        //3、替换方法
//        method_exchangeImplementations(titleRectForContent, customTitleRect);
//        method_exchangeImplementations(imageRectForContent, customImageRect);
        
        [CQMDTooles cqMDWithInstanceClass:[self class] originalSelector:@selector(titleRectForContentRect:) mdSelector:@selector(redrawTitleRectForContentRect:)];
        [CQMDTooles cqMDWithInstanceClass:[self class] originalSelector:@selector(imageRectForContentRect:) mdSelector:@selector(redrawImageRectForContentRect:)];
    });
    
}

//系统会根据是否有标题、图片，才会去调用相应的方法（titleRectForContentRect:、imageRectForContentRect）
///重画标题内容大小
-(CGRect)redrawTitleRectForContentRect:(CGRect)contentRect{
    if (!CGRectIsEmpty(self.titleRect) && !CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return self.titleRect;
    }
    //此处是调用系统方法（方法名在load调用后交换了），如果这边调用 titleRectForContentRect反而出现死循环
    return [self redrawTitleRectForContentRect:contentRect];
    
}

///重画图片内容大小
-(CGRect)redrawImageRectForContentRect:(CGRect)contentRect{
    if (!CGRectIsEmpty(self.imageRect) && !CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return self.imageRect;
    }
    //此处是调用系统方法（方法名在load调用后交换了），如果这边调用 imageRectForContentRect反而出现死循环
    return [self redrawImageRectForContentRect:contentRect];
}

@end
