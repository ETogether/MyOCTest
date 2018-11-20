//
//  SearchController.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/10/20.
//  Copyright © 2017年 netvox. All rights reserved.
//

//使用UISearchBar

#import "SearchController.h"
#import "TitleView.h"




@interface SearchController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>{
    
    NSMutableArray *resultArray;
    
}
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UITableView *tabView;


@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self settingSubviews];
    resultArray = [[NSMutableArray alloc] initWithCapacity:0];
//    resultArray = self.dataArr;                       //不行
    resultArray = [self.dataArr mutableCopy];           //通过
//    [resultArray addObjectsFromArray:self.dataArr];   //通过
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [_tabView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"我发送通知了" object:nil];
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
    navBar.lbTitle.text = @"UISearchBar测试使用";
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
    
    _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBARHEIGHT, SCREENWIDTH, SCREENHEIGHT - NAVBARHEIGHT) style:UITableViewStylePlain];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
    
    searchBar.delegate = self;
    
    _tabView.tableHeaderView = searchBar;
    
    [self.view addSubview:_tabView];
    
}

#pragma mark - 数据源
-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] initWithCapacity:1];
        for (int i = 0; i <= 100; i++) {
            NSString *value = [NSString stringWithFormat:@"%03d", i];
            [_dataArr addObject:value];
        }
    }

    return _dataArr;
}



#pragma mark - UTableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  resultArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tabViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tabViewCell"];
    }
    cell.textLabel.text = resultArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}


#pragma mark - UISearchBar Delegate
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"完成内容编辑");
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"内容在改变");
    
    [resultArray removeAllObjects];
    //加个多线程，否则数量量大的时候，有明显的卡顿现象
    //这里最好放在数据库里面再进行搜索，效率会更快一些
    if (searchText != nil && searchText.length > 0) {
        
        for (NSString *content in self.dataArr) {
            
            if ([content rangeOfString:searchText options:NSCaseInsensitiveSearch].length > 0){
                [resultArray addObject:content];
            }
        }

    } else {
//        resultArray = self.dataArr;                               //不行
//        [resultArray addObjectsFromArray:self.dataArr];           //通过
        resultArray = [self.dataArr mutableCopy];                   //通过
    }
    [_tabView reloadData];
}


@end
