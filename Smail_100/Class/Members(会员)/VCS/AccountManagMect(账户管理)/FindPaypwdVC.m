//
//  FindPaypwdVC.m
//  Smail_100
//
//  Created by ap on 2018/4/4.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "FindPaypwdVC.h"
#import "KYCodeBtn.h"

@interface FindPaypwdVC ()

@property (weak, nonatomic) IBOutlet UITextField *accoutTF;

@property (weak, nonatomic) IBOutlet KYCodeBtn *yzmBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *oldPswTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *pswTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation FindPaypwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_loginBtn layerForViewWith:4 AndLineWidth:0.5];
    _loginBtn.backgroundColor = KMAINCOLOR;
//  [_yzmBtn layerWithRadius:6 lineWidth:0.5 color:MainColor];
    [_yzmBtn setTitleColor:KMAINCOLOR forState:UIControlStateNormal];
    _accoutTF.text = [KX_UserInfo sharedKX_UserInfo].mobile;
    self.title = @"找回支付密码";
}


/// 获取短信验证码
- (void)getYzmCodeRequet
{
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    //    [param setObject:@"" forKey:@"mid"];
    //    /*1、注册时获取验证码 2、找回密码时获取验证码 3、修改登录密码时获取验证码 4、修改绑定手机时旧手机获取验证码 */
    //    [param setObject:@"1" forKey:@"type"];
    [param setObject:_accoutTF.text  forKey:@"mobile"];
    [param setObject:@""  forKey:@"nationcode"];

    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/sms/getCode" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (error) {
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }else{
            
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
//                _loading = YES;
//                _oldAccout = _urseTextFiled.text;
                [weakSelf.yzmBtn timeRun:^(int count) {
                    //                    [weakSelf getCodeImageRequest];
                }];
                [weakSelf.view makeToast:result[@"msg"]];
                //                weakSelf.codeStr = [NSString stringWithFormat:@"%@",result[@"data"][@"obj"][@"messageCode"]];
                
            }else{
                [weakSelf.view makeToast:result[@"msg"]];
            }
        }
    }];
    
}


- (IBAction)didMissActionBtn:(id)sender {
    [self.view endEditing:YES];
    if (KX_NULLString(_codeTF.text)) {
        [self.view makeToast:@"请输入验证码"];
        return;

    }

    
    if ([NSString cheakInputStrIsBlankSpace:_oldPswTextFiled.text] || _oldPswTextFiled.text.length !=6) {
        [self.view makeToast:_oldPswTextFiled.placeholder];
        return;
    }
    
    if (KX_NULLString(_pswTextFiled.text)) {
        [self.view makeToast:_pswTextFiled.placeholder];
        return;
        
    }
    
    if (![_pswTextFiled.text isEqualToString:_oldPswTextFiled.text]) {
        [self.view makeToast:@"确认密码输入不一样，请重新设置"];
        return;
    }
    
    
    [MBProgressHUD showMessag:@"" toView:self.view];
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];

    [param setObject:_oldPswTextFiled.text forKey:@"pay_password"];
    [param setObject:_codeTF.text forKey:@"vcode"];

    
    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/ucenter/change_paypwd" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *msg = result[@"msg"];
        if ([result[@"code"] integerValue] == 0) {
            [[KX_UserInfo sharedKX_UserInfo] loadUserInfoFromSanbox];
            [KX_UserInfo sharedKX_UserInfo].pay_password = _oldPswTextFiled.text;
            [[KX_UserInfo sharedKX_UserInfo] saveUserInfoToSanbox];
            [weakSelf.view makeToast:msg];
            [weakSelf.navigationController popViewControllerAnimated:YES];


        }
        else{
            [weakSelf.view makeToast:msg];
        }
    }];

 
}



- (IBAction)getCodeaAction:(id)sender {
    [self.view endEditing:YES];
    
    [self getYzmCodeRequet];

}

@end
