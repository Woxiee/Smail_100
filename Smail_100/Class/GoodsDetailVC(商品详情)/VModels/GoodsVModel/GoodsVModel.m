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
#import "GoodSDetailModel.h"

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




/// 获取商品规格
+ (void)getGoodDetailConfigParm:(id)pararm successBlock:(void(^)(NSArray *dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/goods/goods_config" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"商品规格 == %@",result);
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                NSArray  *listArrs = [NSArray yy_modelArrayWithClass:[SKU class] json:result[@"spec"]];
                for (SKU *model in listArrs ) {
                    model.value = [NSArray yy_modelArrayWithClass:[Value class] json:model.value];
                    [listArray addObject:model];
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
                sBlcok(listArray,YES);
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



