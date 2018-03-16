//
//  OrderVModel.m
//  MyCityProject
//
//  Created by Faker on 17/6/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderVModel.h"
#import "OrderDetailModel.h"
#import "GoodsOrderModel.h"

@implementation OrderVModel
/// 订单类表接口
+ (void)getOrderListParam:(id)pararm successBlock:(void(^)(NSArray <OrderModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/order/order_list" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单列表 == %@",result);
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            //        NSString *msg = [result valueForKey:@"msg"];
            NSArray *dataArr = [result valueForKey:@"data"];
  
            NSMutableArray *listArray  = [[NSMutableArray alloc] init];
            if ([dataArr isKindOfClass:[NSArray class]]) {
                if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                    listArray = [OrderModel mj_objectArrayWithKeyValuesArray:dataArr];
                    for (OrderModel *model in listArray) {
                        model.seller = [Seller mj_objectArrayWithKeyValuesArray: model.seller ];
                    }
                    
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


/// 处理订单
+ (void)getOrderOperationUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(BOOL isSuccess,NSString *message))sBlcok
{
    [BaseHttpRequest postWithUrl:url andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单操作 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        NSInteger code = [[result valueForKey:@"code"]integerValue];
        NSString *msg = result[@"data"][@"msg"];
        if (code == 000) {
            if (state == 0) {
            sBlcok(YES,msg);
            }
            else{
                sBlcok(NO,msg);
            }
        }else{
            sBlcok(NO,msg);

        }
        //        NSString *msg = [result valueForKey:@"msg"];
    }];
}

///订单详情
+ (void)getOrderDetailParam:(id)pararm successBlock:(void(^)(NSArray < GoodsOrderVModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/order/order_info" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单详情 == %@",result);
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        NSDictionary *dataDic = [result valueForKey:@"data"];

            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                if ([dataDic isKindOfClass:[NSDictionary class]]) {
                    GoodsOrderModel *model = [GoodsOrderModel yy_modelWithJSON:dataDic];
                    model.seller = [NSArray yy_modelArrayWithClass:[Seller class] json:model.seller];
                    for (Seller *seller in  model.seller) {
                        seller.products = [NSArray yy_modelArrayWithClass:[Products class] json:seller.products];
                    }
                    [listArray addObject:model];
                    sBlcok(listArray,YES);
                }else{
                    sBlcok(nil ,NO);
                }
            }
            else{
                sBlcok(nil ,NO);
            }
        
    }];


}


/// 金融 订单类表接口
+ (void)getFinanListUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(NSArray < OrderModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:url andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单列表 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSArray *dataArr = [result valueForKey:@"data"][@"obj"][@"obj"][@"financeList"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([dataArr isKindOfClass:[NSArray class]]) {
            if (state == 0) {
                
                listArray = [OrderModel mj_objectArrayWithKeyValuesArray:dataArr];
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

///保险 订单类表接口
+ (void)getInsuceListUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(NSArray < OrderModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:url andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单列表 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSArray *dataArr = [result valueForKey:@"data"][@"obj"][@"obj"][@"insuranceList"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([dataArr isKindOfClass:[NSArray class]]) {
            if (state == 0) {
                
                listArray = [OrderModel mj_objectArrayWithKeyValuesArray:dataArr];
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
