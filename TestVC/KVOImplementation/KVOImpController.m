//
//  KVOImpController.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2018/4/9.
//  Copyright © 2018年 netvox. All rights reserved.
//

#import "KVOImpController.h"

#import "TitleView.h"

#import "Person.h"

#import "NSObject+CQKVO.h"

@interface KVOImpController ()

@property(nonatomic, strong) Person *p;

@end

@implementation KVOImpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self settingSubviews];
    
    Person *per = [[Person alloc] init];
    
//    [per addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];

    [per cq_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    _p = per;
    
    

    
    
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
    navBar.lbTitle.text = @"KVO实现";
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

//-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
//    
//}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"KeyPath: %@, name: %@, Object: %@, Change: %@",keyPath, _p.name, object, change);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    static int i = 0;
    i ++;
    _p.name = [NSString stringWithFormat:@"第%d个名字", i];
    _p.age = [NSString stringWithFormat:@"Age:%d", i];
}



@end
