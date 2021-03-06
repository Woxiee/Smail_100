//
//  OrderVModel.h
//  MyCityProject
//
//  Created by Faker on 17/6/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"
#import "OrderDetailModel.h"
#import "ItemContentList.h"

#import "GoodsOrderVModel.h"

@interface OrderVModel : NSObject
/// 订单类表接口
+ (void)getOrderListParam:(id)pararm successBlock:(void(^)(NSArray < OrderModel *>*dataArray,BOOL isSuccess))sBlcok;

/// 处理订单
+ (void)getOrderOperationUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(BOOL isSuccess,NSString *message))sBlcok;

/// 获取订单付款操作
+ (void)getOrderPayTypeUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(Pay_method *pay_method,BOOL isSuccess))sBlcok;


///订单详情
+ (void)getOrderDetailParam:(id)pararm successBlock:(void(^)(NSArray < GoodsOrderVModel *>*dataArray,BOOL isSuccess))sBlcok;




/// 金融
+ (void)getFinanListUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(NSArray < OrderModel *>*dataArray,BOOL isSuccess))sBlcok;
/// 保险
+ (void)getInsuceListUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(NSArray < OrderModel *>*dataArray,BOOL isSuccess))sBlcok;

@end
