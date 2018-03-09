//
//  LoginVModel.m
//  MyCityProject
//
//  Created by Faker on 17/6/14.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "LoginVModel.h"

@implementation LoginVModel
//// 登录
+ (void)getLoginStateParam:(id)param SBlock:(void(^)( BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/m/m_002" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if (error) {
            
        }else{
            KX_UserInfo *userinfo = [KX_UserInfo sharedKX_UserInfo];
            NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
            if ([dataDic isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"state"] isEqualToString:@"0"]) {
                    userinfo.accout = dataDic[@"account"];
                    userinfo.ID =  dataDic[@"mid"];
                    userinfo.aid = dataDic[@"aid"];
                    userinfo.bid = dataDic[@"bid"];
                    userinfo.uid = dataDic[@"uid"];
                    
                    if ([dataDic[@"mType"] isEqualToString:@"1"]) {
                        /// 会员
                        userinfo.isMembers = YES;
                        userinfo.userName = dataDic[@"mNickname"];
                        
                    }else{
                        userinfo.isMembers = NO;
                        userinfo.userName = dataDic[@"companyName"];
                        
                    }
                    [[KX_UserInfo sharedKX_UserInfo] saveUserInfoToSanbox];
                    
                    sBlcok(YES);
                }else{
                    sBlcok(NO);

                }
                
            }else{
                sBlcok(NO);

            }
        }
    }];

}


/// 获取会员信息
+ (void)getMemberInfoParam:(id)param SBlock:(void(^)(BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/m/m_041" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if (error) {
        }else{
            KX_UserInfo *userinfo = [KX_UserInfo sharedKX_UserInfo];
            NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
            if ([dataDic isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"state"] isEqualToString:@"0"]) {
                    userinfo.deptName = dataDic[@"dept"];
                    userinfo.userJob = dataDic[@"position"];
                    userinfo.loginStatus = YES;
                    userinfo.mobel = dataDic[@"realmobile"];
                    
                    [[KX_UserInfo sharedKX_UserInfo] saveUserInfoToSanbox];
                    
                    sBlcok(YES);

                }else{
                    sBlcok(NO);

                }
                
                
            }else{
                sBlcok(NO);

            }
        }
    }];

}


///检查账号是否被注册
+(void)getUserPhoneIsVailParam:(id)param SBlock:(void(^)(BOOL isSuccess ,NSString *msg))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_125" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if (error) {
        }else{
            NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
           NSString *msg = [result valueForKey:@"data"][@"msg"];

            if ([dataDic isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"state"] isEqualToString:@"0"]) {
                  
                    sBlcok(YES,msg);
                    
                }else{
                    sBlcok(NO,msg);
                    
                }
                
                
            }else{
                sBlcok(NO,msg);
                
            }
        }
    }];

}

///获取地址
+ (void)getUserAddressParam:(id)param SBlock:(void(^)(BOOL isSuccess ,NSArray *listArr))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_124" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if (error) {
        }else{
//            NSString *msg = [result valueForKey:@"data"][@"msg"];
            
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSArray *listArr = [result valueForKey:@"data"][@"obj"][@"obj"];

                if ([result[@"data"][@"state"] isEqualToString:@"0"]) {
                    
                    sBlcok(YES,listArr);
                    
                }else{
                    sBlcok(NO,nil);
                    
                }
                
                
            }else{
                sBlcok(NO,nil);
                
            }
        }
    }];
}

@end
