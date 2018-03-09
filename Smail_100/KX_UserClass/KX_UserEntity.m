//
//  KX_UserEntity.m
//  KX_Service
//
//  Created by ac on 16/8/3.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "KX_UserEntity.h"

@implementation KX_UserEntity

static KX_UserEntity *instance;


+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
        
    });
    return instance;
}


+ (instancetype)initUser
{
    return [[self alloc] init];
}


//保存用户信息
+ (void)savaUserInfo
{
    if (instance == nil) {
        instance = [self initUser];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    if ((NSNull *)instance.userId == [NSNull null]) {
        instance.userId = @"";
    }
    [defaults setObject:instance.userId forKey:@"t_UserId"];
    
    if ((NSNull *)instance.userNmae == [NSNull null]) {
        instance.userNmae = @"";
    }
    [defaults setObject:instance.userNmae forKey:@"t_UserName"];
    
}


//清空用户信息
+ (void)userInfoWithLoginOut
{
    if (instance == nil) {
        instance = [self initUser];
    }
    
    instance.userNmae = nil;
    instance.userId = nil;
    instance.userImg = nil;
    instance.userType = UserTypeOther;
    instance.userPwd = nil;
    instance.userPhone = nil;
    [self savaUserInfo];
    
}

+ (void) userInfoWithDictionary:(NSDictionary *)dict
{
    if (instance == nil) {
        instance = [self initUser];
    }
    //    [dict objectForKey:@"t_UserName"]
    instance.userNmae = @"测试";
    instance.userId = @"dddd";
    
    [self savaUserInfo];
    
}


//读取用户信息
+ (KX_UserEntity *)radeUserIfnfo
{
    if (instance == nil) {
        instance = [self initUser];
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    instance.userId = [defaults objectForKey:@"t_UserId"];
    instance.userNmae = [defaults objectForKey:@"t_UserName"];
    
    return instance;
    
}



//更新用户信息
+ (KX_UserEntity *)upDateShareUserInfo
{
    
    if (instance == nil) {
        instance = [self initUser];
    }
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:@"t_UserId"];
    if (userId != nil && ![userId isEqualToString:instance.userId]) {
        instance.userNmae = [defaults objectForKey:@"t_UserName"];
        instance.userNmae = [defaults objectForKey:@"t_UserId"];
        
    }
    return  instance;
}
@end
