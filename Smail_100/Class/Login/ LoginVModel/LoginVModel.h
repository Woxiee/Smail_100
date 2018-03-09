//
//  LoginVModel.h
//  MyCityProject
//
//  Created by Faker on 17/6/14.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginVModel : NSObject
//// 登录
+ (void)getLoginStateParam:(id)param SBlock:(void(^)( BOOL isSuccess))sBlcok;

/// 获取会员信息
+ (void)getMemberInfoParam:(id)param SBlock:(void(^)(BOOL isSuccess))sBlcok;


///检查账号是否被注册
+(void)getUserPhoneIsVailParam:(id)param SBlock:(void(^)(BOOL isSuccess ,NSString *msg))sBlcok;

///获取地址
+ (void)getUserAddressParam:(id)param SBlock:(void(^)(BOOL isSuccess ,NSArray *listArr))sBlcok;

@end
