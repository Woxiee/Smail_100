//
//  OrderCell.h
//  MyCityProject
//
//  Created by Faker on 17/6/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"
typedef NS_ENUM(NSInteger, OrderCellType){
    AllOrderCellType,                   /// 所有
    WaitOrderCellType,                  ///待审核
    WaitSendOrderCellType,              ///待发货
    DidSendOrderCellType,               /// 已发货
    ComplteOrderCellType,               ///  已完成
    DownOrderCellType,                  ///  已关闭
    BuyOrderCellType,                  ///  集采
    AuctionOrderCellType,              /// 拍卖
    CheckOrderCellType,              /// 检测吊运
};
@interface OrderCell : UITableViewCell
@property (nonatomic, strong) OrderModel *model;


@property (nonatomic, assign) OrderCellType cellType;
@property (nonatomic, copy) void(^DidClickOrderCellBlock)(NSString *title);
@end
