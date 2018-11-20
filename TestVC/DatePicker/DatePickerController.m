//
//  DatePickerController.m
//  MyOCTest
//
//  Created by huitouke on 2018/5/8.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import "DatePickerController.h"

#import "TitleView.h"

#import <Masonry/Masonry.h>

#import "UIButton+ContentRect.h"

@interface DatePickerController ()
{
    
}
//
@property (nonatomic,strong) UIDatePicker  *picker;
//
@property (nonatomic,strong) UIView  *coverView;
@end

@implementation DatePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    //TODO: - 并不能写出想要的样子 不能进行代码的减少增加
    [self settingView];
     
}
#pragma mark - 页面布局
///页面设置
-(void)settingView{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNabBarView];
    [self addContentView];
}

///设置导航栏视图
-(void)setNabBarView{
    __weak typeof(self) weakSelf = self;
    TitleView *navBar = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, NAVBARHEIGHT)];
    navBar.lbTitle.text = @"UIDatePicker使用";
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
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVBARHEIGHT, 240, 200)];
    bgView.clipsToBounds = YES;
    bgView.backgroundColor = HEXCOLOR(0xeeeeee);
    bgView.alpha = 0.1;
    bgView.center = self.view.center;
    [self.view addSubview:bgView];
    
    _picker = [[UIDatePicker alloc] init];
    _picker.backgroundColor = [UIColor whiteColor];
    _picker.frame = CGRectMake(0, 0, 240, 200);
    _picker.maximumDate = [NSDate date];        //最大为当天
    _picker.datePickerMode = UIDatePickerModeDate;
    //    [datePickerView setDate:[NSDate date] animated:YES]; 默认为当天
    // 设置日期选择控件的地区
    [_picker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
//    [_picker setLocale:[NSLocale systemLocale]];
//    [_picker setLocale:[NSLocale currentLocale]];
    // 设置时区
    [_picker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+0800"]];
    [bgView addSubview:_picker];

    _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 200)];
    _coverView.backgroundColor = HEXCOLOR(0xeeeeee);
    _coverView.hidden = YES;
    [bgView addSubview:_coverView];
    
    
    UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reduceBtn.backgroundColor = [UIColor yellowColor];
    [reduceBtn setTitle:@"减少" forState:UIControlStateNormal];
    [reduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    reduceBtn.tag = 100;
    [reduceBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reduceBtn];
    [reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.equalTo(self.picker).offset(-125);
        make.size.sizeOffset(CGSizeMake(120, 40));
    }];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.backgroundColor = [UIColor yellowColor];
    [addBtn setTitle:@"增加" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBtn.tag = 101;
    [addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.equalTo(self.picker).offset(125);
        make.size.sizeOffset(CGSizeMake(120, 40));
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREENHEIGHT - 40, SCREENWIDTH, 40);
    btn.backgroundColor = HEXCOLOR(0x32eb31);
    [btn setTitle:@"还原" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.tag = 102;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
#pragma mark - 按钮事件
-(void)btnClick:(UIButton *)btn{
    
    _coverView.hidden = NO;
    switch (btn.tag - 100) {
        case 0:{
            //减少
            CQLog(@"减少 %ld",(long)btn.tag)
            CGFloat value = 240 / 3 / 2 + 5;
            _picker.cqX =  value; //显示年月
            _coverView.cqX = _picker.cqW - value;
            _coverView.cqW = value;
            
            
        }
            break;
        case 1:{
            //增加
            CQLog(@"增加 %ld",(long)btn.tag)
            _picker.cqX = -_picker.cqW / 3 ;//显示日
            CGFloat value = 240 / 3 * 0.75;
            _coverView.cqX = 0;
            _coverView.cqW = value;
        }
            break;
        case 2:{
            //还原
            CQLog(@"还原 %ld",(long)btn.tag)
            btn.selected = !btn.selected;
            if (btn.selected) {
                _picker.cqX = - 240 / 3 ;//显示月日
                CGFloat value = 240 / 3 * 0.8;
                _coverView.cqX = 0;
                _coverView.cqW = value;
            }else{
                _picker.cqX = 0;
                _coverView.hidden = YES;
            }
        }
            break;
        default:
            break;
    }
}

-(void)dealloc{
    NSString * selfStr = NSStringFromClass([self class]);
    NSLog(@"%@--控制器释放了", selfStr);
}



@end
