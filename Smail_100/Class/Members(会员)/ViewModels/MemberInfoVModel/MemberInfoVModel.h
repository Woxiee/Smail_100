//
//  MemberInfoVModel.h
//  MyCityProject
//
//  Created by Faker on 17/6/13.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemberModel.h"

@interface MemberInfoVModel : NSObject
/// 个人信息
+ (void)getMenberInfoUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(NSArray < MemberModel *>*dataArray,BOOL isSuccess))sBlcok;

///保存信息
+(void)getSaveInfoUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(BOOL isSuccess))sBlcok;

///获取企业信息
+(void)getEnterpriseInfoUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(NSArray < MemberModel *>*dataArray,BOOL isSuccess))sBlcok;


@end
