//
//  OrderFootView.h
//  MyCityProject
//
//  Created by Faker on 17/6/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "OrderDetailModel.h"
#import "AssetModel.h"
#import "ManagementModel.h"
typedef NS_ENUM(NSInteger, ShowType){
    NoamlShowType,                   /// 所有
    BuyShowType,                  ///  集采
    AuctionShowType,              /// 拍卖
    CheckShowType,              /// 检测吊运
};
typedef void(^DidClickOrderItemBlock)(NSString *title);
@interface OrderFootView : UIView
@property (nonatomic, strong) OrderModel *model;
@property (nonatomic, assign) ShowType showType;
@property (nonatomic, strong) OrderDetailModel  *detailModel;
@property (nonatomic, strong) AssetModel  *assetModel;
@property (nonatomic, strong) ManagementModel *managementModel;

@property (nonatomic, copy)  DidClickOrderItemBlock didClickOrderItemBlock;

@end
