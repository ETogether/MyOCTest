//
//  AESController.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/6/29.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import "AESController.h"

#import "TitleView.h"
#import "Masonry.h"

#import "NTAESEncrypt.h"

//
#import "Encryption.h"


@interface AESController (){
    //--*输出加密串 输出解密串
    UILabel *encryptLbl;
    UILabel *decryptLbl;
    
    //--*输出加密串/输入解密串内容
    UITextField *edncryptTextField;
    //--*输出解密内容
    UITextField *decryptContent;
}

//***加/解 密密钥
@property (nonatomic, strong)UITextField *keyTextField;
@property (nonatomic, strong)UITextField *deKeyTextField;

//***加/解 密串
@property (nonatomic, strong)UITextField *encryptTextField;     //加密输入串
@property (nonatomic, strong)UITextField *decryptTextField;     //解密输出串



@property (nonatomic, strong)NSArray *textFieldArr;


@end

@implementation AESController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self settingSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/** 页面布局*/
-(void)settingSubviews{
    
    //导航栏
    TitleView *navBar = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, NAVBARHEIGHT)];
    [self.view addSubview:navBar];
    
    __weak typeof(self) weakSelf = self;
    
    navBar.lbTitle.text = @"AES加密解密测试";
    
    navBar.backBlock = ^(int tag){
        switch (tag) {
            case 0:
                [weakSelf.navigationController popViewControllerAnimated:true];
                break;
                
            default:
                break;
        }
    };
    
    
    //内容部分
    _keyTextField = [[UITextField alloc] init];
    _keyTextField.borderStyle = UITextBorderStyleLine;
    _keyTextField.placeholder = @"请输入加密/解密密钥";
    _keyTextField.text = @"NTX_SHARE_KEY000";
    _keyTextField.textColor = [UIColor redColor];
    _keyTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_keyTextField];
    [_keyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(40 + NAVBARHEIGHT);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(30);
    }];
    
    _encryptTextField = [[UITextField alloc] init];
    _encryptTextField.placeholder = @"请输入要加密的内容";
//    _encryptTextField.
    _encryptTextField.text = @"{\"houseIeee\":\"00137A00000384E1\",\"src_user\":\"18030259730\",\"timestamp\":1504839566319,\"type\":1}";
   
    
    _encryptTextField.textAlignment = NSTextAlignmentCenter;
    _encryptTextField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:_encryptTextField];
    [_encryptTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_keyTextField.mas_bottom).offset(20);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(30);
    }];
   
    
    //--*加密按钮
    UIButton *encryptBtn = [[UIButton alloc] init];
    encryptBtn.backgroundColor = [UIColor cyanColor];
    [encryptBtn setTitle:@"加密" forState:UIControlStateNormal];
    [encryptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    encryptBtn.layer.cornerRadius = 15;
    encryptBtn.tag = 520;
    [encryptBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:encryptBtn];
    [encryptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_encryptTextField.mas_bottom).offset(20);
        make.left.offset(40);
        make.right.offset(-40);
        make.height.offset(30);
    }];
    
    encryptLbl = [[UILabel alloc] init];
    encryptLbl.text = @"输出加密串:";
    [self.view addSubview:encryptLbl];
    [encryptLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(encryptBtn.mas_bottom).offset(20);
        make.left.offset(20);
        make.width.offset(200);
        make.height.offset(30);
    }];
    
    edncryptTextField = [[UITextField alloc] init];
    edncryptTextField.placeholder = @"输出加密内容，输入解密内容";
    edncryptTextField.text = @"EB79563422A27AB974286DFEFA8988E002ABD03CB568FED54D39421990FD0FC91823B41A86845565213AC800B1A361536784D5EC8C2835A24BD7898462E9F26C6FA5039DD75142C02A51698CB4CED128CBEF3DBBB0C2011038333F1AC09B6715";
    edncryptTextField.textAlignment = NSTextAlignmentCenter;
    edncryptTextField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:edncryptTextField];
    [edncryptTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(encryptLbl.mas_bottom).offset(20);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(30);
    }];
   
    
    //--*解密按钮
    UIButton *decryptBtn = [[UIButton alloc] init];
    decryptBtn.backgroundColor = [UIColor cyanColor];
    [decryptBtn setTitle:@"解密" forState:UIControlStateNormal];
    [decryptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    decryptBtn.layer.cornerRadius = 15;
    decryptBtn.tag = 521;
    [decryptBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:decryptBtn];
    [decryptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(edncryptTextField.mas_bottom).offset(20);
        make.left.offset(40);
        make.right.offset(-40);
        make.height.offset(30);
    }];
    
    decryptLbl = [[UILabel alloc] init];
    decryptLbl.text = @"输出解密串:";
    [self.view addSubview:decryptLbl];
    [decryptLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(decryptBtn.mas_bottom).offset(20);
        make.left.offset(20);
        make.width.offset(200);
        make.height.offset(30);
    }];
    
    decryptContent = [[UITextField alloc] init];
    decryptContent.borderStyle = UITextBorderStyleLine;
    decryptContent.placeholder = @"输出解密后的内容";
//    decryptContent.text =
    decryptContent.textAlignment = NSTextAlignmentCenter;
    decryptContent.textColor = [UIColor greenColor];
    [self.view addSubview:decryptContent];
    [decryptContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(decryptLbl.mas_bottom).offset(20);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(30);
    }];
    
    _textFieldArr = @[_keyTextField, _encryptTextField, edncryptTextField, decryptContent];
    
}

-(void)btnClick:(UIButton *)sender{
    for (UITextField *tf in _textFieldArr) {
        [tf resignFirstResponder];
    }
    switch (sender.tag - 520) {
        case 0:
        {
            NSLog(@"点击加密 加密内容为：%@", self.encryptTextField.text);
            NSString *encryptStr = _encryptTextField.text;
            while (encryptStr.length % 16) {//补足16位的倍数
                encryptStr = [encryptStr stringByAppendingString:@"#"];
            }
            
            edncryptTextField.text = [NTAESEncrypt stringNTAES256EncryptContent:encryptStr withKey:_keyTextField.text];
            //NSData *encryptData = [self.encryptTextField.text dataUsingEncoding:NSUTF8StringEncoding];
//           edncryptTextField.text = [[NSString alloc] initWithData:[encryptData AES256EncryptWithKey:_keyTextField.text] encoding:NSUTF8StringEncoding];
            NSLog(@"加密后的内容：%@", edncryptTextField.text);
        }
            break;
        case 1:
        {
            NSLog(@"解密前的内容：%@", edncryptTextField.text);
            decryptContent.text = [NTAESEncrypt stringNTAES256DecryptContent:edncryptTextField.text withKey:_keyTextField.text];
//            decryptContent.text = [[NSString alloc] initWithData:[[edncryptTextField.text dataUsingEncoding:NSUTF8StringEncoding] AES256DecryptWithKey:_keyTextField.text] encoding:NSUTF8StringEncoding];
            NSLog(@"解密后的内容：%@", decryptContent.text);
        }
            break;
        default:
            break;
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITextField *tf in _textFieldArr) {
        [tf resignFirstResponder];
    }
}


@end
