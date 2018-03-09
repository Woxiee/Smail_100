//
//  GoodsVModel.h
//  MyCityProject
//
//  Created by Faker on 17/5/9.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodSDetailModel.h"
#import "ItemContentList.h"

@interface GoodsVModel : NSObject
/// 商品详情接口
+ (void)getGoodsDetailParam:(id)pararm successBlock:(void(^)(NSArray <ItemContentList *>*dataArray,BOOL isSuccess))sBlcok;

/// 购物车
+ (void)getAddCartParam:(id)pararm successBlock:(void(^)(NSString *msg,BOOL isSuccess))sBlcok;

/// 商品详情价格
+ (void)getGoodsDetailPriceParam:(id)pararm successBlock:(void(^)(NSArray *dataArray,BOOL isSuccess))sBlcok;


/// 商品求租详情
+ (void)getGoodsSolicitDetailParam:(id)pararm successBlock:(void(^)(NSArray *dataArray,BOOL isSuccess))sBlcok;

/// 商品检测吊运
+ (void)getGoodsLiftDetailParam:(id)pararm successBlock:(void(^)(NSArray *dataArray,BOOL isSuccess))sBlcok;


/// 商品拍卖
+ (void)getGoodsAuctionDetailParam:(id)pararm successBlock:(void(^)(NSArray *dataArray,BOOL isSuccess))sBlcok;

/// 商品采集
+ (void)getGoodscollectDetailParam:(id)pararm successBlock:(void(^)(NSArray *dataArray,BOOL isSuccess))sBlcok;


/// 相似产品
+ (void)getGoodsSameDetailParam:(id)pararm successBlock:(void(^)(NSArray *dataArray,NSArray *dataArray1,BOOL isSuccess))sBlcok;

/// 拍卖加价
+ (void)getGoodsChangePriceAuctionParam:(id)pararm successBlock:(void(^)(BOOL isSuccess,NSString *message))sBlcok;

/// 拍卖提醒
+ (void)getGoodsAlertAuctionParam:(id)pararm successBlock:(void(^)(BOOL isSuccess,NSString *message))sBlcok;

///收藏、 取消收藏
+ (void)getGoodCollectParam:(id)pararm successBlock:(void(^)(BOOL isSuccess,NSString *msg))sBlcok;



/// 获取企业信息
+ (void)getEnterpriseInfoDetailParam:(id)pararm successBlock:(void(^)(NSArray *dataArray,BOOL isSuccess))sBlcok;
@end
