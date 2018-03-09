//
//  OrderCommitSuccessVC.h
//  ShiShi
//
//  Created by mac_KY on 17/3/7.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsOrderModel.h"
typedef NS_ENUM(NSInteger, commitSuccessType) {
    CommitSuccessNomalType,
    CommitSuccessAutiocnType, /// 拍卖成功
    CommitSuccessSupplyType, /// 供货成功
    CommitSuccesscollectType,   //// 集采
};


@interface OrderCommitSuccessVC : KX_BaseViewController
@property (nonatomic, assign) commitSuccessType successType;

@property (nonatomic, strong)  GoodsOrderModel *model;

@end
