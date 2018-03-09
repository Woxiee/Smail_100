//
//  GoodsScreenVmodel.m
//  MyCityProject
//
//  Created by Faker on 17/5/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsScreenVmodel.h"
#import "GoodsScreenmodel.h"
#import "GoodsScreenListModel.h"
@implementation GoodsScreenVmodel

/// 返回筛选数据
+ (void)getGoodsScreenParam:(NSDictionary *)param WithDataList:(void(^)(NSArray *dataArray, BOOL success))completeBlock
{
//    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:@"5",@"mid",_typeStr,@"itemsType", nil];
    [BaseHttpRequest postWithUrl:@"/o/o_052" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if (error) {
            completeBlock(nil, NO);
        }else{
            NSMutableArray *listArray = [[NSMutableArray alloc] init];
            NSInteger state = [[result valueForKey:@"state"] integerValue];
            NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
            if ([dataDic isKindOfClass:[NSDictionary class]]) {
                if (state == 0) {
                    GoodsScreenmodel *model = [GoodsScreenmodel mj_objectWithKeyValues:dataDic];
                    model.itemsTypeDetail = [ItemsTypeDetail mj_objectArrayWithKeyValuesArray: model.itemsTypeDetail];
                    model.payTypeDetail = [ItemsScreenModel mj_objectArrayWithKeyValuesArray: model.payTypeDetail];
                    model.dealTypeDetail = [ItemsScreenModel mj_objectArrayWithKeyValuesArray: model.dealTypeDetail];
                    model.dealTypeDetail2 = [ItemsScreenModel mj_objectArrayWithKeyValuesArray: model.dealTypeDetail2];
                    model.orderTypeDetail = [ItemsScreenModel mj_objectArrayWithKeyValuesArray: model.orderTypeDetail];
                    model.payTypeDetail1 = [ItemsScreenModel mj_objectArrayWithKeyValuesArray: model.payTypeDetail1];
                    model.payTypeDetail2 = [ItemsScreenModel mj_objectArrayWithKeyValuesArray: model.payTypeDetail2];
                    
                    model.titleDic = dataDic;
                    [listArray addObject:model];
                }
                completeBlock(listArray, YES);

            }
        }
    }];

}


/// 返回列表数据
+ (void)getGoodsScreenListParam:(NSDictionary *)param WithDataList:(void(^)(NSArray *dataArray, BOOL success))sBlock
{
    [BaseHttpRequest postWithUrl:@"/o/o_053" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if (error) {
            sBlock(nil, NO);
        }else{
            NSMutableArray *listArray = [[NSMutableArray alloc] init];
            NSInteger state = [[result valueForKey:@"state"] integerValue];
            NSArray *dataList = [result valueForKey:@"data"][@"obj"][@"data"];
            if ([dataList isKindOfClass:[NSArray class]]) {
                if (state == 0) {
                    listArray = [GoodsScreenListModel mj_objectArrayWithKeyValuesArray:dataList];
                }
                sBlock(listArray, YES);
                
            }else{
                sBlock(listArray, NO);

            }
        }
        
        
    }];


}


///返回 公共接口数据
+ (void)getProbuilListParam:(NSDictionary *)param WithDataList:(void(^)(NSArray *dataArray, BOOL success))sBlock
{
    [BaseHttpRequest postWithUrl:@"/o/o_118" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        
        if (error) {
            sBlock(nil, NO);
        }else{
            NSMutableArray *listArray = [[NSMutableArray alloc] init];
            NSInteger state = [[result valueForKey:@"state"] integerValue];
            NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
            if ([dataDic isKindOfClass:[NSDictionary class]]) {
                if (state == 0) {
                  GoodsScreenListModel *model = [GoodsScreenListModel mj_objectWithKeyValues:dataDic];
                    [listArray addObject:model];
                }
                sBlock(listArray, YES);
                
            }else{
                sBlock(listArray, NO);
                
            }
        }
        
        
    }];


}

@end
