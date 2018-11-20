//
//  ChartsController.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/5/5.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import "ChartsController.h"

#import "TitleView.h"
//#import "ChartsLineView.h"

//@import Charts.Swift;



@interface ChartsController (){
    
}
//@property (nonatomic, strong)ChartsLineView *lineView;

@end

@implementation ChartsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//    LineChartView *line = [[LineChartView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
//    [self.view addSubview:line];
    
    //导航栏
    TitleView *titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, NAVBARHEIGHT)];
    titleView.backgroundColor = [UIColor cyanColor];
    titleView.lbTitle.text = @"Charts折线图";
    [self.view addSubview:titleView];
    [titleView.btnLeft addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    titleView.btnLeft.tag = 100;
    

    //折线图
//    _lineView = [[ChartsLineView alloc] initWithFrame:CGRectMake(20, 80, SCREENWIDTH - 40, 300) andColors:@{@"outroom":[UIColor orangeColor], @"inroom":[UIColor purpleColor]} andBGColor:[UIColor yellowColor]];
//    [self.view addSubview:_lineView];
   
    //给折线图数据
//    NSDictionary *dic = @{@"request_id":@"req1234",@"response_params":@{@"result":@1,@"data":@[@{@"type":@"inroom",@"value":@[@{@"aqi":@97,@"label":@"2017-05-16 15:00:00"},@{@"aqi":@91,@"label":@"2017-05-16 16:00:00"},@{@"aqi":@87,@"label":@"2017-05-16 17:00:00"},@{@"aqi":@73,@"label":@"2017-05-16 18:00:00"},@{@"aqi":@0,@"label":@"2017-05-16 20:00:00"},@{@"aqi":@50,@"label":@"2017-05-17 08:00:00"},@{@"aqi":@68,@"label":@"2017-05-17 09:00:00"},@{@"aqi":@88,@"label":@"2017-05-17 10:00:00"},@{@"aqi":@88,@"label":@"2017-05-17 11:00:00"},@{@"aqi":@69,@"label":@"2017-05-17 12:00:00"},@{@"aqi":@78,@"label":@"2017-05-17 13:00:00"},@{@"aqi":@152,@"label":@"2017-05-17 14:00:00"}]},@{@"type":@"outroom",@"value":@[@{@"aqi":@"68",@"label":@"2017-05-16 15:00:00"},@{@"aqi":@"73",@"label":@"2017-05-16 16:00:00"},@{@"aqi":@"73",@"label":@"2017-05-16 17:00:00"},@{@"aqi":@"62",@"label":@"2017-05-16 18:00:00"},@{@"aqi":@"59",@"label":@"2017-05-16 19:00:00"},@{@"aqi":@"61",@"label":@"2017-05-16 20:00:00"},@{@"aqi":@"59",@"label":@"2017-05-16 21:00:00"},@{@"aqi":@"60",@"label":@"2017-05-16 22:00:00"},@{@"aqi":@"59",@"label":@"2017-05-16 23:00:00"},@{@"aqi":@"61",@"label":@"2017-05-17 00:00:00"},@{@"aqi":@"62",@"label":@"2017-05-17 01:00:00"},@{@"aqi":@"60",@"label":@"2017-05-17 02:00:00"},@{@"aqi":@"60",@"label":@"2017-05-17 03:00:00"},@{@"aqi":@"60",@"label":@"2017-05-17 05:00:00"},@{@"aqi":@"57",@"label":@"2017-05-17 05:00:00"},@{@"aqi":@"54",@"label":@"2017-05-17 06:00:00"},@{@"aqi":@"46",@"label":@"2017-05-17 07:00:00"},@{@"aqi":@"40",@"label":@"2017-05-17 08:00:00"},@{@"aqi":@"37",@"label":@"2017-05-17 09:00:00"},@{@"aqi":@"39",@"label":@"2017-05-17 10:00:00"},@{@"aqi":@"44",@"label":@"2017-05-17 11:00:00"},@{@"aqi":@"44",@"label":@"2017-05-17 12:00:00"},@{@"aqi":@"51",@"label":@"2017-05-17 13:00:00"},@{@"aqi":@"51",@"label":@"2017-05-17 14:00:00"}]}]}};
    
//    [_lineView completeRequestDictionry:dic];

}

-(void)addTheardTest{
    CQLog(@".....");
    NSThread *thread = [[NSThread alloc] init];
    thread.name = @"自定义线程";
    [self performSelector:@selector(runThreadDemo) onThread:thread withObject:nil waitUntilDone:NO];
    [thread start];
}
-(void)runThreadDemo{
    CQLog(@"%@",[NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //[self.navigationController popViewControllerAnimated:YES];
    [self addTheardTest];
}

-(void)btnClick:(UIButton *)sender{
    switch (sender.tag - 100) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
    
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
