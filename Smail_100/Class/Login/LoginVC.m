//
//  LoginVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/17.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "LoginVC.h"
#import "LoginForgetVC.h"
#import "LoginFindVC.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@property (weak, nonatomic) IBOutlet UIButton *remberBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPassWDTextField;


@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfiguration];
}


/// 配置基础设置
- (void)setConfiguration
{
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [_view1 layerForViewWith:3 AndLineWidth:0.5];
    [_view2 layerForViewWith:3 AndLineWidth:0.5];
    [_loginBtn layerForViewWith:3 AndLineWidth:0.5];
    _loginBtn.backgroundColor = KMAINCOLOR;
    [_registBtn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateNormal];
    [_remberBtn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateNormal];
    
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"denglu@3x.png"]];
}


- (IBAction)loginBtnAction:(id)sender {
    [self.view endEditing:YES];

    if ([NSString cheakInputStrIsBlankSpace:_userNameTextField.text]) {
        [self.view makeToast:@"请输入账号！"];
          return;
    }
    
    if ([NSString cheakInputStrIsBlankSpace:_userPassWDTextField.text]) {
        [self.view makeToast:@"请先输入密码!"];
          return;
    }
    
    [MBProgressHUD showMessag:@"登录中..." toView:self.view];
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
//    [param setObject:_userNameTextField.text forKey:@"mobile"];
//    [param setObject:_userPassWDTextField.text forKey:@"password"];
     [param setObject:@"17512033060" forKey:@"mobile"];
    [param setObject:@"e10adc3949ba59abbe56e057f20f883e" forKey:@"password"];

    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/ucenter/login" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (error) {
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }else{

            KX_UserInfo *userinfo = [KX_UserInfo sharedKX_UserInfo];
            NSDictionary *dataDic = [result valueForKey:@"data"];
            if ([dataDic isKindOfClass:[NSDictionary class]]) {
                if (result[@"data"][@"code"] == 0) {
                    userinfo.paytime =  dataDic[@"paytime"];
                    userinfo.mall_id = dataDic[@"mall_id"];
                    userinfo.money = dataDic[@"money"];
                    userinfo.status = dataDic[@"status"];
                    userinfo.openid = dataDic[@"openid"];
                    userinfo.ctime = dataDic[@"ctime"];
                    userinfo.openid = dataDic[@"openid"];
                    userinfo.nickname = dataDic[@"nickname"];
                    userinfo.used_point = dataDic[@"used_point"];
                    userinfo.pid_trees = dataDic[@"pid_trees"];
                    userinfo.agent = dataDic[@"agent"];
                    userinfo.sex = dataDic[@"sex"];
                    userinfo.qrcode = dataDic[@"qrcode"];
                    userinfo.mtime = dataDic[@"mtime"];
                    userinfo.user_id = dataDic[@"user_id"];
                    userinfo.realname = dataDic[@"realname"];
                    userinfo.avatar_url = dataDic[@"avatar_url"];
                    userinfo.point = dataDic[@"point"];
                    userinfo.agent_trees = dataDic[@"agent_trees"];
                    userinfo.wxname = dataDic[@"wxname"];
                    userinfo.department = dataDic[@"department"];
                    userinfo.mobile = dataDic[@"mobile"];
                    userinfo.pid = dataDic[@"pid"];
                    userinfo.pay_password = dataDic[@"pay_password"];
                    userinfo.password = dataDic[@"password"];
                    userinfo.phone_money = dataDic[@"phone_money"];
                    userinfo.username = dataDic[@"username"];

                    if ([dataDic[@"mType"] isEqualToString:@"1"]) {
                        /// 会员
                        userinfo.isMembers = YES;
                        userinfo.userName = dataDic[@"mNickname"];

                    }else{
                        userinfo.isMembers = NO;
                        userinfo.userName = dataDic[@"companyName"];

                    }
//                    [[KX_UserInfo sharedKX_UserInfo] saveUserInfoToSanbox];
                    
//                    [weakSelf getUserInfoRequest];
                    userinfo.loginStatus = YES;
                    userinfo.accout = _userNameTextField.text;
                    userinfo.pwd = _userPassWDTextField.text;
                    [[KX_UserInfo sharedKX_UserInfo] saveUserInfoToSanbox];
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }else{
                    [weakSelf.view makeToast:result[@"data"][@"msg"]];

                }
                
            }else{
                [weakSelf.view makeToast:result[@"msg"]];

            }
        }
    }];
}

/// 获取会员信息
- (void)getUserInfoRequest
{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:_userNameTextField.text forKey:@"account"];
    [param setObject:_userPassWDTextField.text forKey:@"password"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/m/m_041" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if (error) {
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }else{
            KX_UserInfo *userinfo = [KX_UserInfo sharedKX_UserInfo];
            NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
            if ([dataDic isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"state"] isEqualToString:@"0"]) {
                    userinfo.deptName = dataDic[@"dept"];
                    userinfo.userJob = dataDic[@"position"];
                    userinfo.loginStatus = YES;
                    userinfo.accout = _userNameTextField.text;
                    userinfo.pwd = _userPassWDTextField.text;
                    userinfo.mobel = dataDic[@"realmobile"];
                    [[KX_UserInfo sharedKX_UserInfo] saveUserInfoToSanbox];
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                    /// 登录成功之后获取 App 定位
                }else{
                    [weakSelf.view makeToast:result[@"msg"]];

                }
             

            }else{
                [weakSelf.view makeToast:result[@"msg"]];

            }
        }
    }];
}

- (IBAction)registBtnAction:(id)sender {
    LoginForgetVC *vc = [[LoginForgetVC alloc] initWithNibName:@"LoginForgetVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)remberBtnAction:(id)sender {
    LoginFindVC *vc = [[LoginFindVC alloc] initWithNibName:@"LoginFindVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)popVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
