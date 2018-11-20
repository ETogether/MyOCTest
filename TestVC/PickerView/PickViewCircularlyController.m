//
//  PickViewCircularlyController.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/11/2.
//  Copyright © 2017年 netvox. All rights reserved.
//


//PickerView的循环滚动

#import "PickViewCircularlyController.h"

#import "TitleView.h"

@interface PickViewCircularlyController ()<UIPickerViewDelegate, UIPickerViewDataSource>{
    
}
@property (nonatomic, strong)UIPickerView *circularlyPickview;
@property (nonatomic, strong)NSMutableArray *pickviewData;

@end

@implementation PickViewCircularlyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setData];
    
    [self settingSubviews];
    
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
    navBar.lbTitle.text = @"Pickview--循环滚动";
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
    
    _circularlyPickview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, NAVBARHEIGHT, 320, 216)];
    _circularlyPickview.center = self.view.center;
    _circularlyPickview.showsSelectionIndicator = YES;
    _circularlyPickview.delegate = self;
    _circularlyPickview.dataSource = self;
    
    [self.view addSubview:_circularlyPickview];
    
    
}

-(void)setData{
//    NSMutableArray *hours = [NSMutableArray arrayWithCapacity:0];
//    for (int i = 0; i < 24; i++) {
//        NSString *numberStr = [NSString stringWithFormat:@"%0d", i];
//        [hours addObject:numberStr];
//    }
//    NSArray *arr = @[@"00", @"15", @"30", @"45"];
//    _pickviewData = [NSMutableArray arrayWithCapacity:0];
//    
//    [_pickviewData addObject:hours];
    
    
}

#pragma makr - UIPickview Data Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 16384;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _pickviewData[row];
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component    {
    NSArray *strArray = component ? @[@"00", @"15", @"30", @"45"] : @[@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23"];
    NSString *titleStr = strArray[component ? (int)(row%4) : (int)(row%24)];
    NSAttributedString *attributedTitleStr= [[NSAttributedString alloc] initWithString:titleStr attributes:@{NSAttachmentAttributeName: [UIFont systemFontOfSize:30], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    return attributedTitleStr;
}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 60;
}

-(void)pickerViewLoaded:(NSInteger)component{
    NSUInteger max = 16384;
    NSUInteger base10 = (max / 2) - (max / 2) % (component ? 4 : 24);
    [_circularlyPickview selectRow:[_circularlyPickview selectedRowInComponent:component] % (component ? 4 : 24) + base10 inComponent:component animated:YES];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [self pickerViewLoaded:component];
    
    NSArray *strArray = component ? @[@"00", @"15", @"30", @"45"] : @[@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23"];
//    SelectionData *tempData = self.selectionDataArray[selectIndex];
//    if (component) {
//        tempData.selectMin = strArray[row % 4];
//    }   else    {
//        tempData.selectHour = strArray[row % 24];
//    }
//    [self.selectionDataArray replaceObjectAtIndex:selectIndex withObject:tempData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    return self.view.frame.size.width / 2;
//}
//
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
//    return 30;
//}
//
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView      {
//    return 2;
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component     {
//    return 16384;
//}
//
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component    {
//    NSArray *strArray = component ? @[@"00", @"15", @"30", @"45"] : @[@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23"];
//    NSString *titleStr = strArray[component ? (int)(row%4) : (int)(row%24)];
//    NSAttributedString *attributedTitleStr= [[NSAttributedString alloc] initWithString:titleStr attributes:@{NSAttachmentAttributeName: [UIFont systemFontOfSize:30], NSForegroundColorAttributeName: [UIColor whiteColor]}];
//    return attributedTitleStr;
//}
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component  {
//    [self pickerViewLoaded:component];
//    NSArray *strArray = component ? @[@"00", @"15", @"30", @"45"] : @[@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23"];
//    SelectionData *tempData = self.selectionDataArray[0];
//    if (component) {
//        tempData.selectMin = strArray[row % 4];
//    }   else    {
//        tempData.selectHour = strArray[row % 24];
//    }
//    [self.selectionDataArray replaceObjectAtIndex:selectIndex withObject:tempData];
//}
//
//-(void)pickerViewLoaded: (NSInteger)component {
//    NSUInteger max = 16384;
//    NSUInteger base10 = (max / 2) - (max / 2) % (component ? 4 : 24);
//    [dateBGView.datePicker selectRow:[dateBGView.datePicker selectedRowInComponent:component] % (component ? 4 : 24) + base10 inComponent:component animated:NO];
//}


@end
