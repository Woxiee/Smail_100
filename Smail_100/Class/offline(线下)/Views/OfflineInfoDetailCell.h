//
//  OfflineInfoDetailCell.h
//  Smail_100
//
//  Created by ap on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfflineDetailModel.h"
@interface OfflineInfoDetailCell : UITableViewCell
@property (nonatomic, strong) OfflineDetailModel *model;
@property (nonatomic, copy) void(^didClickInfoCellBlock)(NSInteger index);

@end
