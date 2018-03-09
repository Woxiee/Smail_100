//
//  GoodsClassVModel.m
//  MyCityProject
//
//  Created by Faker on 17/6/14.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsClassVModel.h"

@implementation GoodsClassVModel
/// 分类表接口
+ (void)getGoodsClassListParam:(id)pararm successBlock:(void(^)(NSArray < GoodsClassModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"goods_list" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"分类列表 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];

        NSArray *dataArr = dataArr = [result valueForKey:@"data"][@"obj"][@"dataList"];

        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([dataArr isKindOfClass:[NSArray class]]) {
            if (state == 0) {
               NSArray *listArr = [GoodsClassModel mj_objectArrayWithKeyValuesArray:dataArr];
                for (int i = 0; i<listArr.count; i++) {
                    GoodsClassModel *model = listArr[i];
                    model.values = [Values mj_objectArrayWithKeyValuesArray:model.values];
                    if (i == 0) {
                        model.select = YES;
                    }
                    [listArray addObject:model];
                }
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


/// 层级表接口
+ (void)getGoodsLevesListParam:(id)pararm successBlock:(void(^)(NSArray < GoodsClassModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_081" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"分类列表 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSArray *dataArr = [result valueForKey:@"data"][@"obj"][@"obj"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([dataArr isKindOfClass:[NSArray class]]) {
            if (state == 0) {
                if ([dataArr[0] isKindOfClass:[NSArray class]]) {
                    listArray =[Values mj_objectArrayWithKeyValuesArray:dataArr[0]];
                    
                }else{
                    NSMutableArray *arr = [[NSMutableArray alloc] init];
                    GoodsClassModel *model= [GoodsClassModel mj_objectWithKeyValues:dataArr[0]];

                    [arr addObjectsFromArray:model.values];
                    for (NSDictionary *dic in arr) {
                        NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithDictionary:dic];
                        [dic1 setValue:@"0" forKeyPath:@"isSelect"];
                        [listArray addObject:dic1];
                    }
                }
    

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

/// 层级表接口
+ (void)getGoodsLevesOtherListParam:(id)pararm successBlock:(void(^)(NSArray < GoodsClassModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_127" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"分类列表 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSArray *dataArr = [result valueForKey:@"data"][@"obj"][@"obj"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([dataArr isKindOfClass:[NSArray class]]) {
            if (state == 0) {
                if ([dataArr[0] isKindOfClass:[NSArray class]]) {
                    listArray =[Values mj_objectArrayWithKeyValuesArray:dataArr[0]];
                    
                }else{
                    GoodsClassModel *model= [GoodsClassModel mj_objectWithKeyValues:dataArr[0]];
//                    model.values = [Values mj_objectArrayWithKeyValuesArray:model.values];
                    [listArray addObjectsFromArray: model.values];
                }
                
                
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
