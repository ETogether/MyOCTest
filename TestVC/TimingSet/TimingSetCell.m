//
//  TimingSetCell.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/5/10.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import "TimingSetCell.h"

@implementation TimingSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSLog(@"nib");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)btnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        NSLog(@"启动按钮");
    }else{
        NSLog(@"关闭按钮");
    }
}





@end
