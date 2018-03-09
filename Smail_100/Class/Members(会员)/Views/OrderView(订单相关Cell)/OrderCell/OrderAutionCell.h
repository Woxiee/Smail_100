//
//  OrderAutionCell.h
//  MyCityProject
//
//  Created by Faker on 17/6/7.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
typedef NS_ENUM(NSInteger, AutionCellType){
    AutionCelljoinType,                   /// 已报名
    AutionCellOfferType,                  /// 与出价

};

@interface OrderAutionCell : UITableViewCell
@property (nonatomic, strong) OrderModel *model;
@property (nonatomic, assign) AutionCellType cellType;
@property (nonatomic, copy) void(^DidClickOrderCellBlock)(NSString *title);

@end
