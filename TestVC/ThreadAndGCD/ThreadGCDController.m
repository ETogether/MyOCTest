//
//  ThreadGCDController.m
//  MyOCTest
//
//  Created by huitouke on 2018/8/4.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import "ThreadGCDController.h"



@interface ThreadGCDController ()

@end

@implementation ThreadGCDController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    navBar.lbTitle.text = @"UIDatePicker使用";
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
    
}
#pragma mark - 按钮事件
-(void)btnClick:(UIButton *)btn{
    CQLog(@"Title=%@,tag=%ld",btn.currentTitle,(long)btn.tag);
    NSInteger tag = btn.tag - 100;
    switch (tag) {
        case 0:{
            //返回
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 1:{
            //右按钮事件
//            [self gcdSynchronized];
        }
            break;
            //        case <#2#>:{
            //            //<#hnit#>
            //            <#code#>
            //        }
            //            break;
        default:
            break;
    }
}

///GCD - 同步
-(void)gcdSynchronized{
    //1 创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //2 创建任务
    void (^task)() = ^{
        CQLog(@"%@",[NSThread currentThread]);
    };
    //3 将任务添加到队列中
    dispatch_sync(queue, task);
}
///GCD - 异步
-(void)gcdAsynchoronized{
    //1 创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //2 创建任务
    void (^task)() = ^{
        CQLog(@"%@",[NSThread currentThread]);
    };
    dispatch_async(queue, task);
}

-(void)gcdSyncConcurrentQueue{
    
    //并发队列
    dispatch_queue_t queue = dispatch_queue_create("MyQueue", DISPATCH_QUEUE_CONCURRENT);
    
//    dispatch_queue_t queueBG = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    NSLog(@"Begin %@",[NSThread currentThread]);
    
    dispatch_sync(queue, ^{
        NSLog(@"1并发队列 同执行任务：%@",[NSThread currentThread]);
    });
    
    
    dispatch_async(queue, ^{
        NSLog(@"2并发队列 异步执行任务：%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"3并发队列 异步执行任务：%@",[NSThread currentThread]);
    });
    
    for (int i = 0; i<10; i++) {
        NSLog(@"A for循环=%d",i);
    }
    
    
    NSLog(@"4东健先生来了");
    dispatch_sync(queue, ^{
        for (int i = 0; i<10; i++) {
            NSLog(@"并 同for循环=%d %@",i,[NSThread currentThread]);
        }
    });
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //执行gcd同步
//    [self gcdSynchronized];
    //执行gcd异步
//    [self gcdAsynchoronized];
    //执行gcd同步 并发队列
    [self gcdSyncConcurrentQueue];
}






@end
