//
//  DemandVModel.m
//  MyCityProject
//
//  Created by Faker on 17/6/21.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "DemandVModel.h"

@implementation DemandVModel
/// 订单类表接口
+ (void)getOrderListParam:(id)pararm successBlock:(void(^)(NSArray < ManagementModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_077" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单列表 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSArray *dataArr = [result valueForKey:@"data"][@"obj"][@"data"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([dataArr isKindOfClass:[NSArray class]]) {
            if (state == 0) {
                listArray = [ManagementModel mj_objectArrayWithKeyValuesArray:dataArr];
                sBlcok(listArray, YES);
            }else{
                sBlcok(nil, YES);
            }
        }
        else{
            sBlcok(nil, YES);
        }
    }];

}
/// 处理订单
+ (void)getOrderOperationUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:url andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单操作 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        NSInteger code = [[result valueForKey:@"code"]integerValue];
        
        if (code == 000) {
            if (state == 0) {
                sBlcok(YES);
            }
            else{
                sBlcok(NO);
            }
        }else{
            sBlcok(NO);
            
        }
        //        NSString *msg = [result valueForKey:@"msg"];
    }];

}

/// 查看供货单
+(void)getLookSupplyListParam:(id)pararm successBlock:(void(^)(NSArray < SupplyModel *>*dataArray,NSString *isOverdue, BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_100" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"供货单列表 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        if (state == 0) {
            NSArray *dataArr = [result valueForKey:@"data"][@"obj"][@"obj"][@"data"];
            NSMutableArray *listArray  = [[NSMutableArray alloc] init];
            if ([dataArr isKindOfClass:[NSArray class]]) {
                listArray = [SupplyModel mj_objectArrayWithKeyValuesArray:dataArr];
                NSString *isOverdue = [result valueForKey:@"data"][@"obj"][@"obj"][@"isOverdue"];
                sBlcok(listArray,isOverdue, YES);
            }else{
                sBlcok(nil,nil, YES);
            }
        }
            else{
                sBlcok(nil,nil, YES);
            }
    }];
}

/// 查看供货单详情
+(void)getLookSupplyDetailParam:(id)pararm successBlock:(void(^)(NSArray < SupplyModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_101" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"供货单列表 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"][@"obj"][@"goodsMap"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {
                SupplyModel *model = [SupplyModel mj_objectWithKeyValues:dataDic];
                [listArray addObject:model];
                sBlcok(listArray, YES);
            }else{
                sBlcok(nil, YES);
            }
        }
        else{
            sBlcok(nil, YES);
        }
    }];


}

@end
