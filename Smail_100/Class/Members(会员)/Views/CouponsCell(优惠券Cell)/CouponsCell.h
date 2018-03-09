//
//  CouponsCell.h
//  MyCityProject
//
//  Created by Macx on 2018/1/30.
//  Copyright © 2018年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponsModel.h"

@interface CouponsCell : UITableViewCell
@property (nonatomic, strong) CouponsModel *model;
@property (nonatomic, copy) void(^didClickVolumeBlock)(CouponsModel *model);
@end
