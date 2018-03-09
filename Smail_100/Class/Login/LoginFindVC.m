//
//  LoginFindVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/17.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "LoginFindVC.h"
#import "LoginFindAndRegirsVC.h"
#import "KYCodeBtn.h"
#import "LoginVModel.h"
@interface LoginFindVC ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;


@property (weak, nonatomic) IBOutlet UITextField *urseTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet KYCodeBtn *yzmBtn;

@property (weak, nonatomic) IBOutlet UITextField *pswTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *oldPswTextFiled;


@property (strong, nonatomic) NSString *codeStr;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIView *view4;

@property (strong, nonatomic) NSString *imageCodeStr; ///图片验证码


@property (weak, nonatomic) IBOutlet UITextField *codeImageTF;

@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;
@property (nonatomic, assign) BOOL loading;

@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@property (weak, nonatomic) IBOutlet UIView *lineView3;
@property (weak, nonatomic) IBOutlet UIView *lineView4;
@end

@implementation LoginFindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfiguration];
//    [self getCodeImageRequest];


}

/// 配置基础设置
- (void)setConfiguration
{
    self.title = @"找回登录密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _lineView1.backgroundColor = LINECOLOR;
    _lineView2.backgroundColor = LINECOLOR;
    _lineView4.backgroundColor = LINECOLOR;
    _lineView3.backgroundColor = LINECOLOR;

    [_loginBtn layerForViewWith:3 AndLineWidth:0.5];

    _codeImageView.userInteractionEnabled = YES;
    _codeImageView.image = [UIImage imageNamed:DEFAULTIMAGE];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCodeImageRequest)];
    [_codeImageView addGestureRecognizer:tapGesture];
    
    
    [_yzmBtn layerWithRadius:3 lineWidth:0.5 color:MainColor];
//    [_loginBtn setTitleColor:MainColor forState:UIControlStateNormal];
    _loginBtn.backgroundColor = MainColor;

}


///获取图片验证码
- (void)getCodeImageRequest
{
    WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/o/o_123" andParameters:nil andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (error) {
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }else{
            
            if ([result[@"data"][@"state"] isEqualToString:@"0"]) {
                weakSelf.imageCodeStr = result[@"data"][@"obj"][@"code"];
                [weakSelf.codeImageView sd_setImageWithURL:[NSURL URLWithString:result[@"data"][@"obj"][@"url"]] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
                
            }else{
                [weakSelf.view makeToast:result[@"data"][@"msg"]];
                [weakSelf getCodeImageRequest];
            }
        }
    }];
    
    
}


- (IBAction)didClickYZMAction:(id)sender {
    [self.view endEditing:YES];
    if ([NSString cheakInputStrIsBlankSpace:_urseTextFiled.text]) {
        [self.view makeToast:@"请输入账号！"];
        return;
    }
    
    if (![Common isValidateMobile:_urseTextFiled.text]) {
        [self.view makeToast:@"请输入正确的手机号！"];
        return;
    }

    [self getYzmRequest];

    /*
    WEAKSELF;
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:_urseTextFiled.text forKey:@"account"];
    [BaseHttpRequest postWithUrl:@"/o/o_125" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if (error) {
        }else{
            NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
            NSString *msg = [result valueForKey:@"data"][@"msg"];
            
            if ([dataDic isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"state"] isEqualToString:@"0"]) {
                    
                    NSString *status = [result valueForKey:@"data"][@"obj"][@"status"];
                    if ([status isEqualToString:@"0"]) {
                        [weakSelf.view  toastShow:@"该账号还未注册~"];
                        return;
                    }else{
                        [weakSelf getYzmRequest];
                    }

                }else{
                    [weakSelf.view  toastShow:msg];

                }
                
            }else{
                [weakSelf.view  toastShow:msg];

            }
        }
    }];

*/


}


- (void)getYzmRequest
{
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    //    [param setObject:@"" forKey:@"mid"];
    //    /*1、注册时获取验证码 2、找回密码时获取验证码 3、修改登录密码时获取验证码 4、修改绑定手机时旧手机获取验证码 */
    //    [param setObject:@"1" forKey:@"type"];
    [param setObject:_urseTextFiled.text  forKey:@"mobile"];
    [param setObject:@""  forKey:@"nationcode"];
    
    
    //    if (_loading) {
    //        _codeImageTF.text = @"";
    //
    //        if (KX_NULLString(_oldAccout)) {
    //            [self getCodeImageRequest];
    //        }
    //    }
    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/sms/getCode" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (error) {
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }else{
            
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                _loading = YES;
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


- (IBAction)registBtn:(id)sender {
    [self.view endEditing:YES];
    if ([NSString cheakInputStrIsBlankSpace:_urseTextFiled.text]) {
        [self.view makeToast:@"请输入手机号！"];
        return;
    }
    
    if (![Common isValidateMobile:_urseTextFiled.text]) {
        [self.view makeToast:@"请输入正确的手机号！"];
        return;
    }
    
//    if (![NSString codeCompareWithTheOne:_codeImageTF.text wihTwo:_imageCodeStr]) {
//        [self.view makeToast:@"图片验证码输入错误!"];
//        return;
//    }
    if ([NSString cheakInputStrIsBlankSpace:_codeTF.text]) {
        [self.view makeToast:@"请输入短信验证码!"];
        return;
    }
    
//    if (![_codeTF.text isEqualToString:_codeStr]) {
//        [self.view makeToast:@"短信验证码输入错误!"];
//        return;
//    }
//    

    if ([NSString cheakInputStrIsBlankSpace:_pswTextFiled.text]) {
        [self.view makeToast:@"请输入新密码！"];
        return;
    }
    
    if ([NSString cheakInputStrIsBlankSpace:_oldPswTextFiled.text]) {
        [self.view makeToast:@"请再次输入确认新密码"];
        return;
    }
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:_urseTextFiled.text forKey:@"mobile"];
    [param setObject:_codeTF.text forKey:@"vcode"];
    [param setObject:_pswTextFiled.text forKey:@"password"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/ucenter/find_login_pwd" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (error) {
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }else{
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                
                //                LoginFindAndRegirsVC *VC = [[LoginFindAndRegirsVC alloc] initWithNibName:@"LoginFindAndRegirsVC" bundle:nil];
                //                [weakSelf.navigationController pushViewController:VC animated:YES];
                [weakSelf.view makeToast:result[@"msg"]];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                
            }else{
                [weakSelf.view makeToast:result[@"msg"]];
            }
        }
    }];
}

@end
