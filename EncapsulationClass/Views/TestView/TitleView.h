//
//  TitleView.h
//  videoSettingOfSWYdemon
//
//  Created by netvox-ios6 on 14/12/31.
//  Copyright (c) 2014年 netvox-ios6. All rights reserved.
//  奈伯思第一版的头视图

#import "BaseController.h"

//typedef <#returnType#>(^<#name#>)(<#arguments#>);

@interface TitleView : UIView
//标题右侧按钮
@property (nonatomic,strong)UIButton *btnLeft;
//标题
@property (nonatomic,strong)UILabel *lbTitle;
//标题侧按钮
@property (nonatomic,strong)UIButton *btnRight;

//标题右侧故障按钮
@property (nonatomic,strong) UIButton * btnRightTrobult;

//block按钮事件
@property (nonatomic, copy)void(^backBlock)(int);



//定制标题栏
-(id)initWithFrame:(CGRect)frame1;
@end
