//
//  ButtonInsetsController.m
//  MyOCTest
//
//  Created by Sougu on 2018/10/24.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import "ButtonInsetsController.h"

#import "TitleView.h"

@interface ButtonInsetsController ()

@end

@implementation ButtonInsetsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settingView];
}

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
                weakSelf.backBlock(@"返回了");
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
    UIColor *tBGColor = HEXCOLOR(0xeeeeee);
    UIColor *iBGColor = HEXCOLOR(0xdfdfdfdf);
    CGFloat topPad = 40;
    UIImage *img = [UIImage imageNamed:@"test_comment"];
    //正常情况下按钮内容是水平垂直居中 左图右文
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 120, 240, 100);
    btn.center = CGPointMake(self.view.center.x, btn.center.y);//水平居中
    btn.backgroundColor = HEXCOLOR(0x123efd);
    [btn setTitle:@"测试按钮 正常情况" forState:UIControlStateNormal];
    [btn setTitleColor:HEXCOLOR(0xee3062) forState:UIControlStateNormal];
    [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    btn.titleLabel.backgroundColor = tBGColor;
    btn.imageView.backgroundColor = iBGColor;
    btn.tag = 100;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    CGFloat iW = btn.imageView.frame.size.width;
    CGFloat iH = btn.imageView.frame.size.height;
    CGFloat tW = btn.titleLabel.frame.size.width;
    CGFloat tH = btn.titleLabel.frame.size.height;
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, btn.cqYH + topPad, 240, 100);
    btn1.center = CGPointMake(self.view.center.x, btn1.center.y);//水平居中
    btn1.backgroundColor = HEXCOLOR(0x123efd);
    [btn1 setTitle:@"测试按钮 右图左文" forState:UIControlStateNormal];
    [btn1 setTitleColor:HEXCOLOR(0xee3062) forState:UIControlStateNormal];
    [btn1 setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    btn1.titleLabel.backgroundColor = tBGColor;
    btn1.imageView.backgroundColor = iBGColor;
    
    CGFloat iW1 = btn1.imageView.frame.size.width;
//    CGFloat iH1 = btn1.imageView.frame.size.height;
    CGFloat tW1 = btn1.titleLabel.frame.size.width;
//    CGFloat tH1 = btn1.titleLabel.frame.size.height;
    
    btn1.titleEdgeInsets = UIEdgeInsetsMake(0, -iW1, 0, iW1);
    btn1.imageEdgeInsets = UIEdgeInsetsMake(0, tW1, 0, -tW1);
    
    btn1.tag = 100;
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, btn1.cqYH + topPad, 240, 100);
    btn2.center = CGPointMake(self.view.center.x, btn2.center.y);//水平居中
    btn2.backgroundColor = HEXCOLOR(0x123efd);
    [btn2 setTitle:@"测试按钮 上图下文" forState:UIControlStateNormal];
    [btn2 setTitleColor:HEXCOLOR(0xee3062) forState:UIControlStateNormal];
    [btn2 setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    btn2.titleLabel.backgroundColor = tBGColor;
    btn2.imageView.backgroundColor = iBGColor;
    
    CGFloat iW2 = btn2.imageView.frame.size.width;
    CGFloat iH2 = btn2.imageView.frame.size.height;
    CGFloat tW2 = btn2.titleLabel.frame.size.width;
    CGFloat tH2 = btn2.titleLabel.frame.size.height;
    
    //图片往右上角(东北角) 文字往左下角(西南方向)
    btn2.imageEdgeInsets = UIEdgeInsetsMake(-tH2/2, tW2/2, tH2/2, -tW2/2);
    btn2.titleEdgeInsets = UIEdgeInsetsMake(iH2/2, -iW2/2, -iH2/2, iW2/2);
    
    
    
    btn2.tag = 100;
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, btn2.cqYH + topPad, 240, 100);
    btn3.center = CGPointMake(self.view.center.x, btn3.center.y);//水平居中
    btn3.backgroundColor = HEXCOLOR(0x123efd);
    [btn3 setTitle:@"测试按钮 上文下图" forState:UIControlStateNormal];
    [btn3 setTitleColor:HEXCOLOR(0xee3062) forState:UIControlStateNormal];
    [btn3 setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    btn3.titleLabel.backgroundColor = tBGColor;
    btn3.imageView.backgroundColor = iBGColor;
    
    CGFloat iW3 = btn3.imageView.frame.size.width;
    CGFloat iH3 = btn3.imageView.frame.size.height;
    CGFloat tW3 = btn3.titleLabel.frame.size.width;
    CGFloat tH3 = btn3.titleLabel.frame.size.height;
    
    //图片往左上角(西北角) 文字往右下角(东南方向)
    btn3.imageEdgeInsets = UIEdgeInsetsMake(tH3/2, tW3/2, -tH3/2, -tW3/2);
    btn3.titleEdgeInsets = UIEdgeInsetsMake(-iH3/2, -iW3/2, iH3/2, iW3/2);
    
    
    btn3.tag = 100;
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(btn.cqX + btn.imageView.cqX,NAVBARHEIGHT, 1, SCREENHEIGHT - NAVBARHEIGHT)];
    lineView.backgroundColor = HEXCOLOR(0xffffff);//f3f3f3
    [self.view addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(btn.cqX + btn.imageView.cqXW,NAVBARHEIGHT, 1, SCREENHEIGHT - NAVBARHEIGHT)];
    lineView1.backgroundColor = HEXCOLOR(0x000000);//f3f3f3
    [self.view addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(btn.cqFCX,NAVBARHEIGHT, 1, SCREENHEIGHT - NAVBARHEIGHT)];
    lineView2.backgroundColor = HEXCOLOR(0xffffff);//f3f3f3
    [self.view addSubview:lineView2];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(btn.cqX + btn.titleLabel.cqXW - iW,NAVBARHEIGHT, 1, SCREENHEIGHT - NAVBARHEIGHT)];
    lineView3.backgroundColor = HEXCOLOR(0x000000);//f3f3f3
    [self.view addSubview:lineView3];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(btn.cqX + btn.titleLabel.cqXW,NAVBARHEIGHT, 1, SCREENHEIGHT - NAVBARHEIGHT)];
    lineView4.backgroundColor = HEXCOLOR(0xffffff);//f3f3f3
    [self.view addSubview:lineView4];
}

#pragma mark - 按钮事件
-(void)btnClick:(UIButton *)btn{
    CQLog(@"Title=%@,tag=%ld",btn.currentTitle,(long)btn.tag);
    NSInteger tag = btn.tag - 100;
    switch (tag) {
//        case <#0#>:{
//            //<#hnit#>
//            <#code#>
//        }break;
        default:
            break;
    }
}

@end
