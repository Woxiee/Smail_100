//
//  MemberInfoVModel.m
//  MyCityProject
//
//  Created by Faker on 17/6/13.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "MemberInfoVModel.h"

@implementation MemberInfoVModel
/// 个人信息
+ (void)getMenberInfoUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(NSArray < MemberModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:url andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"个人信息 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {
                MemberModel *model = [MemberModel mj_objectWithKeyValues:dataDic];
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

///保存信息
+(void)getSaveInfoUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:url andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"保存信息 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {

                sBlcok( YES);
            }else{
                sBlcok(YES);
            }
        }
        else{
            sBlcok (YES);
        }
        
    }];
}



///获取企业信息
+(void)getEnterpriseInfoUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(NSArray < MemberModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:url andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        LOG(@"企业信息 == %@",result);
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {
                MemberModel *model = [MemberModel mj_objectWithKeyValues:dataDic];
                model.business = [Business mj_objectWithKeyValues:model.business];
                model.busiImgList = [BusiImgList mj_objectArrayWithKeyValuesArray:model.busiImgList];
                model.cateImgList = [CateImgList mj_objectArrayWithKeyValuesArray:model.cateImgList];
                model.busiCateList = [BusiCateList mj_objectArrayWithKeyValuesArray:model.busiCateList];

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
