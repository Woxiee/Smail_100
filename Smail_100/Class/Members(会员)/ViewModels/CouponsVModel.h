//
//  CouponsVModel.h
//  MyCityProject
//
//  Created by Macx on 2018/1/30.
//  Copyright © 2018年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CouponsModel.h"
@interface CouponsVModel : NSObject
/// 优惠券列表接口
+ (void)getCouponsListUrl:(NSString *)url  Param:(id)pararm successBlock:(void(^)(NSArray <CouponsModel *>*dataArray,BOOL isSuccess))sBlcok;



/// 申请优惠券
+ (void)getUserCouponsUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(BOOL isSuccess,NSString *message,NSString *obj))sBlcok;


@end
