//
//  KX_UserInfo.h
//  KX_Service
//
//  Created by Frank on 16/8/16.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface KX_UserInfo : NSObject
singleton_interface(KX_UserInfo);

@property (nonatomic,copy)NSString *accout;
@property (nonatomic,copy)NSString *pwd;
@property (nonatomic,assign)BOOL loginStatus;
@property (nonatomic,assign)BOOL auditStatus;

@property (nonatomic,copy)NSString *is_first;

@property (nonatomic,copy)NSString *mobel;
@property (nonatomic,copy)NSString *openId;//手机口令
@property (nonatomic,copy)NSString *userName;//名称
@property (nonatomic,copy)NSString *userSex;//性别
@property (nonatomic,copy)NSString *deptName;//部门
@property (nonatomic,copy)NSString *companyShortName;//公司名称
@property (nonatomic,copy)NSString *userQq;//QQ号
@property (nonatomic,copy)NSString *userEmail;//邮箱
@property (nonatomic,copy)NSString *userWechat;//微信号
@property (nonatomic,strong)NSString *imusername;
@property (nonatomic,copy)NSString *did;
@property (nonatomic,copy)NSString *remark; // 备注信息
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *userJob;//职位
@property (nonatomic,copy)NSString *userNickName;//昵称
@property (nonatomic,copy)NSString *headimage;//头像
@property (nonatomic,copy)NSString *userTel; //电话号码
@property (nonatomic,copy)NSString *pName;  //上级明星
@property (nonatomic,copy)NSString *ID; //账号ID
@property (nonatomic,assign)NSString *type;//账号保护开启状态
@property (nonatomic,copy)NSString *isAuthorize;//是否授权
@property (nonatomic,copy)NSString * isOpenNotification;//是否开启通知

@property (nonatomic,copy) NSMutableArray * chatGroupArray;//默认群组

@property (nonatomic,copy) NSString * province;  //省
@property (nonatomic,copy) NSString * city;  //市
@property (nonatomic,copy) NSString * area;  //区
@property (nonatomic,copy) NSString * address;  //详细地址
@property (nonatomic,copy) NSString * url;  //网站
@property (nonatomic,copy) NSString * faxes;  //传真
@property (nonatomic,assign)BOOL isMembers; //// 是否是会员 1: 会员  0供应商
@property (nonatomic,copy) NSString * bid;  //
@property (nonatomic,copy) NSString * aid;  //
@property (nonatomic,copy)NSString *uid;

@property (nonatomic,copy)NSString *companyName;
@property (nonatomic,copy)NSArray *addressList ; //地址数据




/// 微笑
@property (nonatomic , copy) NSString              * paytime;
@property (nonatomic , copy) NSString              * mall_id;
@property (nonatomic , copy) NSString              * money;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * openid;
@property (nonatomic , copy) NSString              * ctime;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * used_point;
@property (nonatomic , copy) NSString              * pid_trees;
@property (nonatomic , copy) NSString              * agent;
@property (nonatomic , copy) NSString              * sex;
@property (nonatomic , copy) NSString              * qrcode;
@property (nonatomic , copy) NSString              * mtime;
@property (nonatomic , copy) NSString              * user_id;
@property (nonatomic , copy) NSString              * realname;
@property (nonatomic , copy) NSString              * avatar_url;
@property (nonatomic , copy) NSString              * point;
@property (nonatomic , copy) NSString              * agent_trees;
@property (nonatomic , copy) NSString              * wxname;
@property (nonatomic , copy) NSString              * department;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * pid;
@property (nonatomic , copy) NSString              * pay_password;
@property (nonatomic , copy) NSString              * password;
@property (nonatomic , copy) NSString              * phone_money;
@property (nonatomic , copy) NSString              * username;



/**
 * 判断是不是第一次
 */
-(void)isFirst;
-(void)loadFirst;
/**
 *从沙盒里获取用户数据
 */
-(void)loadUserInfoFromSanbox;
/**
 *保存用户数据到沙盒
 */
-(void)saveUserInfoToSanbox;

/**
 * 清除沙盒数据
 */
- (void)cleanUserInfoToSanbox;

//登录
+ (void)presentToLoginView:(UIViewController *)ctr;
@end
