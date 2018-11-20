//
//  TableController.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/11/23.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import "TableController.h"
#import "TitleView.h"


@interface TableController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UITableView *tableView;
//@property (nonatomic,strong) NSMutableArray<UITableViewCell*> *cellArr;
@end

@implementation TableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self settingSubviews];
    [self dataSource];
    [self tableView];
    
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
    navBar.lbTitle.text = @"系统键盘添加自定义样式";
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dataSource{
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    int j = 100;
    for (int i = 0; i < 40; i++) {
        NSString *row = [NSString stringWithFormat:@"第%02d页", i];
        NSString *detailStr = [NSString stringWithFormat:@"详细内容%02d条信息", j - i];
        NSDictionary *dic = @{@"row": row, @"detail": detailStr};
        [_dataArr addObject:dic];
    }
}
-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBARHEIGHT, SCREENWIDTH, SCREENHEIGHT - NAVBARHEIGHT) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CustomCellID"];
        [self.view addSubview:_tableView];
        [self.tableView reloadData];
    }
    return _tableView;
    
}
#pragma mark - UITableView Datasource Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count > 0 ? 1 : 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
//tableView没注册 [tableView dequeueReusableCellWithIdentifier:@"CustomCellID"]; 有内部注册(cell要创建)  会利用   内存占用小，但当前界面释放后，内存不会小进入前的量还多了不少
//tableView有注册 [tableView dequeueReusableCellWithIdentifier:@"CustomCellID"]; 无内部注册(cell无需创建)   会复用
//tableView有注册 [tableView dequeueReusableCellWithIdentifier:@"CustomCellID" forIndexPath:indexPath]; 无内部注册(cell无需创建)   会复用
//tableView没注册 [tableView dequeueReusableCellWithIdentifier:@"CustomCellID" forIndexPath:indexPath]; 无内部注册 -- 直接崩溃(reason: 'unable to dequeue a cell with identifier CustomCellID - must register a nib or a class for the identifier or connect a prototype cell in a storyboard')
//所以如列表已注册了，不需要在cellForRowAtIndexPath 再写复用机制
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCellID"];
    NSLog(@"cell:%p row:%ld",cell,(long)indexPath.row);
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"CustomCellID"];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        NSLog(@"cell:%p row:%ld",cell,(long)indexPath.row);
    }
    NSDictionary *dic = _dataArr[indexPath.row];
    NSString *title = [dic objectForKey:@"row"];
    NSString *detail = [dic objectForKey:@"detail"];
    cell.textLabel.text = title;
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
-(void)dealloc{
    NSString * selfStr = NSStringFromClass([self class]);
    NSLog(@"%@--控制器释放了", selfStr);
}
@end
