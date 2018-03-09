//
//  KX_UserInfo.m
//  KX_Service
//
//  Created by Frank on 16/8/16.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import "KX_UserInfo.h"
#import "LoginVC.h"


#define LoginStatusKey @"LoginStatus"

#define UserTel        @"userTel"         //电话
#define Mobel          @"mobel"           //手机
#define PwdKey         @"pwd"             //密码

//系统级
#define TouchID        @"touchId"         //开启指纹解锁
#define OpenRememberPwd @"openRemPwd"     //是否开启记住密码
#define OpenId         @"openId"          //登录的时候获取的ID
#define ISFIRST        @"first"           //是否第一次登录
#define OpenPwdLock    @"openPwdLock"     //是否开启密码锁
#define LockType       @"LockType"        //开启那种设备保护 1:指纹 2:密码 3:双开
#define TouchIsRight   @"TouchIsRight"    //touchId是否正确
//用户信息

#define UserName       @"userName"        //名称
#define UserNickName   @"userNickName"    //昵称
#define UserSex        @"userSex"         //性别
#define UserQQ         @"userQq"          //QQ
#define UserEmail      @"userEmail"       //邮箱
#define UserWechat     @"userWechat"      //微信
#define Headimage      @"Headimage"       //头像
#define Remark         @"remark"          //备注信息
#define IMUSERNAME     @"imusername"         //环信ID
#define ADDRESSDIC     @"ADDRESSDIC"         //地址数据


/*
 权限
 isSysManager //超级管理员
 isAnnounceManager",   //公告管理员
 isAnnounceSecondManager",   //二级公告管理员
 */

#define IsSysManager            @"isSysManager"
#define IsAnnounceManager       @"isAnnounceManager"
#define IsAnnounceSecondManager @"isAnnounceSecondManager"
//公司信息
#define CompanyShortName @"companyShortName"//公司名称
#define DeptName       @"deptName"        //部门
#define UserJob        @"userJob"         //职位
#define PName          @"pName"           //上级姓名
#define Uid            @"uid"             //用户id
#define Cid            @"cid"             //公司id
#define Id             @"id"              //账号id
#define Did            @"did"             //部门id

#define chatGroup            @"chatGroup"             //群组arr

//权限问题



//业务
#define IsPushFormDraftBox @"ispushDraftBox" //是否是从草稿箱跳转的
#define IsAuthorize        @"isAuthorize"   //是否被授权了
#define IsPushFromCollect  @"ispushCollect"  //是否从收藏跳转
#define IsOpenNotification @"isopenNotification"//是否开启通知
#define IsPushFormMessage  @"ispushMessage" //是否从消息模块跳转
#define IsHaveTabBar       @"isHavetabbar"  //是否是含有tabbar
/*
@property (nonatomic,copy) NSString * province;  //省
@property (nonatomic,copy) NSString * city;  //市
@property (nonatomic,copy) NSString * area;  //区
@property (nonatomic,copy) NSString * address;  //详细地址
@property (nonatomic,copy) NSString * url;  //网站
@property (nonatomic,copy) NSString * faxes;  //传真
 */

#define Province       @"Province" //省
#define City       @"city" //市
#define Crea       @"area" //区
#define Address       @"address" //详细地址
#define Url       @"url" //网站
#define Faxes       @"faxes"//传真
#define Accout       @"accout"//用户名
#define IsMembers       @"isMembers"// 会员角色
#define Aid       @"aid"//
#define Bid       @"bid"//
#define CompanyName       @"companyName"//#define CompanyName       @"companyName"//
#define AuditStatus       @"auditStatus"// 审核状态 0.未审核  1.审核通过   2.审核不通过





@implementation KX_UserInfo
singleton_implementation(KX_UserInfo)
-(void)setUid:(NSString *)uid
{
    _uid = uid;
    if (![_uid isKindOfClass:[NSString class]]) {
        _uid = [NSString stringWithFormat:@"%@",uid];
    }
    
}
-(void)isFirst{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.is_first forKey:ISFIRST];
    [defaults synchronize];
}
-(void)loadFirst{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.is_first = [defaults objectForKey:ISFIRST];
}



-(void)saveUserInfoToSanbox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.openId forKey:OpenId];
    [defaults setObject:self.userSex forKey:UserSex];
    [defaults setObject:self.companyShortName forKey:CompanyShortName];
    [defaults setObject:self.userQq forKey:UserQQ];
    [defaults setObject:self.userEmail forKey:UserEmail];
    [defaults setObject:self.userWechat forKey:UserWechat];
    [defaults setObject:self.userNickName forKey:UserNickName];
    [defaults setObject:self.headimage forKey:Headimage];
    [defaults setObject:self.userTel forKey:UserTel];
    [defaults setObject:self.pName forKey:PName];
    [defaults setObject:self.remark forKey:Remark];
    [defaults setObject:self.cid forKey:Cid];
    [defaults setObject:self.did forKey:Did];
    [defaults setObject:self.type forKey:LockType];
    [defaults setObject:self.isOpenNotification forKey:IsOpenNotification];
    [defaults setValue:self.isAuthorize forKey:IsAuthorize];

    [defaults setObject:self.chatGroupArray forKey:chatGroup];
    [defaults setObject:self.imusername forKey:IMUSERNAME];
    
    [defaults setObject:self.province forKey:Province];
    [defaults setObject:self.city forKey:City];
    [defaults setObject:self.area forKey:Crea];
    [defaults setObject:self.address forKey:Address];
    [defaults setObject:self.url forKey:Url];
    
    
    [defaults setBool:self.isMembers forKey:IsMembers];
    [defaults setBool:self.auditStatus forKey:AuditStatus];

    [defaults setObject:self.aid forKey:Aid];
    [defaults setObject:self.bid forKey:Bid];
    [defaults setObject:self.uid forKey:Uid];
    [defaults setObject:self.ID forKey:Id];
    [defaults setObject:self.companyName forKey:CompanyName];
    [defaults setObject:self.accout forKey:Accout];
    [defaults setObject:self.mobel forKey:Mobel];
    [defaults setBool:self.loginStatus forKey:LoginStatusKey];
    [defaults setObject:self.pwd forKey:PwdKey];
    [defaults setObject:self.userName forKey:UserName];
    [defaults setObject:self.userJob forKey:UserJob];
    [defaults setObject:self.deptName forKey:DeptName];
    [defaults setObject:self.addressList forKey:ADDRESSDIC];
    
//    [defaults setObject:self.paytime forKey:@"paytime"];
    [defaults setObject:self.mall_id forKey:@"mall_id"];
    [defaults setObject:self.money forKey:@"money"];
    [defaults setObject:self.status forKey:@"status"];
    if (!KX_NULLString(self.openid)&& ![self.openid isKindOfClass:[NSNull class]]) {
        [defaults setObject:self.openid?self.openid:@"" forKey:@"openid"];
    }
    if (!KX_NULLString(self.ctime)&& ![self.ctime isKindOfClass:[NSNull class]]) {
        [defaults setObject:self.ctime?self.ctime:@"" forKey:@"ctime"];
    }
    [defaults setObject:self.nickname forKey:@"nickname"];
    [defaults setObject:self.used_point forKey:@"used_point"];
    if (!KX_NULLString(self.pid_trees) && ![self.pid_trees isKindOfClass:[NSNull class]]) {
        [defaults setObject:self.pid_trees?self.pid_trees:@"" forKey:@"pid_trees"];
    }
    [defaults setObject:self.agent forKey:@"agent"];
    [defaults setObject:self.sex forKey:@"sex"];
    [defaults setObject:self.qrcode forKey:@"qrcode"];
    if (!KX_NULLString(self.mtime) && ![self.mtime isKindOfClass:[NSNull class]]) {
        [defaults setObject:self.mtime?self.mtime:@"" forKey:@"mtime"];
    }
    [defaults setObject:self.user_id forKey:@"user_id"];
    [defaults setObject:self.realname forKey:@"realname"];
    [defaults setObject:self.avatar_url forKey:@"avatar_url"];
    [defaults setObject:self.point forKey:@"point"];
//    [defaults setObject:self.agent_trees forKey:@"agent_trees"];
    [defaults setObject:self.wxname forKey:@"wxname"];
    [defaults setObject:self.department forKey:@"department"];
    [defaults setObject:self.mobile forKey:@"mobile"];
    [defaults setObject:self.pid forKey:@"pid"];
    [defaults setObject:self.pay_password forKey:@"pay_password"];
    [defaults setObject:self.password forKey:@"password"];
    [defaults setObject:self.phone_money forKey:@"phone_money"];
    [defaults setObject:self.username forKey:@"username"];
    [defaults synchronize];
}

-(void)loadUserInfoFromSanbox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.mobel            = [defaults objectForKey:Mobel];
    self.loginStatus      = [defaults boolForKey:LoginStatusKey];
    self.pwd              = [defaults objectForKey:PwdKey];
    self.openId           = [defaults objectForKey:OpenId];
    self.userName         = [defaults objectForKey:UserName];
    self.userSex          = [defaults objectForKey:UserSex];
    self.deptName         = [defaults objectForKey:DeptName];
    self.companyShortName = [defaults objectForKey:CompanyShortName];
    self.userQq           = [defaults objectForKey:UserQQ];
    self.userEmail        = [defaults objectForKey:UserEmail];
    self.userJob          = [defaults objectForKey:UserJob];
    self.userNickName     = [defaults objectForKey:UserNickName];
    self.headimage        = [defaults objectForKey:Headimage];
    self.userTel          = [defaults objectForKey:UserTel];
    self.pName            = [defaults objectForKey:PName];
    self.uid              = [defaults objectForKey:Uid];

    
    self.userWechat       = [defaults objectForKey:UserWechat];

    self.cid              = [defaults objectForKey:Cid];
    self.remark           = [defaults objectForKey:Remark];
    self.ID               = [defaults objectForKey:Id];
    self.did              = [defaults objectForKey:Did];
    self.type             = [defaults objectForKey:LockType];

    self.chatGroupArray   = [defaults objectForKey:chatGroup];
    self.imusername   = [defaults objectForKey:IMUSERNAME];
    
    self.province   = [defaults objectForKey:Province];
    self.city   = [defaults objectForKey:City];
    self.area   = [defaults objectForKey:Crea];
    self.address   = [defaults objectForKey:Address];
    self.url   = [defaults objectForKey:Url];
    self.faxes   = [defaults objectForKey:Faxes];
    self.accout   = [defaults objectForKey:Accout];
    self.isMembers     = [[defaults objectForKey:IsMembers ]boolValue];
    self.aid   = [defaults objectForKey:Aid];
    self.bid   = [defaults objectForKey:Bid];
    self.companyName   = [defaults objectForKey:CompanyName];
    self.addressList = [defaults objectForKey:ADDRESSDIC];
    self.auditStatus   = [[defaults objectForKey:AuditStatus] boolValue];

    self.paytime   = [defaults objectForKey:@"paytime"];
    self.mall_id   = [defaults objectForKey:@"mall_id"];
    self.money   = [defaults objectForKey:@"money"];
    self.status   = [defaults objectForKey:@"status"];
    self.openid   = [defaults objectForKey:@"openid"];
    self.ctime   = [defaults objectForKey:@"ctime"];
    self.openid   = [defaults objectForKey:@"openid"];
    self.nickname   = [defaults objectForKey:@"nickname"];
    self.used_point   = [defaults objectForKey:@"used_point"];
    self.pid_trees   = [defaults objectForKey:@"pid_trees"];
    self.agent   = [defaults objectForKey:@"agent"];
    self.sex   = [defaults objectForKey:@"sex"];
    self.qrcode   = [defaults objectForKey:@"qrcode"];
    
    self.mtime   = [defaults objectForKey:@"mtime"];
    self.user_id   = [defaults objectForKey:@"user_id"];
    self.realname   = [defaults objectForKey:@"realname"];
    self.avatar_url   = [defaults objectForKey:@"avatar_url"];
    self.point   = [defaults objectForKey:@"point"];
    self.agent_trees   = [defaults objectForKey:@"agent_trees"];
    self.wxname   = [defaults objectForKey:@"wxname"];
    self.department   = [defaults objectForKey:@"department"];
    self.mobile   = [defaults objectForKey:@"mobile"];
    self.pid   = [defaults objectForKey:@"pid"];
    self.pay_password   = [defaults objectForKey:@"pay_password"];
    self.password   = [defaults objectForKey:@"password"];
    self.phone_money   = [defaults objectForKey:@"phone_money"];
    self.username   = [defaults objectForKey:@"username"];
}

/**
 * 清除沙盒数据
 */
- (void)cleanUserInfoToSanbox
{
    
    //清除所有数据
    NSString *bundle = [[NSBundle mainBundle] bundleIdentifier];
    [USER_DEFAULT removePersistentDomainForName:bundle];
    
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    
    NSDictionary* dict = [defs dictionaryRepresentation];
    
    for(id key in dict) {
        [defs removeObjectForKey:key];
    }
    
    [defs synchronize];
    
    [[KX_UserInfo sharedKX_UserInfo] loadUserInfoFromSanbox];

}

+ (void)presentToLoginView:(UIViewController *)ctr{
    LoginVC *loginVc = [[LoginVC alloc]init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
    [ctr presentViewController:nav animated:YES completion:nil];
    
}


@end
