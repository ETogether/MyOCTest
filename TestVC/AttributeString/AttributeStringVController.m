//
//  AttributeStringVController.m
//  ChartsTestForOC
//
//  Created by netvox-ios1 on 2017/6/22.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import "AttributeStringVController.h"

#import "TitleView.h"

@interface AttributeStringVController ()

@end

@implementation AttributeStringVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航栏
    TitleView *navBar = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, NAVBARHEIGHT)];
    navBar.lbTitle.text = @"富文本设置";
    [self.view addSubview:navBar];
    __weak typeof(self) weakSelf = self;
    navBar.backBlock = ^(int tag){
        switch (tag) {
            case 0:
                [weakSelf.navigationController popViewControllerAnimated:true];
                break;
                
            default:
                break;
        }
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
