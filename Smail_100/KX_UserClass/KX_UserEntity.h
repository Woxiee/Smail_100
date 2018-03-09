//
//  KX_UserEntity.h
//  KX_Service
//
//  Created by ac on 16/8/3.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, UserType){
    UserTypeConsumer,
    UserTypeDear,
    UserTypeOther,
};

@interface KX_UserEntity : NSObject

@property (nonatomic, assign) UserType userType;            //用户类型
@property (nonatomic, copy) NSString *userId;               // 用户ID
@property (nonatomic, copy) NSString *nikeName;             // 用户昵称
@property (nonatomic, copy) NSString *userNmae;             // 用户姓名
@property (nonatomic, copy) NSString *userPwd;              // 用户密码
@property (nonatomic, copy) NSString *userPhone;            // 用户手机号
@property (nonatomic, copy) NSString *userImg;              //用户头像

//保存用户信息
+ (void)savaUserInfo;

//退出登录清空数据
+ (void)userInfoWithLoginOut;

//传递登录成功返回数据
+ (void) userInfoWithDictionary:(NSDictionary *)dict;


//读取用户信息（用于登录进入APP）
+ (KX_UserEntity *)radeUserIfnfo;

//更新用户信息
+ (KX_UserEntity *)upDateShareUserInfo;
@end

