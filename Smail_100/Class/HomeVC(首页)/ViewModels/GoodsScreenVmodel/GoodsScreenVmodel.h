//
//  GoodsScreenVmodel.h
//  MyCityProject
//
//  Created by Faker on 17/5/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsScreenVmodel : NSObject

/// 返回筛选数据
+ (void)getGoodsScreenParam:(NSDictionary *)param WithDataList:(void(^)(NSArray *dataArray, BOOL success))completeBlock;

/// 返回列表数据
+ (void)getGoodsScreenListParam:(NSDictionary *)param WithDataList:(void(^)(NSArray *dataArray, BOOL success))sBlock;

///返回 公共接口数据
+ (void)getProbuilListParam:(NSDictionary *)param WithDataList:(void(^)(NSArray *dataArray, BOOL success))sBlock;
@end
