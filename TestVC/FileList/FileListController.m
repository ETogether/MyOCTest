//
//  FileListController.m
//  MyOCTest
//
//  Created by huitouke on 2018/6/26.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import "FileListController.h"

#import "TitleView.h"

#import <MapKit/MapKit.h>//系统自带api地图
#import <CoreLocation/CoreLocation.h>//定位服务

@interface FileListController ()<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,CLLocationManagerDelegate>{
    
}

//列表
@property (nonatomic,strong) UITableView *listView;

///文件名列表
@property (nonatomic,strong) NSMutableArray *files;

///列表头视图内容 2
@property (nonatomic,strong) MKMapView *mapView;
///定位服务 - 需要全局存在
@property (nonatomic,strong) CLLocationManager *locationManager;

///列表头视图 内容 1
//@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation FileListController

-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

-(MKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] init];
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
        _mapView.zoomEnabled = YES;
        _mapView.scrollEnabled = YES;
        _mapView.mapType = MKMapTypeStandard;
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(24.000, 118.000);
        //设置显示范围
        MKCoordinateSpan span = MKCoordinateSpanMake(1, 1);
        //
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(24.000, 118.000);
        MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
        [_mapView setRegion:region animated:YES];
    }
    return _mapView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingView];
    [self addData];
    [self.locationManager startUpdatingLocation];//开始定位
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
    CQWEAK(self)
    TitleView *navBar = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, NAVBARHEIGHT)];
    navBar.lbTitle.text = @"本地文件列表";
    
    navBar.backBlock = ^(int tag) {
        [selfWeak.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:navBar];
    
}
///添加内容视图
-(void)addContentView{
    
    _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBARHEIGHT, SCREENWIDTH, SCREENHEIGHT - NAVBARHEIGHT) style:UITableViewStyleGrouped];
    _listView.delegate = self;
    _listView.dataSource = self;
    [_listView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"FileListCell"];
    [self.view addSubview:_listView];
    
    //添加头视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 240)];
    headerView.backgroundColor = HEXCOLOR(0x13d831);
    _listView.tableHeaderView = headerView;
    
    self.mapView.frame = headerView.bounds;
    [headerView addSubview:_mapView];
    
    //头视图内容 1
//    _scrollView = [[UIScrollView alloc] initWithFrame:headerView.bounds];
//    _scrollView.backgroundColor = [UIColor yellowColor];
//    _scrollView.contentSize = CGSizeMake(2 * headerView.cqW, 240 * 2);
//    [headerView addSubview:_scrollView];
    
    
}
///获取文件/文件夹数据
-(void)addData{
    //文件操作对象
    NSFileManager *fileManger = [NSFileManager defaultManager];
    //文件夹路径
    NSString *home = [@"~" stringByExpandingTildeInPath];//根目录文件夹
    NSString *homeDocu = [home stringByAppendingString:@"/Documents"];
    NSString *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    if ([homeDocu isEqualToString:documents]) {
//        CQLog(@"相等");
//    }
    
    for (int i=0; i<50; i++) {
        
        NSString *name = [NSString stringWithFormat:@"%@/文件名%02d.txt",documents,i];
        NSString *contents = [NSString stringWithFormat:@"写入的内容是%04d",i];
        if (![fileManger fileExistsAtPath:name]) {//文件不存在创建
            if ([fileManger createFileAtPath:name contents:[contents dataUsingEncoding:NSUTF8StringEncoding] attributes:nil]){
                CQLog(@"创建成功");
            }else{
                CQLog(@"文件创建失败");
            }
        }else{
            CQLog(@"文件不存在！");
        }
    }
    
    
    
    
    //目录迭代器
    NSDirectoryEnumerator *direnum = [fileManger enumeratorAtPath:homeDocu];
    
    _files = [NSMutableArray arrayWithCapacity:0];
    
    //遍历目录迭代器，获取各个文件路径
    NSString *fileName;
    while (fileName = [direnum nextObject]) {
        if ([[fileName pathExtension] isEqualToString:@"jpg"] || [[fileName pathExtension] isEqualToString:@"png"]) {//筛选出文件类型的文件
            [_files addObject:[fileName stringByAppendingString:@"图片"]];
        }else{
            [_files addObject:fileName];
        }
    }
    CQLog(@"%ld",(long)_files.count);
    
    //输出列表
    NSEnumerator *enume = [_files objectEnumerator];
    while (fileName = [enume nextObject]) {
        CQLog(@"%@",fileName);
    }
    [_listView reloadData];
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

#pragma mark - UITableView Datasource Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _files.count > 0 ? 1 : 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _files.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"FileListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _files[indexPath.row];
    
    return cell;
}
//delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
}

#pragma mark - MKMapViewDelegate方法
//-(void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
//    CQLog(@"将开始加载地图");
//}
//-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
//    CQLog(@"已完成地图加载");
//}
-(void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error{
    CQLog(@"地图加载失败Error：%@",error);
}
//-(void)mapViewDidStopLocatingUser:(MKMapView *)mapView{
//    CQLog(@"停止 用户定位");
//}

#pragma mark - CLLocationManager代理方法 定位代理
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [manager stopUpdatingLocation];
    [_mapView setCenterCoordinate:locations[0].coordinate animated:YES];
    CQLog(@"完成定位服务 %@,%@",locations,locations[0].timestamp);
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [manager stopUpdatingLocation];
    CQLog(@"定位服务失败Error：%@",error);
}

-(void)dealloc{
    NSString * selfStr = NSStringFromClass([self class]);
    NSLog(@"%@--控制器释放了", selfStr);
}

@end
