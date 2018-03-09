//
//  HomeVModel.h
//  MyCityProject
//
//  Created by Faker on 17/5/4.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColumnModel.h"
#import "ItemContentList.h"
@interface HomeVModel : NSObject

/// 轮播图
//+ (void)getCycScrollParam:(id)pararm  successBlock:(void(^)(NSArray <ColumnModel *>*dataArray,BOOL isSuccess))sBlcok;
//
///// 标签栏数据
//+ (void)getColumnDataList:(void(^)(NSArray <ColumnModel *>*dataArray))completeBlock;
//
///// 公告数据

+ (void)getHomeNewsParam:(id)pararm  successBlock:(void(^)( ItemInfoList *listModel,BOOL isSuccess))sBlcok;

/// 商品数据
+ (void)getHomGoodsParam:(id)pararm successBlock:(void(^)(NSArray <ItemContentList *>*dataArray,BOOL isSuccess))sBlcok;

/// 保险数据
+ (void)getHomeInsuranceParam:(id)pararm successBlock:(void(^)(NSArray <ColumnModel *>*dataArray1,NSArray <ColumnModel *>*dataArray2,BOOL isSuccess))sBlcok;

///// 首页标题栏数据
+ (void)getHomeIndexList:(void(^)(NSArray *dataArray,BOOL isSuccess))completeBlock;

@end
