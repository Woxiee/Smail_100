//
//  OrderCollectCell.h
//  MyCityProject
//
//  Created by Faker on 17/6/7.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderCollectCell : UITableViewCell
@property (nonatomic, strong) OrderModel *model;
@property (nonatomic, copy) void(^DidClickOrderCellBlock)(NSString *title);

@end
