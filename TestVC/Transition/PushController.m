//
//  PushController.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/11/17.
//  Copyright © 2017年 netvox. All rights reserved.
//


//转场动画的下一页

#import "PushController.h"

#import "TitleView.h"

@interface PushController ()

@end

@implementation PushController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self settingSubviews];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**$ settingSubviews: - 页面布局
 * ^pram
 *  0
 * ^return
 *  0
 */
-(void)settingSubviews{
    [self addNavBar];
    [self addContentView];
}

/**$ addNavBar: - 添加导航栏
 * ^pram
 *  0
 * ^return
 *  0
 */
-(void)addNavBar{
    __weak typeof(self) weakSelf = self;
    TitleView *navBar = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, NAVBARHEIGHT)];
    navBar.lbTitle.text = self.title;
    navBar.backBlock = ^(int tag){
        switch (tag) {
            case 0:
//                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            {
                CATransition *tra = [CATransition animation];
                tra.duration = 1;
                tra.type = @"reveal";
                tra.subtype = kCATransitionFromTop;
                [[UIApplication sharedApplication].keyWindow.layer addAnimation:tra forKey:nil];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
                
                break;
                
            default:
                break;
        }
    };
    
    [self.view addSubview:navBar];
    
}

/**$ addContentView: - 添加内容视图
 * ^pram
 *  0
 * ^return
 *  0
 */
-(void)addContentView{
    
}



@end
