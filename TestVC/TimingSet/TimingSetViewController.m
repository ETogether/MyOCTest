//
//  TimingSetViewController.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/5/10.
//  Copyright © 2017年 netvox. All rights reserved.
//
// 定时设置



#import "TimingSetViewController.h"

#import "TitleView.h"
#import "TimingSetCell.h"


@interface TimingSetViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *timingView;

@property (nonatomic, strong)NSMutableArray *dataArr;


@end

@implementation TimingSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //  ---***---  定制导航栏
    TitleView *titleView=[[TitleView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, 64)];
    titleView.backgroundColor = [UIColor cyanColor];
    
    [titleView.lbTitle setText:@"定时设置"];
    titleView.lbTitle.textColor=[UIColor whiteColor];
    [self.view addSubview:titleView];
    
    UIButton *left = titleView.btnLeft;
    [left setImage:[UIImage imageNamed:@"timing_back"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    left.tag=100;
    
    UIButton *right = titleView.btnRight;
    [right setImage:[UIImage imageNamed:@"timing_add"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    right.tag=101;
    
    NSString *url = @"http://192.168.1.81/cgi-bin/rest/network/GetAirClearCheckData.cgi?callback=1234&encodemethod=NONE&sign=AAA";
    _dataArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self GetAirClearCheckData:url];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    
    //刷新tableView
    [self.timingView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableView的getter方法
-(UITableView *)timingView{
    if (!_timingView) {
        _timingView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBARHEIGHT, SCREENWIDTH, SCREENHEIGHT - NAVBARHEIGHT) style:UITableViewStylePlain];
        _timingView.delegate = self;
        _timingView.dataSource = self;
        _timingView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_timingView];
        
        _timingView.backgroundColor = RGB(242, 242, 242, 1);
        
        //注册cell
        [_timingView registerNib:[UINib nibWithNibName:@"TimingSetCell" bundle:nil] forCellReuseIdentifier:@"TimingSetForCell"];
        
        
    }
    return _timingView;
}

#pragma mark -- 网络请求 
//此处不是CallBack数据, 数据是由网络请求过来的
-(void)GetAirClearCheckData:(NSString *)urlStr{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (!error) {
                //由于返回的数据不是标准的json串（在json串的标准上多了“(json串)”）
                NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSDictionary *dic = [self screenData:dataStr];
                NSArray *respData = dic[@"response_params"];
                if (respData) {
                    [_dataArr removeAllObjects];
                    //获取所有获取
                    [_dataArr addObjectsFromArray:respData];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.timingView reloadData];
                    });
                    
                    
                    
                }else{
                    //增加/删除
                    NSDictionary *respDic = dic[@"response_params"];
//                    "status_msg": "succeed" 
                    if ([respDic[@"status_msg"] isEqualToString:@"succeed"]) {
                        NSLog(@"增加/删除失败");
                    }else{
                        NSLog(@"增加/删除失败");
                    }
                }
            }else{
                NSLog(@"网络请求错误");
            }
            
        }];
        
        [task resume];
    });

    
    
}



#pragma mark -- 点击事件
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


#pragma mark -- tableView协议代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TimingSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimingSetForCell"];
    if (!cell) {
        cell = [[TimingSetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TimingSetForCell"];
    }
    NSDictionary *dic = _dataArr[indexPath.row];
    
    NSString *onOrOff;
    NSMutableString *time = [[NSMutableString alloc] initWithCapacity:0];
    BOOL status;
    
    //开1/关0 是否启动（1是 0否）
    NSNumber *bAction = dic[@"bAction"];
    NSNumber *bCheck = dic[@"bCheck"];
    NSString *dateCheck = dic[@"dateCheck"];
    NSString *actionTime = dic[@"actionTime"];
    
    if (bAction.intValue == 1) {
        onOrOff = @"开";
    }else{
        onOrOff = @"关";
    }
    if (bCheck.intValue == 1){
        status = YES;
    }else{
        status = NO;
    }
    NSArray *weakArr = @[@"日/", @"一/", @"二/", @"三/", @"四/", @"五/", @"六/"];
    
    for (int i = 0; i < dateCheck.length; i++) {
        unichar c = [dateCheck characterAtIndex:i];
        NSLog(@"%c", c);
        if (c == '1') {
//            [time insertString:weakArr[i] atIndex:i + 1];
            [time appendString:weakArr[i]];
        }
    }
    //判断
    if ([time rangeOfString:@"日/六/"].location != NSNotFound){
        time = [NSMutableString stringWithFormat:@"周末"];
    }else if ([time rangeOfString:@"日/一/二/三/四/五/六/"].location != NSNotFound){
        time = [NSMutableString stringWithFormat:@"每天"];
    }else if([time rangeOfString:@"一/二/三/四/五/"].location != NSNotFound){
        time = [NSMutableString stringWithFormat:@"工作日"];
    }else{
        [time deleteCharactersInRange:NSMakeRange(time.length - 1, 1)];
        [time insertString:@"周" atIndex:0];
    }
    
    [time appendString:@"    "];
    [time appendString:actionTime];
    
    cell.statusLbl.text = onOrOff;
    cell.timeLbl.text = time;
    cell.statusBtn.selected = status;
    
    
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"左滑时删除按钮标题";
}
//执行左滑事件
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    
    return @[delete];
}

//字符串操作
-(NSDictionary *)screenData:(NSString *)str
{
    NSDictionary *obj = nil;
    
    long m = -1,n = [str length];
    
    for (long i = 0; i < [str length]; i++) {
        NSString *sub = [str substringWithRange:NSMakeRange(i, 1)];
        if([sub isEqualToString:@"{"]){
            
            break;
            
        }
        
        if ([sub isEqualToString:@"("]) {
            m = i;
            break;
        }
    }
    
    NSString *newStr = [str substringFromIndex:m + 1];
    
    for (long j = [newStr length] - 1; j < [newStr length]; j--) {
        
        if (m == -1) {
            
            break;
            
        }
        
        NSString *sub = [newStr substringWithRange:NSMakeRange(j, 1)];
        if ([sub isEqualToString:@")"]) {
            n = j;
            break;
        }
    }
    
    
    //    if (newStr.length-1<n) {
    //        return nil;
    //    }
    NSString *subStr = [newStr substringToIndex:n];
    
    //将括号里的部分转换成data
    NSData *response = [subStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //将data转换成dic
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
    
    obj = dic;
    
    return obj;
}


@end
