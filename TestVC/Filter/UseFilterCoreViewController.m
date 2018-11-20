//
//  UseFilterCoreViewController.m
//  Netvox
//
//  Created by netvox-ios1 on 2017/4/28.
//  Copyright © 2017年 netvox-ios6. All rights reserved.
//  滤蕊使用寿命

#import "UseFilterCoreViewController.h"
#import "TitleView.h"
#import "UseFilterCoreCell.h"

@interface UseFilterCoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *filterView;


@property (nonatomic, strong)NSMutableArray *dataArr;

@property (nonatomic, strong)NSArray *date;

//是否需要清洁或更换 --
@property(assign, nonatomic) BOOL clearTag;

@end

@implementation UseFilterCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavigationBar];
    
    _date = @[@29, @69, @177, @25];
    
}

-(void)viewWillAppear:(BOOL)animated{
    //放置请求中刷新
    [self.filterView reloadData];
}

//设置导航栏
- (void)setNavigationBar{
    
    TitleView *titleView=[[TitleView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, NAVBARHEIGHT)];
    titleView.backgroundColor = [UIColor cyanColor];
    
    [titleView.lbTitle setText:@"定时设置"];
    titleView.lbTitle.textColor=[UIColor whiteColor];
    [self.view addSubview:titleView];
    
    UIButton *left = titleView.btnLeft;
    [left setImage:[UIImage imageNamed:@"timing_back"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    left.tag=100;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置tableView
-(UITableView *)filterView{
    
    if(!_filterView){
        _filterView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBARHEIGHT, SCREENWIDTH, SCREENHEIGHT - NAVBARHEIGHT) style:UITableViewStylePlain];
        _filterView.delegate = self;
        _filterView.dataSource = self;
        _filterView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_filterView];
        _filterView.backgroundColor = RGB(242, 242, 242, 1);
        
        //添加头部
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH * 440 / 720)];
//        imgView.backgroundColor = [UIColor whiteColor];
        imgView.image = [UIImage imageNamed:@"UseFilterCore"];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, imgView.frame.size.height + 20)];
//        headerView.backgroundColor = RGB(242, 242, 242, 1);
        [headerView addSubview:imgView];
        _filterView.tableHeaderView = headerView;
        
        //注册cell
//        [_filterView registerNib:[UINib nibWithNibName:@"UseFilterCoreCell" bundle:nil] forCellReuseIdentifier:@"UseFilterCoreCell"];
        [_filterView registerClass:[UseFilterCoreCell self] forCellReuseIdentifier:@"UseFilterCoreCell"];

    }
    
    return _filterView;
    
}



-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] initWithCapacity:1];
        [_dataArr addObjectsFromArray:@[@"1、初过滤网", @"2、炭毡过滤网", @"3、活性炭过滤网", @"4、HEAP过滤网"]];
    }
    return _dataArr;
}


#pragma mark -- 按钮点击
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
            [self.navigationController popViewControllerAnimated:true];
            break;
            
        default:
            break;
    }
}


#pragma mark -- UITableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UseFilterCoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UseFilterCoreCell" forIndexPath:indexPath];
    NSNumber *num  = _date[indexPath.row];
    
    _clearTag = [cell customWithCellFilter:indexPath.row andName:_dataArr[indexPath.row] andUseDate:num.floatValue];
    cell.btnBlock = ^(){
        NSLog(@"已经处理按钮点击 %ld",(long)indexPath.row);
    };
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_clearTag) {
        return 115;
    }
    
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

@end
