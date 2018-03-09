//
//  DemandVModel.h
//  MyCityProject
//
//  Created by Faker on 17/6/21.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagementModel.h"
#import "SupplyModel.h"

@interface DemandVModel : NSObject
/// 订单类表接口
+ (void)getOrderListParam:(id)pararm successBlock:(void(^)(NSArray < ManagementModel *>*dataArray,BOOL isSuccess))sBlcok;

/// 处理订单
+ (void)getOrderOperationUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(BOOL isSuccess))sBlcok;


/// 查看供货单
+(void)getLookSupplyListParam:(id)pararm successBlock:(void(^)(NSArray < SupplyModel *>*dataArray,NSString *isOverdue, BOOL isSuccess))sBlcok;

/// 查看供货单详情
+(void)getLookSupplyDetailParam:(id)pararm successBlock:(void(^)(NSArray < SupplyModel *>*dataArray,BOOL isSuccess))sBlcok;

@end
