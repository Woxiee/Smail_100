//
//  OrderVModel.m
//  MyCityProject
//
//  Created by Faker on 17/6/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderVModel.h"
#import "OrderDetailModel.h"
@implementation OrderVModel
/// 订单类表接口
+ (void)getOrderListParam:(id)pararm successBlock:(void(^)(NSArray <OrderModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_082" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单列表 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        if (state == 0) {
            //        NSString *msg = [result valueForKey:@"msg"];
            NSArray *dataArr = [result valueForKey:@"data"][@"obj"][@"obj"][@"orderList"];
            NSString   *orderType= [result valueForKey:@"data"][@"obj"][@"orderType"];
            NSString   *bidKey= [result valueForKey:@"data"][@"obj"][@"bidKey"];
            NSMutableArray *listArray  = [[NSMutableArray alloc] init];
            if ([dataArr isKindOfClass:[NSArray class]]) {
                if (state == 0) {
                    listArray = [OrderModel mj_objectArrayWithKeyValuesArray:dataArr];
                    for (OrderModel *model in listArray) {
                        model.orderType = orderType;
                        model.bidKey = [bidKey intValue];
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
+ (void)getOrderDetailParam:(id)pararm successBlock:(void(^)(NSArray <OrderDetailModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_086" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单详情 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        NSInteger code = [[result valueForKey:@"code"]integerValue];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];

        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"][@"obj"];
//        NSArray *dataArr = [result valueForKey:@"data"][@"obj"][@"obj"][@"payRecordList"];

        if (code == 000) {
            if (state == 0) {
                if ([dataDic isKindOfClass:[NSDictionary class]]) {
                    OrderDetailModel *model = [OrderDetailModel mj_objectWithKeyValues:dataDic];
                    model.invoice = [Invoice mj_objectWithKeyValues:model.invoice];

                    model.payRecordList = [PayRecordList mj_objectArrayWithKeyValuesArray: model.payRecordList];
                    model.payDetailList = [PayDetailList mj_objectArrayWithKeyValuesArray:model.payDetailList];

                    if ([model.invoiceType integerValue]  == 0) {
                        model.invoiceValue = @"不开发票";
                    }
                    else if ([model.invoiceType integerValue]  == 1)
                    {
                        model.invoiceValue = @"增值税普通发票(纸质版)";
                    }
                    else if ([model.invoiceType integerValue]  == 2)
                    {
                        model.invoiceValue = @"增值税专用发票";
                    }
                    else if ([model.invoiceType integerValue]  == 3)
                    {
                        model.invoiceValue = @"增值税普通发票(电子版)";
                    }
                    
                    if ([model.order.payMentType integerValue]  == 1) {
                        model.payValue = @"直接付款";
                    }

                    else if ([model.order.payMentType integerValue]  == 2)
                    {
                        model.payValue = @"分期付款";
                    }
                    else if ([model.order.payMentType integerValue]  == 3)
                    {
                        model.payValue = @"先用后付";
                    }
                    
                    else if ([model.order.payMentType integerValue]  == 4)
                    {
                        model.payValue = @"融资租赁";
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
        }else{
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
