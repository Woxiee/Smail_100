//
//  LoginForgetVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/17.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "LoginForgetVC.h"
#import "LoginSureForgetVC.h"
//#import "GoodsAuctionXYVC.h"
#import "KYCodeBtn.h"
#import "LoginVModel.h"
@interface LoginForgetVC ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@property (weak, nonatomic) IBOutlet UIView *lineView3;
@property (weak, nonatomic) IBOutlet UIView *lineView4;
@property (weak, nonatomic) IBOutlet UIView *lineView6;
@property (weak, nonatomic) IBOutlet UIView *lineView7;

@property (weak, nonatomic)  IBOutlet UIButton *agreeBtn;

@property (weak, nonatomic) IBOutlet UIButton *xyBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@property (weak, nonatomic) IBOutlet KYCodeBtn *yzmBtn;

@property (weak, nonatomic) IBOutlet UITextField *urseTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UITextField *pswTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *oldPswTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *recommendedTF;


@property (strong, nonatomic) NSString *codeStr;  /// 短信验证码
@property (strong, nonatomic) NSString *imageCodeStr; ///图片验证码


@property (weak, nonatomic) IBOutlet UITextField *codeImageTF;

@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;
@property (nonatomic, assign) BOOL loading;

@property (nonatomic, strong) NSString *oldAccout;


@end

@implementation LoginForgetVC
{

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfiguration];
//    [self getCodeImageRequest];
}

/// 配置基础设置
- (void)setConfiguration
{
    self.title = @"注册账户";
    self.view.backgroundColor = [UIColor whiteColor];
//    [_view1 layerForViewWith:3 AndLineWidth:0.5];
//    [_view2 layerForViewWith:3 AndLineWidth:0.5];
    [_sureBtn layerForViewWith:3 AndLineWidth:0];
    _lineView1.backgroundColor = LINECOLOR;
    _lineView2.backgroundColor = LINECOLOR;
    _lineView4.backgroundColor = LINECOLOR;
    _lineView6.backgroundColor = LINECOLOR;
    _lineView7.backgroundColor = LINECOLOR;
    
    [_xyBtn setTitleColor:KMAINCOLOR forState:UIControlStateNormal];
    
    [_yzmBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [_yzmBtn layerWithRadius:3 lineWidth:0.5 color:MainColor];

    
    [_loginBtn setTitleColor:MainColor forState:UIControlStateNormal];
    
    _sureBtn.backgroundColor = MainColor;
    
    _codeImageView.userInteractionEnabled = YES;
    _codeImageView.image = [UIImage imageNamed:DEFAULTIMAGE];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCodeImageRequest)];
    [_codeImageView addGestureRecognizer:tapGesture];
    
//    self.urseTextFiled.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"denglu2@3x.png"]];
//    self.urseTextFiled.leftViewMode = UITextFieldViewModeAlways;
//
//    self.codeTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"denglu2@3x.png"]];
//    self.codeTF.leftViewMode = UITextFieldViewModeAlways;

}

///检测手机号是否被注册过
- (void)cheakUserPhoneRequest
{
    
//    [self getYzmCodeRequet];
/*
    if (![Common isValidateMobile:_urseTextFiled.text]) {
        [self.view makeToast:@"请输入正确的手机号！"];
        return;
    }
    WEAKSELF;
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:_urseTextFiled.text forKey:@"account"];
    [LoginVModel getUserPhoneIsVailParam:param SBlock:^(BOOL isSuccess, NSString *msg) {
        if (isSuccess) {
            [weakSelf getYzmCodeRequet];
        }
        else{
            [weakSelf.view toastShow:msg];
        }
    }];
 */
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
//                [weakSelf getCodeImageRequest];
            }
        }
    }];
    

}

/// 获取短信验证码
- (void)getYzmCodeRequet
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
                _oldAccout = _urseTextFiled.text;
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


- (IBAction)didClickAgreeBtn:(id)sender {
    _agreeBtn.selected = !_agreeBtn.selected;
}



- (IBAction)didClckXYBtn:(id)sender{
  
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

    if ([NSString cheakInputStrIsBlankSpace:_codeTF.text]) {
        [self.view makeToast:@"请输入短信验证码!"];
        return;
    }

    if ([NSString cheakInputStrIsBlankSpace:_urseTextFiled.text]) {
        [self.view makeToast:@"请输入密码！"];
        return;
    }
    
    if (!KX_NULLString( [NSString isOrNoPasswordStyle:_pswTextFiled.text])) {
        [self.view makeToast: [NSString isOrNoPasswordStyle:_pswTextFiled.text]];
        return;
    }
    
    if ([NSString cheakInputStrIsBlankSpace:_pswTextFiled.text]) {
        [self.view makeToast:@"请输入确认密码!"];
        return;
    }
    
    
    if (![_pswTextFiled.text isEqualToString:_oldPswTextFiled.text]) {
        [self.view makeToast:@"两次输入密码不一致!"];
        return;
    }
    if (_agreeBtn.selected == NO) {
        [self.view makeToast:@"未同意协议!"];
        return;
    }
  
    
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:_urseTextFiled.text forKey:@"mobile"];
    [param setObject:_pswTextFiled.text forKey:@"password"];
//    [param setObject:_oldPswTextFiled.text forKey:@"rePassword"];
    [param setObject:_recommendedTF.text forKey:@"pid"];
    [param setObject:_codeTF.text forKey:@"vcode"];
    
    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/ucenter/register" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if (error) {
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }else{
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {

//                LoginFindAndRegirsVC *VC = [[LoginFindAndRegirsVC alloc] initWithNibName:@"LoginFindAndRegirsVC" bundle:nil];
//                [weakSelf.navigationController pushViewController:VC animated:YES];
                [self.navigationController popToRootViewControllerAnimated:YES];
                [weakSelf.view makeToast:result[@"msg"]];
                
            }else{
                [weakSelf.view makeToast:result[@"msg"]];
            }
        }
    }];


}

- (IBAction)gotoLoginBtn:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
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
    
//    if (KX_NULLString(_codeImageTF.text)) {
//        [self.view makeToast:@"请输入图片验证码!"];
//        return;
//    }
//
//    if (![NSString codeCompareWithTheOne:_codeImageTF.text wihTwo:_imageCodeStr]) {
//        [self.view makeToast:@"图片验证码输入错误!"];
//        return;
//    }
    [self cheakUserPhoneRequest];

}

/// 获取图片验证码
- (IBAction)didClickCodeImageView:(id)sender {
    
    
}

@end
