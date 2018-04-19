//
//  SetPayPwdVC.m
//  Smail_100
//
//  Created by ap on 2018/4/3.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SetPayPwdVC.h"
#import "FindPaypwdVC.h"

@interface SetPayPwdVC ()
@property (weak, nonatomic) IBOutlet UIView *oldPwdView;
@property (weak, nonatomic) IBOutlet UIView *surePwdView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oldPwdContensH;
@property (weak, nonatomic) IBOutlet UIView *newsPwdView;

@property (weak, nonatomic) IBOutlet UITextField *oldPwdTF;
@property (weak, nonatomic) IBOutlet UITextField *newsPwdTF;
@property (weak, nonatomic) IBOutlet UITextField *surePwdTF;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;


@end

@implementation SetPayPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (KX_NULLString([KX_UserInfo sharedKX_UserInfo].pay_password)) {
        _oldPwdContensH.constant = 0;
        self.title = @"设置支付密码";
    }else{
//        "pay_password" = 130118,
        self.title = @"修改支付密码";
    }

    
    [_sureBtn layerForViewWith:3 AndLineWidth:0.5];
    _sureBtn.backgroundColor = KMAINCOLOR;


}

- (IBAction)didSureAction:(id)sender {
 
    
    if (!KX_NULLString([KX_UserInfo sharedKX_UserInfo].pay_password)) {
        if ([NSString cheakInputStrIsBlankSpace:_newsPwdTF.text]  || _newsPwdTF.text.length !=6 ) {
            [self.view makeToast:_newsPwdTF.placeholder];
            return;
        }
    }
 
 
    
    if ([NSString cheakInputStrIsBlankSpace:_surePwdTF.text] || _surePwdTF.text.length !=6) {
        [self.view makeToast:_surePwdTF.placeholder];
        return;
    }
    
    if (![_newsPwdTF.text isEqualToString:_surePwdTF.text]) {
        [self.view makeToast:@"确认密码输入不一样，请重新设置"];
        return;
    }
    
    
    [MBProgressHUD showMessag:@"" toView:self.view];
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    if (!KX_NULLString([KX_UserInfo sharedKX_UserInfo].pay_password)) {
        [param setObject:_oldPwdTF.text forKey:@"old_paypwd"];

    }
    [param setObject:_newsPwdTF.text forKey:@"pay_password"];

    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/ucenter/change_paypwd" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *msg = result[@"msg"];
        if ([result[@"code"] integerValue] == 0) {
            [weakSelf.view toastShow:msg];
            [weakSelf.navigationController popViewControllerAnimated:YES];

            [[KX_UserInfo sharedKX_UserInfo] loadUserInfoFromSanbox];
            [KX_UserInfo sharedKX_UserInfo].pay_password = _newsPwdTF.text;
            [[KX_UserInfo sharedKX_UserInfo] saveUserInfoToSanbox];

        }
        else{
            [weakSelf.view toastShow:msg];
        }
    }];
}




- (IBAction)didMissActionBtn:(id)sender {
    FindPaypwdVC *VC =[[FindPaypwdVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
