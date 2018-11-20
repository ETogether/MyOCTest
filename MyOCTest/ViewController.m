//
//  ViewController.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/5/4.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import "ViewController.h"

#import <Masonry/Masonry.h>

#import "ChartsController.h"
#import "UseFilterCoreViewController.h"
#import "TimingSetViewController.h"
#import "TestPickerViewController.h"
#import "AttributeStringVController.h"
#import "AESController.h"
#import "KeyboardController.h"
#import "SearchController.h"
#import "PickViewCircularlyController.h"
#import "TransitionAnimateController.h"
#import "TableController.h"
#import "KVOImpController.h"
#import "DatePickerController.h"
#import "FileListController.h"
#import "ThreadGCDController.h"
#import "ImageTestController.h"
#import "ButtonInsetsController.h"
#import "SpeechController.h"

//#import "KJDCustomButton.h"
//
//#import "UIButton+ContentRect.h"

#import <objc/runtime.h>
//@class TestClass;
//导入时需要使用需要使用 Charts.Swift去除警告关于Charts-Swift.h文件警告
//@import Charts.Swift;

@interface ViewController (){
    
}
///测试block回调修改属性值 -- 用block修改
@property (nonatomic,strong) UILabel *testBlockValue;
///测试block回调修改属性值 -- 直接修改
@property (nonatomic,strong) UILabel *testValue;

///测试block返回修改属性
@property (nonatomic,copy) NSString *testStr;

@end



@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    ///bug 在此处添加的通知，每当当前界面出来一次，通知就会被添加一次，所以通知还是别往此处添加 一般监听通知是放在ViewDidLoad
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationEvent:) name:@"ViewControllerAppear" object:nil];
}
-(void)notificationEvent:(NSNotification *)noti{
    static int count = 0;
    count += 1;
    NSLog(@"%d",count);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = RGB(213, 235, 216, 1);
    
    //头部
    UILabel *titleLbl = [[UILabel alloc] init];
    titleLbl.text = @"测试";
    titleLbl.font = FONT(32);
    titleLbl.textColor = [UIColor purpleColor];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLbl];
    
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(STATUSBARHEIGHT);
        make.width.mas_lessThanOrEqualTo(self.view).offset(-40);//小于等于宽度-40
        make.width.mas_greaterThanOrEqualTo(80); //大于等于80
    }];
    
    _testValue = [[UILabel alloc] initWithFrame:CGRectMake(12, STATUSBARHEIGHT, 60, 21)];
    _testValue.text = @"左边";
    [self.view addSubview:_testValue];
    
    _testBlockValue = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - 80, STATUSBARHEIGHT, 60, 21)];
    _testBlockValue.text = @"右边";
    [self.view addSubview:_testBlockValue];
    
    _testStr = @"sksk";
    
#pragma mark -- 内容部分
    [self settingView];
    
//   //测试自定义按钮
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(12, 120, 320, 40);
//    btn.backgroundColor = [UIColor redColor];
////    [btn setTitle:@"测试自定义按钮" forState:UIControlStateNormal];
////    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn setImage:[[UIImage imageNamed:@"huiyi_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
////    btn.titleRect = CGRectMake(70, 8, 42, 24);
////    btn.titleLabel.backgroundColor = [UIColor yellowColor];
////    btn.imageRect = CGRectMake(0, 5, 84, 48);
//    btn.tag = 101;
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
}
-(void)settingView{
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(NAVBARHEIGHT);
        make.bottom.offset(-40);
        make.left.right.offset(0);
        //        make.width.equalTo(self.view);
        //        make.height.offset(200);
    }];
    
    //用来设置按钮的共同属性
    NSMutableArray *btnArr = [[NSMutableArray alloc] init];
    NSArray *btnTitleArr = @[@"Charts折线图", @"滤芯使用寿命", @"定时设置", @"Picker--时间设置", @"富文本设置", @"AES加密解密", @"系统键盘自定义样式", @"搜索框", @"Picker--循环滚动", @"简单转场动画", @"UITableViewController使用", @"KVO实现", @"UIDatePickerView使用", @"应用文件列表", @"ThreadAndGCDTest", @"图片设置", @"UIButtonInsets相关属性", @"语音识别"];
    int count = (int)(btnTitleArr.count - 1);
    for (int i = count; i >= 0; i--) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:btnTitleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = RGB(213, 235, 216, 1);
        btn.tag = i + 10;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 20;//按钮统一设置高度为40，如添加约束是动态的高度（即高度值不固定） 可以在viewWillAppear系统方法求出btn的高度 或在调用下[btn layoutIfNeeded];
        
        [scroll addSubview:btn];
        [btnArr addObject:btn];
        
        if (i == count) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(40);
            }];
        }else{
            //获取上一个按钮
            UIButton *afterBtn = btnArr[count - i - 1];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(afterBtn.mas_bottom).offset(20);
            }];
            if (i == 0){
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.offset(-40);
                }];
            }
        }
        
    }
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(40);
        make.width.equalTo(scroll.mas_width).offset(-40);
    }];
    //TODO:     此处的scroll的contentSize.height应该还是零当添加多个view后，scroll不被滑动（猜想）
    //    UIButton *btn = btnArr[0];
    //    [scroll layoutIfNeeded];
    //    NSLog(@"%f", btn.frame.size.height);
    //
    
    //如[self.view layoutIfNeeded] 所有的视图的frame都出来；[beforeBtn layoutIfNeeded] beforeBtn及其子控件的frame都确认了。所以一般使用直接用self.view调用方法[self.view layoutIfNeeded]。如有特殊要求，就用某控件调用，但其子控件的frame也会出来的。
    //    UIButton *beforeBtn = btnArr[1];
    //    UIButton *btn = btnArr[0];
    //    [beforeBtn layoutIfNeeded];
    //    beforeBtn.userInteractionEnabled = YES;
    //    btn.userInteractionEnabled = YES;
    //    [self.view layoutIfNeeded];
    //    beforeBtn.userInteractionEnabled = NO;
    //    btn.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)btnClick:(UIButton *)sender{
    CQWEAK(self)
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ViewControllerAppear" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jieshougctz) name:@"我发送通知了" object:nil];

//    NSLog(@"测试");
    UIViewController *vc;
    switch (sender.tag - 10) {
        case 0:
        {
            //Charts折线图Å
            vc = [[ChartsController alloc] init];
            
        }
            break;
        case 1:
        {
            //滤芯使用寿命
            
            vc = [[UseFilterCoreViewController alloc] init];
            
        }
            break;
        case 2:
        {
            //滤芯使用寿命
            
            vc = [[TimingSetViewController alloc] init];
            
        }
            break;
        case 3:{
            //PickerView
            TestPickerViewController *testVC= [[TestPickerViewController alloc] init];
            testVC.test = @"测试";
            vc = testVC;
        }
            break;
        case 4:{
            //PickerView
//            TestPickerViewController *testVC= [[TestPickerViewController alloc] init];
//            testVC.test = @"测试";
            vc = [[AttributeStringVController alloc] init];
        }
            break;
        case 5:
        {
            //滤芯使用寿命
            
            vc = [[AESController alloc] init];
            
        }
            break;
        case 6:
        {
            //系统键盘自定样式
            vc = [[KeyboardController alloc] init];
        }
            break;
        case 7:
        {
            //UISearchBar 测试
            vc = [[SearchController alloc]  init];
        }
            break;
        case 8:
        {
            
            vc = [[PickViewCircularlyController alloc] init];
        }break;
        case 9:
        {
            //转场动画
            vc = [[TransitionAnimateController alloc] init];
        }break;
        case 10:
        {
            //UITableController
            vc = [[TableController alloc] init];
        }break;
        case 11:
        {
            vc = [[KVOImpController alloc] init];
        }break;
        case 12:
        {
            //系统UIDatePicker使用
            vc = [[DatePickerController alloc] init];
        }break;
        case 13:{
            vc = [[FileListController alloc] init];
        }break;
        case 14:{
            vc = [[ThreadGCDController alloc] init];
        }break;
        case 15:{//图片设置
            vc = [[ImageTestController alloc] init];
        }break;
        case 16:{//按钮的Insets属性
            __block UILabel *blockLbl = _testBlockValue;
            NSString *blockStr = @"block";
            __block NSString *changeBlcokStr = blockStr;
            ButtonInsetsController *button = [[ButtonInsetsController alloc] init];
            button.backBlock = ^(NSString * _Nonnull backName) {
                selfWeak.testValue.text = backName;
                blockLbl.text = backName;
                CQLog(@"%@ testStr:%@ blockStr:%@ change:%@",backName, selfWeak.testStr,blockStr,changeBlcokStr);
                selfWeak.testStr = backName;
                changeBlcokStr = backName;
                CQLog(@"%@ testStr:%@ blockStr:%@ change:%@",backName, selfWeak.testStr, blockStr, changeBlcokStr);
            };
            
            vc = button;
        }break;
        case 17:{//语音识别
            vc = [[SpeechController alloc] init];
        }break;
        default:
            break;
    }
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)jieshougctz{
    NSLog(@"接收到通知了");
    
    
    
    
}

@end







