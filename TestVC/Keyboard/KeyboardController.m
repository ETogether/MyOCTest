//
//  KeyboardController.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/9/27.
//  Copyright © 2017年 netvox. All rights reserved.
//

//系统键盘添加自定义样式

#import "KeyboardController.h"

#import "Masonry.h"
#import "TitleView.h"

@interface KeyboardController ()<UITextFieldDelegate>{
    //输入框
    UITextField *tf;
    //输入框
    UITextField *tf1;
    //输入文本
//    UITextView *textView;
}
@property (nonatomic, strong)UITextView *textView;

@end

@implementation KeyboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self settingSubviews];
    
    // Do any additional setup after loading the view.
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
    
    tf = [[UITextField alloc] initWithFrame:CGRectMake(20, NAVBARHEIGHT + 40, SCREENWIDTH - 40, 40)];
    tf.placeholder = @"使用设置UITextField的inputAccesoryView属性";
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.delegate = self;
    [self.view addSubview:tf];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
    customView.backgroundColor = [UIColor cyanColor];
    tf.inputAccessoryView = customView;
    
    UIButton * customBtn = [[UIButton alloc] init];
    customBtn.backgroundColor = [UIColor whiteColor];
    customBtn.tag = 0;
    customBtn.clipsToBounds = YES;
    customBtn.layer.cornerRadius = 20;
    [customBtn setTitle:@"收键盘" forState:UIControlStateNormal];
    [customBtn setTitleColor:RGB(211, 83, 32, 1) forState:UIControlStateNormal];
    [customBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:customBtn];
    [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(40);
    }];
    
    UIButton * addNotiBtn = [[UIButton alloc] init];
    addNotiBtn.backgroundColor = [UIColor cyanColor];
    addNotiBtn.tag = 1;
    addNotiBtn.clipsToBounds = YES;
    addNotiBtn.layer.cornerRadius = 20;
    [addNotiBtn setTitle:@"接收键盘显示监听" forState:UIControlStateNormal];
    [addNotiBtn setTitle:@"取消键盘显示监听" forState:UIControlStateSelected];
    [addNotiBtn setTitleColor:RGB(211, 83, 32, 1) forState:UIControlStateNormal];
    [addNotiBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addNotiBtn];
    [addNotiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(200);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(40);
    }];
    
    tf1 = [[UITextField alloc] initWithFrame:CGRectMake(20, NAVBARHEIGHT + 40 + 240, SCREENWIDTH - 40, 40)];
    tf1.placeholder = @"使用设置UITextField的inputAccesoryView属性";
    tf1.borderStyle = UITextBorderStyleRoundedRect;
    tf1.delegate = self;
    [self.view addSubview:tf1];
}

#pragma mark - 按钮事件
-(void)btnClick:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            NSLog(@"0点击了");
            [tf resignFirstResponder];
        }
            break;
        case 1:
        {
            [self textView];
            NSLog(@"1点击了");
            btn.selected = !btn.selected;
            [self addNotificationForYes:btn.selected];
        }
            break;
        case 2:
        {
            NSLog(@"2点击了");
        }
            break;
        default:
            break;
    }
}

-(void)addNotificationForYes:(BOOL)isYes{
    if (isYes) {
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowAddCustomView:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowAddCustomView:) name:UIKeyboardWillHideNotification object:nil];
    }else{
//        [tf1 resignFirstResponder];
        //移除监听
        [[NSNotificationCenter defaultCenter] removeObserver:self];
//        [tf1 resignFirstResponder];
    }
}

//根据键盘状态，调整textView的位置
-(void)keyboardWillShowAddCustomView:(NSNotification *)noti{
    
    NSDictionary *userInfo = [noti userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardEndOY = value.CGRectValue.origin.y; //得到键盘弹出后的键盘视图所在的Y坐标
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];//得到键盘弹出动画时间
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    //添加移动动画，使视图跟键盘移动
    [UIView animateWithDuration:duration.doubleValue animations:^{
       
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        
        _textView.center = CGPointMake(_textView.center.x, keyboardEndOY - _textView.frame.size.height / 2.0);    //keyboardEndY的坐标包括了状态栏的高度，要减去
        
    }];
    
    
}

-(UITextView *)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 0, SCREENWIDTH - 40, 40)];
        _textView.backgroundColor = [UIColor yellowColor];
        _textView.text = @"尼妹q";
        _textView.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_textView];
    }
    
    return _textView;
}


#pragma makr - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
