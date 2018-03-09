//
//  HistoryVModel.m
//  MyCityProject
//
//  Created by Faker on 17/6/15.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "HistoryVModel.h"

@implementation HistoryVModel
/// 历史记录类表接口
+ (void)getHistoryListParam:(id)pararm successBlock:(void(^)(NSArray <HistoryModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_119" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"历史记录列表 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSArray *dataArr = [result valueForKey:@"data"][@"obj"][@"obj"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([dataArr isKindOfClass:[NSArray class]]) {
            if (state == 0) {
                listArray = [HistoryModel mj_objectArrayWithKeyValuesArray:dataArr];
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
