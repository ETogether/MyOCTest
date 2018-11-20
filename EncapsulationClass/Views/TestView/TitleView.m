//
//  TitleView.m
//  videoSettingOfSWYdemon
//
//  Created by netvox-ios6 on 14/12/31.
//  Copyright (c) 2014年 netvox-ios6. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = NAVBARBGCOLOR;
        
        _btnLeft=[UIButton buttonWithType:UIButtonTypeSystem];
        _btnLeft.frame=CGRectMake(frame.origin.x, STATUSBARHEIGHT, 44, 44);
        [_btnLeft setImage:[UIImage imageNamed:@"cam_conn_set_back_icon"] forState:UIControlStateNormal];
        [_btnLeft setTintColor:[UIColor whiteColor]];
        _btnLeft.tag = 20;
        [_btnLeft addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnLeft];
        
        _btnRight=[UIButton buttonWithType:UIButtonTypeSystem];
        _btnRight.frame=CGRectMake(frame.size.width-60, STATUSBARHEIGHT,44, 44);
        _btnRight.backgroundColor=[UIColor clearColor];
        _btnRight.titleLabel.font=[UIFont systemFontOfSize:17];
        [_btnRight setTintColor:[UIColor whiteColor]];
        _btnRight.tag = 21;
        [_btnRight addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnRight];
        
        _lbTitle=[[UILabel alloc]initWithFrame:CGRectMake(60, STATUSBARHEIGHT, SCREENWIDTH - 60 * 2, 44)];//60:距右60  而左小于60 为了lab居中，左右一样的间距,距左也60；
        _lbTitle.font=[UIFont systemFontOfSize:17];
        _lbTitle.backgroundColor=[UIColor clearColor];
        _lbTitle.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_lbTitle];
        
        //        设置背景
        self.backgroundColor = [UIColor cyanColor];
        
        
        _btnRightTrobult=[UIButton buttonWithType:UIButtonTypeSystem];
        _btnRightTrobult.frame=CGRectMake(frame.size.width-50, STATUSBARHEIGHT + 5,30, frame.size.height-34);
        [_btnRightTrobult setTintColor:[UIColor whiteColor]];
        _btnRightTrobult.tag = 22;
        [_btnRightTrobult addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnRightTrobult];
        [_btnRightTrobult setImage:[UIImage imageNamed:@"other_warning_white"] forState:UIControlStateNormal];
//        _btnRightTrobult.hidden = YES;
        
        
    }
    return self;
    
}

#pragma mark  按钮事件
-(void)btnClick:(UIButton *)sender{
    
    CQWEAK(self)
    switch (sender.tag - 20) {
        case 0:
            selfWeak.backBlock(0);
            break;
        case 1:
            selfWeak.backBlock(1);
            break;
        case 2:
            selfWeak.backBlock(2);
            break;
        default:
            break;
    }
}



@end
