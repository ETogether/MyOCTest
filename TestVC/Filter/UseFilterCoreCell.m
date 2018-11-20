//
//  UseFilterCoreCell.m
//  Netvox
//
//  Created by netvox-ios1 on 2017/4/28.
//  Copyright © 2017年 netvox-ios6. All rights reserved.
//

#import "UseFilterCoreCell.h"

#import "Masonry.h"

@implementation UseFilterCoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone; //取消默认点击Cell背景色类型
}

//由颜色生成图片 http://www.jianshu.com/p/1739f7e5e744
-(UIImage *)imageForColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *colorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return colorImg;
    
}
-(BOOL)customWithCellFilter:(NSInteger)filter andName:(NSString *)name andUseDate:(CGFloat)date{
    
    //是否需要清洁或更换
    BOOL clearTag = NO;
    
    //滤网/芯的寿命 提醒时间条件
    CGFloat time;
    NSInteger remainDate;
    switch (filter) {
        case 0:
        {
            time = 30;
            remainDate = 1;
        }
            
            break;
        case 1:
        {
            time = 90;
            remainDate = 2;
        }
            break;
        case 2:
        case 3:
        {
            time = 180;
            remainDate = 3;
        }
            break;
            
        default:
            break;
    }
    //提醒颜色 -- 剩余天数 进度条
    UIColor *remindColor = RGB(36, 217, 185, 1);
    if (time - date <= remainDate) {
        remindColor= RGB(255, 90, 77, 1);
        clearTag = true;
    }
    CGFloat nameWidth = [name boundingRectWithSize:CGSizeMake(99999, 23) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil].size.width + 5;
    //滤网名
    UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, nameWidth, 23)];
    nameLbl.font = FONT(17);
    nameLbl.text = name;
    [self addSubview:nameLbl];
    
    
    //剩余天数
    UILabel *remainLbl = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - 120 -20, 0, 120, 33)];
    remainLbl.textAlignment = NSTextAlignmentRight;
    remainLbl.font = FONT(17);
    [self addSubview:remainLbl];
    NSString *text = [NSString stringWithFormat:@"剩余%.f天", time - date];
    remainLbl.attributedText = [self attributeTextWithColor:remindColor andText:text andRangStr:[NSString stringWithFormat:@"%.f", time - date]];
    
    
    //天数进度条
    UIProgressView *dateRemindPgs = [[UIProgressView alloc] initWithFrame:CGRectMake(20, 33 + 10 + 5, self.frame.size.width - 40, 20)]; //Y坐标： + 10，跟下面transform有关
    //        let transform = CGAffineTransformMakeScale(1.0, 2.0)
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 10.0);
    dateRemindPgs.transform = transform;
    dateRemindPgs.trackImage = [self imageForColor:RGB(204, 204, 204, 1)];
    dateRemindPgs.progressImage = [self imageForColor:remindColor];
    dateRemindPgs.progress = date / time;
    [self addSubview:dateRemindPgs];
    
    NSString *useText = [NSString stringWithFormat:@"已使用%.f天", date];
    CGFloat useWidth = [useText boundingRectWithSize:CGSizeMake(9999, 21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size.width + 5;
    
    UILabel *useDateLbl = [[UILabel alloc] initWithFrame:CGRectMake(20 + 2, 38, useWidth, 20)];
    useDateLbl.font = FONT(12);
    useDateLbl.textColor = [UIColor whiteColor];
    useDateLbl.text = useText;
    [self addSubview:useDateLbl];
    
    
    //底部线条
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB(197, 197, 197, 1);
    
    if (clearTag) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(nameWidth + 20, 0, 27 * 17 / 24, 17)];
        img.center = CGPointMake(img.center.x, nameLbl.center.y);
        img.image = [UIImage imageNamed:@"clear_change_warn"];
        [self addSubview:img];
        
        UIButton *clearedBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        clearedBtn.backgroundColor = RGB(36, 217, 185, 1);
        clearedBtn.frame = CGRectMake(0, 58 + 5, 120, 30);
        clearedBtn.center = CGPointMake(self.center.x, clearedBtn.center.y);
        clearedBtn.layer.cornerRadius = 5;
        clearedBtn.clipsToBounds = YES;
        [clearedBtn setTitle:@"已经处理过滤网" forState:UIControlStateNormal];
        [clearedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        clearedBtn.titleLabel.font = FONT(12);
        [clearedBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearedBtn];
        
        line.frame = CGRectMake(20, clearedBtn.frame.origin.y + clearedBtn.frame.size.height + 20, dateRemindPgs.frame.size.width, 1);
    }else{
        line.frame = CGRectMake(20, dateRemindPgs.frame.origin.y + dateRemindPgs.frame.size.height + 20, dateRemindPgs.frame.size.width, 1);
    }
    [self addSubview:line];
    return clearTag;
}
//-(BOOL)customWithCellFilter:(NSInteger)filter andName:(NSString *)name andUseDate:(CGFloat)date{
//    
//    //是否需要清洁或更换
//    BOOL clearTag;
//    
//    //滤网/芯的寿命 提醒时间条件
//    CGFloat time;
//    NSInteger remainDate;
//    switch (filter) {
//        case 0:
//        {
//            time = 30;
//            remainDate = 1;
//        }
//            
//            break;
//        case 1:
//        {
//            time = 90;
//            remainDate = 2;
//        }
//            break;
//        case 2:
//        case 3:
//        {
//            time = 180;
//            remainDate = 3;
//        }
//            break;
//            
//        default:
//            break;
//    }
//    //提醒颜色 -- 剩余天数 进度条
//    UIColor *remindColor = [UIColor greenColor];
//    if (time - date <= remainDate) {
//        remindColor = [UIColor redColor];
//        clearTag = true;
//    }
//    
//    //滤网名
//    UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 120, 23)];
////    UILabel *nameLbl = [[UILabel alloc] init];
//    nameLbl.font = FONT(17);
//    nameLbl.text = name;
//    [self addSubview:nameLbl];
////    [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.offset(9);
////        make.left.offset(20);
////        make.height.offset(23);
////    }];
//    
//    
//    //剩余天数
////    UILabel *remainLbl = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - 120 -20, 0, 120, 35)];
//    UILabel *remainLbl = [[UILabel alloc] init];
//    remainLbl.textAlignment = NSTextAlignmentRight;
//    remainLbl.font = FONT(17);
//    [self addSubview:remainLbl];
//    NSString *text = [NSString stringWithFormat:@"剩余%.f天", time - date];
//    remainLbl.attributedText = [self attributeTextWithColor:remindColor andText:text andRangStr:[NSString stringWithFormat:@"%.f", time - date]];
//    [remainLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(0);
//        make.right.offset(-20);
//        make.height.offset(32);
//    }];
//    
//    //天数进度条
////    UIProgressView *dateRemindPgs = [[UIProgressView alloc] initWithFrame:CGRectMake(20, 35 + 10, self.frame.size.width - 40, 20)]; //Y坐标： + 10，跟下面transform有关
//    UIProgressView *dateRemindPgs = [[UIProgressView alloc] init];
//    //    let transform = CGAffineTransformMakeScale(1.0, 2.0)
////    CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 10.0);
////    dateRemindPgs.transform = transform;
//    dateRemindPgs.trackImage = [self imageForColor:[UIColor grayColor]];
//    dateRemindPgs.progressImage = [self imageForColor:remindColor];
//    dateRemindPgs.progress = date / time;
//    [self addSubview:dateRemindPgs];
//    [dateRemindPgs mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(remainLbl.mas_bottom).offset(5);
//        make.left.offset(20);
//        make.right.offset(-20);
//        make.height.offset(20);
//        make.width.equalTo(self).offset(-40);
//    }];
//    
//    
////    UILabel *useDateLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 120, 21)];
//    UILabel *useDateLbl = [[UILabel alloc] init];
//    useDateLbl.font = FONT(12);
//    useDateLbl.textColor = [UIColor whiteColor];
//    useDateLbl.text = [NSString stringWithFormat:@"已使用%.f天", date];
////    [self addSubview:useDateLbl];
////    [useDateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.equalTo(remainLbl.mas_bottom).offset(5);
////        make.left.offset(20);
////        make.height.offset(21);
////    }];
//
//    [dateRemindPgs addSubview:useDateLbl];
//    [useDateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(0);
//        make.left.offset(5);
//        make.height.offset(20);
//    }];
//    
//    if (clearTag) {
//        UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeSystem];
////        clearBtn.backgroundColor = remindColor;
////        clearBtn.frame = CGRectMake(140, 5, 80, 25);
////        clearBtn.layer.cornerRadius = 5;
////        clearBtn.clipsToBounds = YES;
////        [clearBtn setTitle:@"需要清洁或更换" forState:UIControlStateNormal];
////        [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
////        clearBtn.titleLabel.font = FONT(12);
//        [clearBtn setBackgroundImage:[UIImage imageNamed:@"clear_change_warn"] forState:UIControlStateNormal];
//        clearBtn.tag = 100;
//        [clearBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:clearBtn];
//        [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(nameLbl);
//            make.left.equalTo(nameLbl.mas_right).offset(5);
//            make.size.sizeOffset(CGSizeMake(27 * 17 / 24, 17));
//        }];
//        
//        UIButton *clearedBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//        clearedBtn.backgroundColor = [UIColor greenColor];
////        clearedBtn.frame = CGRectMake(20, 65, SCREENWIDTH - 40, 30);
//        clearedBtn.layer.cornerRadius = 5;
//        clearedBtn.clipsToBounds = YES;
//        [clearedBtn setTitle:@"已经处理过滤网" forState:UIControlStateNormal];
//        [clearedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        clearedBtn.titleLabel.font = FONT(12);
//        clearedBtn.tag = 101;
//        [clearedBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:clearedBtn];
//        [clearedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.offset(0);
//            make.top.equalTo(dateRemindPgs.mas_bottom).offset(5);
//            make.size.sizeOffset(CGSizeMake(120, 30));
//        }];
//    }
//    return clearTag;
//}

//富文本 -- 将字符串及要改变颜色的颜色和子串传入
-(NSMutableAttributedString *)attributeTextWithColor:(UIColor *)color andText:(NSString *)text andRangStr:(NSString *)rgStr{
    
    
    NSMutableString *content = [[NSMutableString alloc] initWithString:text];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    [attr addAttributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName: [UIFont systemFontOfSize:32]} range:[content rangeOfString:rgStr]];
    return attr;
}

-(void)btnClick:(UIButton *)sender{
    self.btnBlock();
}



//func AttributeText(color: UIColor, text: String, rangeStr: String) -> NSMutableAttributedString{
//    let content = NSMutableString.init(string: text)
//    let attr = NSMutableAttributedString.init(string: text)
//    attr.addAttributes([NSForegroundColorAttributeName: color], range: content.rangeOfString(rangeStr))
//    return attr
//}
@end
