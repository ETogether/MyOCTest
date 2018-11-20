//
//  EditTimingSetViewController.m
//  Netvox
//
//  Created by netvox-ios1 on 2017/5/11.
//  Copyright © 2017年 netvox-ios6. All rights reserved.
//  保存 编辑

#import "EditTimingSetViewController.h"

#import "TitleView.h"

@interface EditTimingSetViewController ()

@end

@implementation EditTimingSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置导航栏
    [self settingNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//自定义 -- 导航栏
-(void)settingNavigationBar{
    TitleView *titleView=[[TitleView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, NAVBARHEIGHT)];
    
    [titleView.lbTitle setText:@"定时设置"];
    titleView.lbTitle.textColor=[UIColor whiteColor];
    [self.view addSubview:titleView];
    
    UIButton *left = titleView.btnLeft;
    [left addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    left.tag=100;
    
    UIButton *right = titleView.btnRight;
//    [right setImage:[UIImage imageNamed:@"video_add_icon_up.png"] forState:UIControlStateNormal];
    [right setTitle:@"保存" forState:UIControlStateNormal];
    [right addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    right.tag=101;
}













#pragma mark -- 按钮点击事件

-(void)btnClick:(UIButton *)sender{
    
    switch (sender.tag - 100) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
        {
            NSLog(@"保存");
        }
            break;
        case 2:{
            NSLog(@"trobult");
        }
            break;
        default:
            break;
    }
}


@end
