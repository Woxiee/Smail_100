//
//  OrderManagementVC.h
//  MyCityProject
//
//  Created by Faker on 17/6/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, OrderType){
    AllOrderType,                   /// 所有
    WaitOrderType,                  ///待审核
    SigningOrderType,              ///待签约
    WaitSendOrderType,              ///待发货
    DidSendOrderType,               /// 已发货
    DidClosedOrderType,               /// 已收货
    RentingOrderType,               /// 在租
    WaitServiceOrderType,           ///待服务
    HasServiceOrderType,             ///已服务
    HasSureOrderType,               ///  已确认
    ComplteOrderType,               ///  已完成
    ComplteAuctionType,             ///  已出价（拍卖)
    DownOrderType,                  ///  已关闭
    JoinOrderType,                  ///  已参与 （拍卖）
    BuyOrderType,                  ///  集采
    AuctionOrderType,              /// 拍卖
    
};


//SupplRoleType  默认为 查看购买商品
typedef NS_ENUM(NSInteger, SupplListRoleType){
    BuySupplListRoleType,                   ///购买
    sellingSupplListRoleType,               ///卖出
};

typedef NS_ENUM(NSInteger, GoodOrderType){
    IsLeaseGoodOrderType,       /// 是否租赁
    IsCollectGoodOrderType,     /// 是否集采
    IsAuctionGoodOrderType,     /// 是否拍卖
    IsDetectionGoodOrderType,   /// 是否检测吊运
};
@interface OrderManagementVC : KX_BaseViewController
@property(nonatomic,copy)void (^leftBtnClick)( );


@property(nonatomic,strong)UIViewController *fatherContoller;
@property (nonatomic, assign) OrderType orderType;
@property (nonatomic, strong) NSString *orderTypeTitle;
@property (nonatomic, assign) SupplListRoleType supplListRoleType;
@property (nonatomic, assign)  BOOL isLease;   /// 是否租赁
@property (nonatomic, assign)  BOOL isCollect;   /// 是否集采
@property (nonatomic, assign)  BOOL isAuction;   /// 是否拍卖
@property (nonatomic, assign)  BOOL isDetection;   /// 是否检测吊运
@property (nonatomic, assign)  GoodOrderType goodOrderType;   /// 订单类型
@property(nonatomic,strong) NSString *quickSearch;  /// 搜索字段

-(void)requestListNetWork;

@end
