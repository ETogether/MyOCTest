//
//  TransitionAnimateController.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/11/17.
//  Copyright © 2017年 netvox. All rights reserved.
//

//转场动画

#import "TransitionAnimateController.h"
#import "TitleView.h"

#import <Masonry/Masonry.h>

#import "PushController.h"
#import "PushTransition.h"

@interface TransitionAnimateController ()<UINavigationControllerDelegate>{
    
}
@property (nonatomic, strong)PushTransition *pushTransition;

@end

@implementation TransitionAnimateController

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
    navBar.lbTitle.text = @"转场动画";
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

/**$ addContentView: - 添加内容视图
 * ^pram
 *  0
 * ^return
 *  0
 */
-(void)addContentView{
    NSArray *titleArr = @[@"动画1", @"动画2", @"动画三"];
    NSMutableArray *btnArr = [NSMutableArray arrayWithCapacity:0];
    int i = 0;
    for (NSString *title in titleArr) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = RGB(213, 235, 216, 1);
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 20;//按钮统一设置高度为40，如添加约束是动态的高度（即高度值不固定） 可以在viewWillAppear系统方法求出btn的高度 或在调用下[btn layoutIfNeeded];
        
        [self.view addSubview:btn];
        [btnArr addObject:btn];
        
        if (i == 0) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(NAVBARHEIGHT);
            }];
        }else{
            //获取上一个按钮
            UIButton *afterBtn = btnArr[i - 1];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(afterBtn.mas_bottom).offset(20);
            }];
            //没添加太多按钮 这个可以取消
//            if (i == titleArr.count - 1){
//                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.bottom.offset(-40);
//                }];
//            }
        }
        i += 1;
    }
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(40);
        make.width.equalTo(self.view.mas_width).offset(-40);
    }];
}

#pragma mark - 按钮事件
-(void)btnClick:(UIButton *)btn{
    PushController *push = [[PushController alloc] init];
    push.title = btn.currentTitle;
    
    //创建动画
    CATransition *animation = [CATransition animation];
    //设置运动轨迹的速度
//    animation.timingFunction = kCAMediaTimingFunctionLinear;
    //设置动画类型
//    animation.type = @"7";
    
    //设置动画时长
    animation.duration = 0.5;
    
    //设置运动方向
    animation.subtype = kCATransitionFromBottom;
    
    
    switch (btn.tag) {
        case 0:
        {
            NSLog(@"0点击了");
//            push.title = btn.currentTitle;
            animation.type = @"curlDown";
        }
            break;
        case 1:
        {
            NSLog(@"1点击了");
//            push.title = @"二";
            animation.type = @"moveIn";
        }
            break;
        case 2:
        {
            NSLog(@"2点击了");
//            push.title = @"三";
            animation.type = @"pageCurl";
        }
            break;
        default:
            break;
    }

    //控制器间跳转动画
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
//    [self presentViewController:push animated:YES completion:nil];
    [self.navigationController pushViewController:push animated:NO];
    
}

#pragma mark - UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        return self.pushTransition;
    } else if (operation == UINavigationControllerOperationPop){
        return self.pushTransition;
    }
    return nil;
}



@end
