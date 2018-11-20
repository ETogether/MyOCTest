//
//  BaseController.m
//  MyOCTest
//
//  Created by Sougu on 2018/11/20.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)dealloc{
    NSString * selfStr = NSStringFromClass([self class]);
    NSLog(@"%@--控制器释放了", selfStr);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
