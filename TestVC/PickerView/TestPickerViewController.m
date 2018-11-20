//
//  TestPickerViewController.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/5/13.
//  Copyright © 2017年 netvox. All rights reserved.
//  --PickerViewTest

#import "TestPickerViewController.h"
#import "TitleView.h"

@interface TestPickerViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>{
    
    //第0组 第1组 第2组(component) 选中位置（row）
    NSInteger firstSelRow;
    NSInteger secondSelRow;
    NSInteger thirdSelRow;
    
}

@property (nonatomic, strong)UIPickerView *picker;
@property (nonatomic, copy)NSMutableArray *dataArr;

@end

@implementation TestPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //  ---***---  定制导航栏
    TitleView *titleView=[[TitleView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, NAVBARHEIGHT)];
    titleView.backgroundColor = [UIColor cyanColor];
    
    [titleView.lbTitle setText:@"定时设置"];
    titleView.lbTitle.textColor=[UIColor whiteColor];
    [self.view addSubview:titleView];
    
    UIButton *left = titleView.btnLeft;
//    [left setImage:[UIImage imageNamed:@"timing_back"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    left.tag=100;

    
    [self setData];
    [self setSubviews];
    
}

- (void)viewWillAppear:(BOOL)animated{

    //当字符存在时，都为YES
    _test = @"0101235100";
    for (int i = 0; i < _test.length; i ++) {
        unichar c = [_test characterAtIndex:i];
        
        if (c) {
            NSLog(@"%c YES", c);
        }else{
            NSLog(@"%c NO", c);
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//创建子视图并设置
-(void)setSubviews{
    
    firstSelRow = 0;
    secondSelRow = 0;
    thirdSelRow = 0;
    
    _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, NAVBARHEIGHT, SCREENWIDTH, 216)]; // SCREENWIDTH, SCREENHEIGHT - 64  568, 162 320 216
    _picker.backgroundColor = RGB(255, 255, 255, 1);
    _picker.delegate = self;
    _picker.dataSource = self;
    _picker.showsSelectionIndicator = YES;
    [self.view addSubview:_picker];
//    [_picker selectRow:3 inComponent:2 animated:YES];
//    [_picker selectRow:2 inComponent:1 animated:YES];
    
}
//设置数据
-(void)setData{
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    //上、下午
    NSArray *noonArr = @[@"上午",@"下午"];
    NSArray *hourArr = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12"];
    NSMutableArray *minArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 60; i ++) {
        [minArr addObject:[NSString stringWithFormat:@"%02d", i]];
    }
    [_dataArr addObject:noonArr];
    [_dataArr addObject:hourArr];
    [_dataArr addObject:minArr];
}

#pragma mark -- 按钮事件
-(void)btnClick:(UIButton *)sender{
    switch (sender.tag - 100) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}

#pragma mark -- pickerView 协议代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _dataArr.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSArray *arr = _dataArr[component];
    
    return arr.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 50;
}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, [pickerView rowSizeForComponent:component].width - 12, [pickerView rowSizeForComponent:component].height)];
//    lbl.layer.borderColor = [UIColor cyanColor].CGColor;
//    lbl.layer.borderWidth = 2;
//    NSArray *time = _dataArr[component];
//    lbl.text = time[row];
//    lbl.textColor = [UIColor cyanColor];
//    lbl.textAlignment = NSTextAlignmentCenter;
//    lbl.font = [UIFont systemFontOfSize:21];
//    
//    return lbl;
//}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSLog(@"View");
    //设置分割线的颜色
    NSInteger lineCount = 0;
    for (UIView *singleLine in pickerView.subviews) {
        
        if (singleLine.frame.size.height < 1) {
            singleLine.backgroundColor = [UIColor yellowColor];
            lineCount ++;
            if (lineCount >= 2) {
                //两条分割线 查找完毕结束循环
                break;
            }
        }
    }
    
    //重新定义 row的Label
    UILabel *pickLbl = (UILabel *)view;
    if (!pickLbl) {
        pickLbl = [[UILabel alloc] init];
        pickLbl.adjustsFontSizeToFitWidth = YES;
        pickLbl.textAlignment = NSTextAlignmentCenter;
        pickLbl.backgroundColor = [UIColor clearColor];
        pickLbl.font = [UIFont systemFontOfSize:36];
    }
    //填充文字 -- NSString  重写titleForRow...方法
//    pickLbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    
    
    //          NSAttributeString   重写attributedTitleForRow...方法
//    pickLbl.attributedText = [self pickerView:pickerView attributedTitleForRow:row forComponent:component];
//    
    if (component == 0) {
        if (row == firstSelRow) {
            pickLbl.attributedText = [self pickerView:pickerView attributedTitleForRow:row forComponent:component];
        } else {
            pickLbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        }
    }else if(component == 1){
        if (row == secondSelRow) {
            pickLbl.attributedText = [self pickerView:pickerView attributedTitleForRow:row forComponent:component];
        } else {
            pickLbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        }
    }else {
        if (row == thirdSelRow) {
            pickLbl.attributedText = [self pickerView:pickerView attributedTitleForRow:row forComponent:component];
        } else {
            pickLbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        }
    }
   
    
    NSLog(@"view: == %ld", (long)row);
    
    return pickLbl;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSLog(@"String");
    NSArray *time = _dataArr[component];
    return time[row];
}

-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSLog(@"Attribute");
    NSString *title = _dataArr[component][row];
    
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:42], NSForegroundColorAttributeName:[UIColor redColor]};
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:title attributes:attr];

    
    return attrStr;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"selected");
    
    if (component == 0) {
        firstSelRow = row;
    }else if(component == 1){
        secondSelRow = row;
    }else {
        thirdSelRow = row;
    }
    
    UILabel *lbl = (UILabel *)[pickerView viewForRow:row forComponent:component];
    [self pickerView:pickerView viewForRow:row forComponent:component reusingView: lbl];
//    lbl.attributedText = [self pickerView:pickerView attributedTitleForRow:row forComponent:component];
//
    NSLog(@"selected: == %ld", (long)row);
}


@end
