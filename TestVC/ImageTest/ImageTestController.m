//
//  ImageTestController.m
//  MyOCTest
//
//  Created by huitouke on 2018/8/15.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import "ImageTestController.h"

#import "TitleView.h"

@interface ImageTestController ()

@end

@implementation ImageTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingView];
}

#pragma mark - 页面布局
///页面设置
-(void)settingView{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBarView];
    [self addContentView];
}

///设置导航栏视图
-(void)setNavBarView{
    __weak typeof(self) weakSelf = self;
    TitleView *navBar = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, NAVBARHEIGHT)];
    navBar.lbTitle.text = @"图片测试";
    [navBar.btnRight setTitle:@"右" forState:0];
    navBar.backBlock = ^(int tag){
        switch (tag) {
            case 0:
                [weakSelf.navigationController popViewControllerAnimated:YES];
                break;
                
            default:
                break;
        }
    };
    
    [self.view addSubview:navBar];
    
}
///添加内容视图
-(void)addContentView{
    UIImage *img = [UIImage imageNamed:@"test_comment"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 200, 120)];
    imgView.backgroundColor = HEXCOLOR(0x32e813);
    imgView.cqFCX = self.view.cqBCX;
    imgView.image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.view addSubview:imgView];
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithImage:img];
    imgView1.backgroundColor = HEXCOLOR(0x32e813);
    imgView1.cqFCX = self.view.cqBCX;
    imgView1.cqY = imgView.cqYH + 30;
//    imgView1.image = img;
    
    [self.view addSubview:imgView1];
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, imgView1.cqYH + 20, 200, 120)];
    imgView2.backgroundColor = HEXCOLOR(0x32e813);
    imgView2.cqFCX = self.view.cqBCX;
    
    CGFloat top = img.size.height / 2.0;//距离顶部高度
    CGFloat bottom = img.size.height / 2.0;//距离底部高度
    CGFloat left = img.size.width / 2.0 - 3;//距离左边大小
    CGFloat right = img.size.width / 2.0 + 3;//距离右边大小
    UIEdgeInsets edge = UIEdgeInsetsMake(top, left, bottom, right);
    imgView2.image = [img resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    
    [self.view addSubview:imgView2];
    
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView2.frame) + 20, 200, 100)];
    shadowView.backgroundColor = HEXCOLOR(0xef72c1);
    shadowView.cqFCX = self.view.cqBCX;
    [self.view addSubview:shadowView];
    
    

    //圆角
    CGFloat r = 20;
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:shadowView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(r, r)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] initWithLayer:shadowView.layer];
//    shape.backgroundColor = HEXCOLOR(0xef72c1).CGColor;
    shape.path = path1.CGPath;
//    shadowView.layer.mask = shape;
    [shadowView.layer addSublayer:shape];
//    shadowView.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    
    //阴影
    CGFloat w = shadowView.cqW;
    CGFloat h = shadowView.cqH;
    
    CGFloat offsetV = 15.0;
    CGFloat offsetH = 15.0;
    
    shadowView.layer.shadowColor = [UIColor redColor].CGColor;
    shadowView.layer.shadowOpacity = 0.5;

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(-offsetH, -offsetV)];
    [path addLineToPoint:CGPointMake(w + offsetH, -offsetV)];
    [path addLineToPoint:CGPointMake(w + offsetH, h)];
    [path addLineToPoint:CGPointMake(-offsetH, h)];
    [path addLineToPoint:CGPointMake(-offsetH, -offsetV)];
    shadowView.layer.shadowPath = path.CGPath;
    //添加直线
//    [path addLineToPoint:CGPointMake(w /2, -15)];
//    [path addLineToPoint:CGPointMake(paintingWidth +5, -5)];
//    [path addLineToPoint:CGPointMake(paintingWidth +15, paintingHeight /2)];
//    [path addLineToPoint:CGPointMake(paintingWidth +5, paintingHeight +5)];
//    [path addLineToPoint:CGPointMake(paintingWidth /2, paintingHeight +15)];
//    [path addLineToPoint:CGPointMake(-5, paintingHeight +5)];
//    [path addLineToPoint:CGPointMake(-15, paintingHeight /2)];
//    [path addLineToPoint:CGPointMake(-5, -5)];
    
   
    
//
//
//    shadowView.layer.cornerRadius = 5;
//    shadowView.layer.sublayers[0].masksToBounds = YES;
    
//    CGFloat v = 15.0;
//    CGFloat h = 15.0;
//    CALayer *layer = [[CALayer alloc] initWithLayer:shadowView.layer];
//
//    CALayer *layer1 = [[CALayer alloc] initWithLayer:layer];
//    layer1.position = shadowView.layer.position;
//    layer1.bounds = shadowView.layer.bounds;
//    layer1.shadowOpacity = 0.5;
//    layer1.shadowOffset = CGSizeMake(0, -v);
//    layer1.shadowColor = [UIColor redColor].CGColor;
//    [shadowView.layer addSublayer:layer1];
//
//    CALayer *layer2 = [[CALayer alloc] initWithLayer:layer];
//    layer2.position = shadowView.layer.position;
//    layer2.bounds = shadowView.layer.bounds;
//    layer2.shadowOpacity = 0.5;
//    layer2.shadowOffset = CGSizeMake(-h, 0);
//    layer2.shadowColor = [UIColor greenColor].CGColor;
//    [shadowView.layer addSublayer:layer2];
//
//    CALayer *layer3 = [[CALayer alloc] initWithLayer:layer];
//    layer3.position = shadowView.layer.position;
//    layer3.bounds = shadowView.layer.bounds;
//    layer3.shadowOpacity = 0.5;
//    layer3.shadowOffset = CGSizeMake(0, v);
//    layer3.shadowColor = [UIColor blueColor].CGColor;
//    [shadowView.layer addSublayer:layer3];
//
//    CALayer *layer4 = [[CALayer alloc] initWithLayer:layer];
//    layer4.position = shadowView.layer.position;
//    layer4.bounds = shadowView.layer.bounds;
//    layer4.shadowOpacity = 0.5;
//    layer4.shadowOffset = CGSizeMake(h, 0);
//    layer4.shadowColor = [UIColor orangeColor].CGColor;
//    [shadowView.layer addSublayer:layer4];
    
    
    
    
}

@end
