//
//  AssetVModel.m
//  MyCityProject
//
//  Created by Faker on 17/6/15.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "AssetVModel.h"

@implementation AssetVModel
/// 资产列表接口
+ (void)getAssetListUrl:(NSString *)url  Param:(id)pararm successBlock:(void(^)(NSArray <AssetModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:url andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"列表 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSArray *dataArr = [result valueForKey:@"data"][@"obj"][@"obj"][@"data"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([dataArr isKindOfClass:[NSArray class]]) {
            if (state == 0) {
                listArray = [AssetModel mj_objectArrayWithKeyValuesArray:dataArr];
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



/// 状态处理
+ (void)getAssetOperationUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:url andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"状态处理 == %@",result);
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

    }];

}

/// 详情
+ (void)getAssetDetailUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(BOOL isSuccess))sBlcok
{

}
@end
