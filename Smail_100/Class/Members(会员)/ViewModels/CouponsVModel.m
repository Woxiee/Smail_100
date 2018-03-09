//
//  CouponsVModel.m
//  MyCityProject
//
//  Created by Macx on 2018/1/30.
//  Copyright © 2018年 Faker. All rights reserved.
//

#import "CouponsVModel.h"
@implementation CouponsVModel

/// 优惠券列表接口
+ (void)getCouponsListUrl:(NSString *)url  Param:(id)pararm successBlock:(void(^)(NSArray <CouponsModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:url andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"优惠券== %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        if (state == 0) {
            //        NSString *msg = [result valueForKey:@"msg"];
            NSArray *dataArr = [result valueForKey:@"data"][@"list"];
            NSMutableArray *listArray  = [[NSMutableArray alloc] init];
            if ([dataArr isKindOfClass:[NSArray class]]) {
                if (state == 0) {
                    listArray = [CouponsModel mj_objectArrayWithKeyValuesArray:dataArr];
                    
                    sBlcok(listArray, YES);
                }else{
                    sBlcok(nil, NO);
                }
            }
            else{
                sBlcok(nil, NO);
            }
        }
    }];
}

/// 申请优惠券
+ (void)getUserCouponsUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(BOOL isSuccess,NSString *message,NSString *obj))sBlcok
{
    [BaseHttpRequest postWithUrl:url andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"优惠券== %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        if (state == 0) {
//            obj         Obj 返回1 优惠券领取重复
//            Obj 返回 2 优惠券数量不足
//            0  成功
            
            NSString *msg = result[@"data"][@"msg"];
            NSString *obj = result[@"data"][@"obj"][@"obj"];
            
            sBlcok( YES,msg,obj);


        }else{
            sBlcok( NO,@"",@"");

        }
    }];
    
}
@end
