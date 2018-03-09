//
//  GoodsOrderVModel.m
//  MyCityProject
//
//  Created by Faker on 17/5/22.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsOrderVModel.h"

@implementation GoodsOrderVModel
///订单确认
+ (void)getGoodsOrderParam:(id)pararm successBlock:(void(^)(NSArray <GoodsOrderModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/order/caculate_order" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单确认 == %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        NSDictionary *dataDic = [result valueForKey:@"data"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                GoodsOrderModel *model = [GoodsOrderModel yy_modelWithJSON:dataDic];
                model.seller = [NSArray yy_modelArrayWithClass:[Seller class] json:model.seller];
                for (Seller *seller in  model.seller) {
                    seller.products = [NSArray yy_modelArrayWithClass:[Products class] json:seller.products];
                }
                
                [listArray addObject:model];
                sBlcok(listArray,YES);
            }else{
                sBlcok(nil,NO);
            }
        }else{
            sBlcok(nil,NO);
        }
    }];

}

///集采订单确认
+ (void)getGoodsCollectOrderParam:(id)pararm successBlock:(void(^)(NSArray <GoodsOrderModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_067" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单确认 == %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"][@"obj"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {
                GoodsOrderModel *model = [GoodsOrderModel mj_objectWithKeyValues:dataDic];
                model.productInfo = [ProductInfo mj_objectWithKeyValues:model.productInfo];
                
                [listArray addObject:model];
                sBlcok(listArray,YES);
            }else{
                sBlcok(nil,NO);
            }
        }else{
            sBlcok(nil,NO);
        }
    }];
}



///检测吊运订单确认
+ (void)getGoodsCheakOrderParam:(id)pararm successBlock:(void(^)(NSArray <GoodsOrderModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_065" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单确认 == %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"][@"obj"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {
                GoodsOrderModel *model = [GoodsOrderModel mj_objectWithKeyValues:dataDic];
                model.productInfo = [ProductInfo mj_objectWithKeyValues:model.productInfo];
                
                [listArray addObject:model];
                sBlcok(listArray,YES);
            }else{
                sBlcok(nil,NO);
            }
        }else{
            sBlcok(nil,NO);
        }
    }];
}


//// 订单价格获取（限定：整机租赁，标准节租赁）
+ (void)getGoodsCheakOrderPriceParam:(id)pararm successBlock:(void(^)(NSString *newPrice,BOOL isSuccess))sBlcok;
{

    [BaseHttpRequest postWithUrl:@"/o/o_076" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单确认 == %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
        
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {
                NSString *str = dataDic[@"obj"];
                sBlcok(str,YES);
            }else{
                sBlcok(nil,NO);
            }
        }else{
            sBlcok(nil,NO);
        }
    }];
}


///订单地址
+ (void)getGoodsOrderAddressParam:(id)pararm successBlock:(void(^)(NSArray <GoodsOrderAddressModel *>*dataArray,NSArray<GoodsOrderAddressModel *>*allDataArr,BOOL isSuccess))sBlcok{
    [BaseHttpRequest postWithUrl:@"/m/m_043" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单地址 == %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSMutableArray *dataList = [[NSMutableArray alloc] initWithCapacity:1];
        NSArray *dataArr = [result valueForKey:@"data"][@"obj"][@"obj"];
        if ([dataArr isKindOfClass:[NSArray class]]) {
            if (state == 0) {
                NSArray *listArray = [GoodsOrderAddressModel mj_objectArrayWithKeyValuesArray:dataArr];
                ///获取默认地址
                for (GoodsOrderAddressModel *model in listArray) {
                    if ([model.isDefault isEqualToString:@"1"]) {
                        [dataList addObject:model];
                    }
                }
                sBlcok(dataList,listArray,YES);
            }else{
                sBlcok(nil,nil,NO);
            }
        }else{
            sBlcok(nil,nil,NO);
        }
    }];
}



///开票信息
+ (void)getGoodsOrderInvocieParam:(id)pararm successBlock:(void(^)(NSArray <InvoiceModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/m/m_049" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"发票列表== %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSArray *dataArr = [result valueForKey:@"data"][@"obj"][@"obj"];
        NSMutableArray *dataList = [[NSMutableArray alloc] initWithCapacity:1];
        if ([dataArr isKindOfClass:[NSArray class]]) {
            if (state == 0) {
                NSArray *listArray = [InvoiceModel mj_objectArrayWithKeyValuesArray:dataArr];
                ///获取默认地址
                for (InvoiceModel *model in listArray) {
                    if ([model.param1 isEqualToString:@"1"]) {
                        [dataList addObject:model];
                    }
                    
                    if ([model.invoiceType isEqualToString:@"1"]) {
                       model.invoiceTypeName = @"增值税普通发票（纸质版）";
                    }
                    
                    else if ([model.invoiceType isEqualToString:@"3"]) {
                       model.invoiceTypeName = @"增值税普通发票（电子版）";
                    }
                    else{
                        model.invoiceTypeName = @"增值税专用发票";

                    }
                }
                sBlcok(dataList,YES);
            }else{
                sBlcok(nil,NO);
            }
        }else{
            sBlcok(nil,NO);
        }
      
    }];

}

///提交订单 订单下单页（限定：新机、配构件、二手设备、整机流转的出租、标准节共享的出租）提交
+ (void)getGoodsOrdeSubmitParam:(id)pararm successBlock:(void(^)(BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_064" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"提交订单== %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        if (state == 0) {
            sBlcok(YES);
        }
        

    }];

}

///提交集采订单
+ (void)getGoodsCollectOrdeSubmitParam:(id)pararm successBlock:(void(^)(BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_068" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"提交订单== %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        if (state == 0) {
            sBlcok(YES);
        }
        
    }];
}




///提交运输调运订单
+ (void)getGoodsCheakOrdeSubmitParam:(id)pararm successBlock:(void(^)(BOOL isSuccess, NSString *msg))sBlcok
{

    [BaseHttpRequest postWithUrl:@"/o/o_066" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"提交订单== %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        NSString *msg = [result valueForKey:@"msg"];
        if (state == 0) {
            sBlcok(YES,msg);
        }else{
            sBlcok(NO,msg);
        }
    }];

}


///拍卖保证金订单确认
+(void)getGoodsAuctionOrderParam:(id)pararm successBlock:(void(^)(NSArray <GoodsOrderModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_069" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单确认 == %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"][@"obj"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {
                GoodsOrderModel *model = [GoodsOrderModel mj_objectWithKeyValues:dataDic];
                model.productInfo = [ProductInfo mj_objectWithKeyValues:model.productInfo];
                
                [listArray addObject:model];
                sBlcok(listArray,YES);
            }else{
                sBlcok(nil,NO);
            }
        }else{
            sBlcok(nil,NO);
        }
    }];


}

///提交拍卖保证金订单
+ (void)getGoodsAuctionOrdeSubmitParam:(id)pararm successBlock:(void(^)(BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_070" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"提交订单== %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        if (state == 0) {
            sBlcok(YES);
        }
    }];
}
@end
