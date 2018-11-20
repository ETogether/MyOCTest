//
//  UseFilterCoreCell.h
//  Netvox
//
//  Created by netvox-ios1 on 2017/4/28.
//  Copyright © 2017年 netvox-ios6. All rights reserved.
//

#import "BaseController.h"

@interface UseFilterCoreCell : UITableViewCell

//点击按钮的回调
@property (nonatomic, copy)void(^btnBlock)();




-(BOOL)customWithCellFilter:(NSInteger)filter andName:(NSString *)name andUseDate:(CGFloat)date;




@end
