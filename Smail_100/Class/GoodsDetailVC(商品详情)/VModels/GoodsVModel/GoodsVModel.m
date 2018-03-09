//
//  GoodsVModel.m
//  MyCityProject
//
//  Created by Faker on 17/5/9.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsVModel.h"
#import "GoodsListModel.h"
#import "MemberModel.h"

@implementation GoodsVModel
+ (void)getGoodsDetailParam:(id)pararm successBlock:(void(^)(NSArray <ItemInfoList *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/goods/goodsDetail" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"商品详情 == %@",result);
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                NSArray  *listArrs = [NSArray yy_modelArrayWithClass:[ItemInfoList class] json:result[@"itemInfoList"]];

                for (int i = 0; i<listArrs.count; i++ ) {
                    NSArray *listArr= result[@"itemInfoList"];
//                    NSDictionary *dic = listArr[1];
                    if (i == 1) {
                        ItemInfoList *model = listArrs[i];
                        model.itemContent =  [ItemContentList yy_modelWithJSON:listArr[i][@"itemContentList"]];
                        model.itemContent.pay_method = [Pay_method yy_modelWithJSON:listArr[i][@"itemContentList"][@"pay_method"]];
                    }else{
                        for (ItemInfoList *model in listArrs ) {
                            model.itemContentList = [NSArray yy_modelArrayWithClass:[ItemContentList class] json:model.itemContentList];
                        }
                        
                    }
                  
                }
               
//
                /*
                NSArray *skuArray = [result valueForKey:@"data"][@"obj"][@"SKU"];
            /// 商品默认选择第一个 规格属性
                NSMutableArray *contenArray = [[NSMutableArray alloc] init];
                for (SKU *property in model.sKU) {
                    LOG(@"%@", property.attrValue);
                    contenArray = [AttrValue mj_objectArrayWithKeyValuesArray:property.attrValue];
                    for (int i = 0; i<contenArray.count; i++) {
                        AttrValue *attrModel = contenArray[i];
                        attrModel.attrValueMainID = property.attrId;
                        attrModel.attrValueMainName = property.attrName;
                        if (i == 0) {
                            attrModel.isSelect = YES;
                            if (KX_NULLString(model.goodsSizeID)) {
                                model.goodsSizeID = [NSString stringWithFormat:@"%@:%@",attrModel.attrValueMainID,attrModel.attrValueId];
                            }else{
                                model.goodsSizeID =  [NSString stringWithFormat:@"%@,%@:%@",model.goodsSizeID,attrModel.attrValueMainID,attrModel.attrValueId];
                            }
                        }
                    }
                }
                
                 */
//                [listArray addObject:model];
                sBlcok(listArrs,YES);
            }else{
             sBlcok(nil,NO);
            }
        }else{
              sBlcok(nil,NO);
        }
    }];

}





/// 商品详情价格
+ (void)getGoodsDetailPriceParam:(id)pararm successBlock:(void(^)(NSArray *dataArray,BOOL isSuccess))sBlcok
{
  
    [BaseHttpRequest postWithUrl:@"/o/o_059" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"商品详情价格 == %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {
                GoodSDetailModel *model = [GoodSDetailModel mj_objectWithKeyValues:dataDic];
                
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



/// 商品求租详情
+ (void)getGoodsSolicitDetailParam:(id)pararm successBlock:(void(^)(NSArray *dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_055" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"商品详情 == %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {
                GoodSDetailModel *model = [GoodSDetailModel mj_objectWithKeyValues:dataDic];
                NSString *alertStr = @"";
                if ([model.isOwnweahip isEqualToString:@"1"]) {
                    alertStr = @"需要产权证";
                }
                if ([model.isOwnweahip isEqualToString:@"1"]) {
                    alertStr = @"需要合格证";
                }
                if ([model.isOwnweahip isEqualToString:@"1"] &&  [model.isOwnweahip isEqualToString:@"1"]) {
                    alertStr = @"需要产权证      需要合格证";
                }
                
                NSArray *eattrbuteTitltArray;
                NSArray *eattrbuteDetailArray;
                NSString *spModel = [model.needBuyType isEqualToString:@"3"]? @"机型":@"适配机型";
                model.certificatesStr = alertStr;
                if (KX_NULLString(model.certificatesStr)) {
                    eattrbuteTitltArray = @[@"求租要求",@"商品类别",model.needBuyType ,spModel,@"期望交货时间",@"交货地址",@"备注"];
                    eattrbuteDetailArray = @[@"",model.param3?model.param3:@"",model.kzNumberName?model.kzNumberName:@"",model.hopeSendTime?model.hopeSendTime:@"",[NSString stringWithFormat:@"%@%@%@%@",model.deliveryProv,model.deliveryCity ,model.deliveryArea,model.param5],model.remaek?model.remaek:@""];
                }
                
                else{
                    eattrbuteTitltArray = @[@"证件要求",model.certificatesStr, @"求租要求",@"商品类别",spModel,@"期望交货时间",@"交货地址",@"备注"];
                    eattrbuteDetailArray = @[@"",@"",@"",model.param3?model.param3:@"",model.kzNumberName?model.kzNumberName:@"",model.hopeSendTime?model.hopeSendTime:@"",[NSString stringWithFormat:@"%@%@%@%@",model.deliveryProv,model.deliveryCity ,model.deliveryArea,model.param5],model.remaek?model.remaek:@""];
                }

                if (KX_NULLString(model.kzNumberName)) {
                    eattrbuteTitltArray = @[@"求租要求",@"商品类别",@"期望交货时间",@"交货地址",@"备注"];
                    eattrbuteDetailArray = @[model.certificatesStr,model.certificatesStr,model.param3?model.param3:@"",model.hopeSendTime?model.hopeSendTime:@"",[NSString stringWithFormat:@"%@%@%@%@",model.deliveryProv,model.deliveryCity ,model.deliveryArea,model.param5],model.remaek?model.remaek:@""];
                }
          
                NSMutableArray *extAttArr = [[NSMutableArray alloc] initWithCapacity:10];
                for (int i = 0; i<eattrbuteTitltArray.count; i++) {
                    ExtAttrbuteShow *attrbuteModel = [[ExtAttrbuteShow alloc] init];
                    attrbuteModel.name = eattrbuteTitltArray[i];
                    attrbuteModel.values = eattrbuteDetailArray[i];
                    [extAttArr addObject:attrbuteModel];
                }
                model.extAttrbuteShow =  extAttArr;
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

/// 商品检测吊运
+ (void)getGoodsLiftDetailParam:(id)pararm successBlock:(void(^)(NSArray *dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_056" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"商品详情 == %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {
                GoodSDetailModel *model = [GoodSDetailModel mj_objectWithKeyValues:dataDic];
                NSArray *skuArray = [result valueForKey:@"data"][@"obj"][@"SKU"];
                
                NSDictionary *businessResultArr = [result valueForKey:@"data"][@"obj"][@"BusinessResult"];
                NSDictionary *serviceResultMap = [result valueForKey:@"data"][@"obj"][@"serviceResultMap"];

                model.extAttrbuteShow =  [ExtAttrbuteShow mj_objectArrayWithKeyValuesArray:model.extAttrbuteShow];
                model.sKU =  [SKU mj_objectArrayWithKeyValuesArray:skuArray];
                model.extAttrbute =  [ExtAttrbute mj_objectArrayWithKeyValuesArray:model.extAttrbute];
                model.extetalon =  [Extetalon mj_objectArrayWithKeyValuesArray:model.extetalon];
                model.businessResult = [BusinessResult mj_objectWithKeyValues:businessResultArr];
                model.serviceResultMap = [ServiceResultMap mj_objectWithKeyValues:serviceResultMap];
                model.serviceResultMap.dizhi = [Dizhi mj_objectArrayWithKeyValuesArray:model.serviceResultMap.dizhi];

                /// 商品默认选择第一个 规格属性
                NSMutableArray *contenArray = [[NSMutableArray alloc] init];
                for (SKU *property in model.sKU) {
                    LOG(@"%@", property.attrValue);
                    contenArray = [AttrValue mj_objectArrayWithKeyValuesArray:property.attrValue];
                    for (int i = 0; i<contenArray.count; i++) {
                        AttrValue *attrModel = contenArray[i];
                        attrModel.attrValueMainID = property.attrId;
                        attrModel.attrValueMainName = property.attrName;
                        if (i == 0) {
                            attrModel.isSelect = YES;
                            if (KX_NULLString(model.goodsSizeID)) {
                                model.goodsSizeID = [NSString stringWithFormat:@"%@:%@",attrModel.attrValueMainID,attrModel.attrValueId];
                            }else{
                                model.goodsSizeID =  [NSString stringWithFormat:@"%@,%@:%@",model.goodsSizeID,attrModel.attrValueMainID,attrModel.attrValueId];
                            }
                        }
                    }
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


/// 商品拍卖
+ (void)getGoodsAuctionDetailParam:(id)pararm successBlock:(void(^)(NSArray *dataArray,BOOL isSuccess))sBlcok
{

    [BaseHttpRequest postWithUrl:@"/o/o_057" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"商品详情 == %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {
                GoodSDetailModel *model = [GoodSDetailModel mj_objectWithKeyValues:dataDic];
                NSArray *skuArray = [result valueForKey:@"data"][@"obj"][@"SKU"];
                
                NSDictionary *businessResultArr = [result valueForKey:@"data"][@"obj"][@"BusinessResult"];
                model.extAttrbuteShow =  [ExtAttrbuteShow mj_objectArrayWithKeyValuesArray:model.extAttrbuteShow];
                model.sKU =  [SKU mj_objectArrayWithKeyValuesArray:skuArray];
                model.extAttrbute =  [ExtAttrbute mj_objectArrayWithKeyValuesArray:model.extAttrbute];
                model.extetalon =  [Extetalon mj_objectArrayWithKeyValuesArray:model.extetalon];
                model.businessResult = [BusinessResult mj_objectWithKeyValues:businessResultArr];
                model.serviceResultMap = [ServiceResultMap mj_objectWithKeyValues:model.serviceResultMap];
                model.goodSCount = 1;
//                model.invoiceTitle = @"不开发票";
//                model.invoiceID = @"0";

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

/// 商品采集
+ (void)getGoodscollectDetailParam:(id)pararm successBlock:(void(^)(NSArray *dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_058" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"商品详情 == %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {
                GoodSDetailModel *model = [GoodSDetailModel mj_objectWithKeyValues:dataDic];
                NSArray *skuArray = [result valueForKey:@"data"][@"obj"][@"SKU"];
                
                NSDictionary *businessResultArr = [result valueForKey:@"data"][@"obj"][@"BusinessResult"];
                NSDictionary *groupBuyResult = [result valueForKey:@"data"][@"obj"][@"GroupBuyResult"];

                model.extAttrbuteShow =  [ExtAttrbuteShow mj_objectArrayWithKeyValuesArray:model.extAttrbuteShow];
                model.sKU =  [SKU mj_objectArrayWithKeyValuesArray:skuArray];
                model.extAttrbute =  [ExtAttrbute mj_objectArrayWithKeyValuesArray:model.extAttrbute];
                model.extetalon =  [Extetalon mj_objectArrayWithKeyValuesArray:model.extetalon];
                model.businessResult = [BusinessResult mj_objectWithKeyValues:businessResultArr];
                model.serviceResultMap = [ServiceResultMap mj_objectWithKeyValues:model.serviceResultMap];
                model.groupBuyResult = [GroupBuyResult mj_objectWithKeyValues:groupBuyResult];
                model.groupBuyResult.groupBuyPriceList = [GroupBuyPriceList mj_objectArrayWithKeyValuesArray: model.groupBuyResult.groupBuyPriceList];
                model.mainResult = [MainResult mj_objectWithKeyValues:model.mainResult];
                model.goodSCount = 1;
                NSMutableArray *payArray = [[NSMutableArray alloc] init];
                
                model.invoiceTitle = @"不开发票";
                model.invoiceID = @"0";
                model.noteConten = @"";
                model.leaseStartTime = @"";
                model.leaseEndTime = @"";
                
                NSArray *patmentTypeArr = [model.mainResult.paymentTypeAll componentsSeparatedByString:@","];
                for (NSString *str in patmentTypeArr) {
                    if ([str isEqualToString:@"1"]) {
                        [payArray addObject:@"直接付款"];
                    }
                    
                    if ([str isEqualToString:@"2"]) {
                        [payArray addObject:@"分期付款"];
                    }
                    
                    if ([str isEqualToString:@"3"]) {
                        [payArray addObject:@"先用后付"];
                    }
                    
                    if ([str isEqualToString:@"4"]) {
                        [payArray addObject:@"融资租赁"];
                    }
                    
                }
                
                if (patmentTypeArr.count >0) {
                    /// 订单所用 默认第一个
                    model.payTypeID = patmentTypeArr[0];
                }
                //
                if (payArray.count >0) {
                    model.payTypeTitle = payArray[0];
                }

                [payArray addObject:@"确定"];
                
                model.payArr = (NSArray *)payArray;

//                /// 商品默认选择第一个 规格属性
//                NSMutableArray *contenArray = [[NSMutableArray alloc] init];
//                for (SKU *property in model.sKU) {
//                    LOG(@"%@", property.attrValue);
//                    contenArray = [AttrValue mj_objectArrayWithKeyValuesArray:property.attrValue];
//                    for (int i = 0; i<contenArray.count; i++) {
//                        AttrValue *attrModel = contenArray[i];
//                        attrModel.attrValueMainID = property.attrId;
//                        attrModel.attrValueMainName = property.attrName;
//                        if (i == 0) {
//                            attrModel.isSelect = YES;
//                            if (KX_NULLString(model.goodsSizeID)) {
//                                model.goodsSizeID = [NSString stringWithFormat:@"%@:%@",attrModel.attrValueMainID,attrModel.attrValueId];
//                            }else{
//                                model.goodsSizeID =  [NSString stringWithFormat:@"%@,%@:%@",model.goodsSizeID,attrModel.attrValueMainID,attrModel.attrValueId];
//                            }
//                        }
//                    }
//                }
                
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


/// 相似产品
+ (void)getGoodsSameDetailParam:(id)pararm successBlock:(void(^)(NSArray *dataArray,NSArray *dataArray1,BOOL isSuccess))sBlcok
{
  [BaseHttpRequest postWithUrl:@"/o/o_062" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
      LOG(@"商品详情 == %@",result);

      NSInteger state = [[result valueForKey:@"state"] integerValue];
      //        NSString *msg = [result valueForKey:@"msg"];
      NSMutableArray *dataArr1= [result valueForKey:@"data"][@"obj"][@"obj"][@"dataList"];
      NSMutableArray *dataArr2= [result valueForKey:@"data"][@"obj"][@"obj"][@"dataList1"];
      if ([dataArr1 isKindOfClass:[NSArray class]] || [dataArr2 isKindOfClass:[NSArray class]]) {
          if (state == 0) {
             NSArray *listArr = [GoodsListModel mj_objectArrayWithKeyValuesArray:dataArr1];
              NSArray *listArr1 = [GoodsListModel mj_objectArrayWithKeyValuesArray:dataArr2];

              sBlcok(listArr,listArr1 ,YES);
          }else{
              sBlcok(nil,nil, NO);
          }
      }
      sBlcok(nil,nil, NO);
  
  }];
}
/// 拍卖提醒
+ (void)getGoodsAlertAuctionParam:(id)pararm successBlock:(void(^)(BOOL isSuccess,NSString *message))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_126" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"拍卖提醒 == %@",result);
        
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        NSDictionary *dic = [result valueForKey:@"data"];
        NSString *msg = [dic valueForKey:@"msg"];
        
        if (state == 0) {
            sBlcok(YES,msg);
        }
        else{
            sBlcok(NO,msg);
        }
                
    }];


}

/// 拍卖加价
+ (void)getGoodsChangePriceAuctionParam:(id)pararm successBlock:(void(^)(BOOL isSuccess,NSString *message))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_071" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"拍卖 == %@",result);
        
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        NSDictionary *dic = [result valueForKey:@"data"];
        NSString *msg = [dic valueForKey:@"msg"];

            if (state == 0) {
                if ([dic[@"obj"][@"isPremium"] isEqualToString:@"0"]) {
                    sBlcok(YES,@"加价成功");
                }
            }
            else{
                sBlcok(NO,msg);
            }
      
        sBlcok(NO,msg);
        
    }];

}


///收藏、 取消收藏
+ (void)getGoodCollectParam:(id)pararm successBlock:(void(^)(BOOL isSuccess,NSString *msg))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_109" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"收藏、 取消收藏 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"] integerValue];
        NSString *msg = [result valueForKey:@"data"][@"msg"] ;
//        NSDictionary *dic = [result valueForKey:@"data"];
        if (state == 0) {
//            if ([dic[@"obj"][@"isPremium"] isEqualToString:@"0"]) {
                sBlcok(YES,msg);
//            }
        }
        else{
            sBlcok( NO,msg);
        }
        
    }];

}


/// 获取企业信息
+ (void)getEnterpriseInfoDetailParam:(id)pararm successBlock:(void(^)(NSArray *dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/m/m_048" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"获取企业信息 == %@",result);
        
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dataDic= [result valueForKey:@"data"][@"obj"];
        NSMutableArray *listArr = [[NSMutableArray alloc] init];
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {
//                NSArray *listArr = [GoodsListModel mj_objectArrayWithKeyValuesArray:dataArr1];
                MemberModel *model = [MemberModel mj_objectWithKeyValues:dataDic];
                model.busiCateList = [BusiCateList mj_objectArrayWithKeyValuesArray: model.busiCateList];
                    model.busiImgList = [BusiImgList mj_objectArrayWithKeyValuesArray: model.busiImgList];
                model.cateImgList = [CateImgList mj_objectArrayWithKeyValuesArray: model.cateImgList];

                [listArr addObject:model];
                sBlcok(listArr,YES);
            }else{
                sBlcok(nil, NO);
            }
        }
        sBlcok(nil, NO);
        
    }];

}

@end



