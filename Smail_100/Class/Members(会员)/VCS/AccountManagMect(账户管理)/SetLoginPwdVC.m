//
//  SetLoginPwdVC.m
//  Smail_100
//
//  Created by ap on 2018/4/3.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SetLoginPwdVC.h"
#import "LoginFindVC.h"

@interface SetLoginPwdVC ()
@property (weak, nonatomic) IBOutlet UIView *oldPwdView;
@property (weak, nonatomic) IBOutlet UITextField *oldTF;

@property (weak, nonatomic) IBOutlet UITextField *sureTF;

@property (weak, nonatomic) IBOutlet UITextField *sure2TF;


@property (weak, nonatomic) IBOutlet UIView *surePwdView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oldPwdContensH;
@property (weak, nonatomic) IBOutlet UIView *newsPwdView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *remenberBtn;

@end

@implementation SetLoginPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    _oldPwdContensH.constant = 0;
//    self.view.backgroundColor = [UIColor whiteColor];
    [_remenberBtn setTitleColor:KMAINCOLOR forState:UIControlStateNormal];
    _loginBtn.backgroundColor =  KMAINCOLOR;
    [_loginBtn layerForViewWith:4 AndLineWidth:0];
    
}


- (void)getSureData
{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_oldTF.text forKey:@"old_password"];
    [param setObject:_sure2TF.text forKey:@"password"];
    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/ucenter/change_login_pwd" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if (error) {
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }else{
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {

                [weakSelf.view makeToast:result[@"msg"]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeAfter * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];

                });

                
            }else{
                [weakSelf.view makeToast:result[@"msg"]];
            }
        }
    }];
  
}

- (IBAction)didLogAction:(id)sender {
    [self.view endEditing:YES];
    if (KX_NULLString(_oldTF.text)) {
        [self.view makeToast:_oldTF.placeholder];
        return;
    }
    
    if (KX_NULLString(_sureTF.text)) {
        [self.view makeToast:_sureTF.placeholder];
        return;
    }
    
    if (KX_NULLString(_sure2TF.text)) {
        [self.view makeToast:_sure2TF.placeholder];
        return;
    }
    
    if (![_sureTF.text isEqualToString:_sure2TF.text]) {
        [self.view makeToast:@"两次输入密码不一致!"];
        return;
    }
    [self getSureData];
}

- (IBAction)isAbelAction:(id)sender {
    [self.view endEditing:YES];

    UIButton *btn = (UIButton *)sender;
    btn.selected =! btn.selected;
    
    if (btn.tag == 100) {
        _oldTF.secureTextEntry =  btn.selected ;
    }
    if (btn.tag == 101) {
        _sureTF.secureTextEntry =  btn.selected ;

    }
    if (btn.tag == 102) {
        _sure2TF.secureTextEntry =  btn.selected ;
    }
    
}


- (IBAction)remenAction:(id)sender {
    
    LoginFindVC *VC = [[LoginFindVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}


@end
