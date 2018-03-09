//
//  AllOrderManageVC.h
//  MyCityProject
//
//  Created by Faker on 17/6/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, OrderTitleType){
    NewOrderTitleType,                  /// 新机
    AccessoriesOrderTitleType,          ///配件
    WholeOrderTitleType,                ///整机
    SharedOrderTitleType,               ///  整机流转 &  共享
    GoodsOrderTitleType,                ///  二手
    DetectionrderTitleType,             ///  检测
    BuyOrderTitleType,                  ///  集采
    AuctionOrderTitleType,              /// 拍卖
    
};

//SupplRoleType  默认为 查看购买商品
typedef NS_ENUM(NSInteger, SupplRoleType){
    BuySupplRoleType,                   ///购买
    sellingSupplRoleType,               ///卖出
};

@interface AllOrderManageVC : KX_BaseViewController
@property (nonatomic, assign) OrderTitleType orderTitleType;
@property (nonatomic, assign) SupplRoleType supplyRoleType;

//@property (nonatomic, strong) BOOL is
@end
