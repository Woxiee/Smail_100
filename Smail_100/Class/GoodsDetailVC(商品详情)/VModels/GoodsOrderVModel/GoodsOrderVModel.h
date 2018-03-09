//
//  GoodsOrderVModel.h
//  MyCityProject
//
//  Created by Faker on 17/5/22.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsOrderModel.h"
#import "GoodsOrderAddressModel.h"
#import "InvoiceModel.h"
@interface GoodsOrderVModel : NSObject
///订单确认
+ (void)getGoodsOrderParam:(id)pararm successBlock:(void(^)(NSArray <GoodsOrderModel *>*dataArray,BOOL isSuccess))sBlcok;

///集采订单确认
+ (void)getGoodsCollectOrderParam:(id)pararm successBlock:(void(^)(NSArray <GoodsOrderModel *>*dataArray,BOOL isSuccess))sBlcok;

///检测吊运订单确认
+ (void)getGoodsCheakOrderParam:(id)pararm successBlock:(void(^)(NSArray <GoodsOrderModel *>*dataArray,BOOL isSuccess))sBlcok;

//// 订单价格获取（限定：整机租赁，标准节租赁）
+ (void)getGoodsCheakOrderPriceParam:(id)pararm successBlock:(void(^)(NSString *newPrice,BOOL isSuccess))sBlcok;

///订单地址
+ (void)getGoodsOrderAddressParam:(id)pararm successBlock:(void(^)(NSArray <GoodsOrderAddressModel *>*dataArray,NSArray<GoodsOrderAddressModel *>*allDataArr,BOOL isSuccess))sBlcok;

///开票信息
+ (void)getGoodsOrderInvocieParam:(id)pararm successBlock:(void(^)(NSArray <InvoiceModel *>*dataArray,BOOL isSuccess))sBlcok;

///提交订单
+ (void)getGoodsOrdeSubmitParam:(id)pararm successBlock:(void(^)(BOOL isSuccess))sBlcok;

///提交集采订单
+ (void)getGoodsCollectOrdeSubmitParam:(id)pararm successBlock:(void(^)(BOOL isSuccess))sBlcok;

///提交运输调运订单
+ (void)getGoodsCheakOrdeSubmitParam:(id)pararm successBlock:(void(^)(BOOL isSuccess, NSString *msg))sBlcok;


///拍卖保证金订单确认
+(void)getGoodsAuctionOrderParam:(id)pararm successBlock:(void(^)(NSArray <GoodsOrderModel *>*dataArray,BOOL isSuccess))sBlcok;
///提交拍卖保证金订单
+ (void)getGoodsAuctionOrdeSubmitParam:(id)pararm successBlock:(void(^)(BOOL isSuccess))sBlcok;
@end
