//
//  LoginSureForgetVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/18.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "LoginSureForgetVC.h"
#import "LoginFindAndRegirsVC.h"
@interface LoginSureForgetVC ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UITextField *urseTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *urseTextFiled1;

@end

@implementation LoginSureForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
      self.title = @"注册";
    [_view1 layerForViewWith:3 AndLineWidth:0.5];
    [_view2 layerForViewWith:3 AndLineWidth:0.5];

}

- (IBAction)registBtn:(id)sender {
    [self.view endEditing:YES];
    if ([NSString cheakInputStrIsBlankSpace:_urseTextFiled.text]) {
        [self.view makeToast:@"请输入密码！"];
        return;
    }
    if (!KX_NULLString( [NSString isOrNoPasswordStyle:_urseTextFiled.text])) {
        [self.view makeToast: [NSString isOrNoPasswordStyle:_urseTextFiled.text]];
        return;
    }
    
    if ([NSString cheakInputStrIsBlankSpace:_urseTextFiled1.text]) {
        [self.view makeToast:@"请输入确认密码!"];
        return;
    }
    
    if (![_urseTextFiled.text isEqualToString:_urseTextFiled1.text]) {
        [self.view makeToast:@"两次输入密码不一致!"];
        return;
    }
    
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:_userStr forKey:@"account"];
    [param setObject:_urseTextFiled.text forKey:@"password"];
    [param setObject:_urseTextFiled1.text forKey:@"rePassword"];
    [param setObject:_code forKey:@"messageCode"];
  
    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/m/m_001" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if (error) {
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }else{
            if ([result[@"data"][@"state"] isEqualToString:@"0"]) {
                
                LoginFindAndRegirsVC *VC = [[LoginFindAndRegirsVC alloc] initWithNibName:@"LoginFindAndRegirsVC" bundle:nil];
                [weakSelf.navigationController pushViewController:VC animated:YES];
            }else{
                [weakSelf.view makeToast:result[@"data"][@"msg"]];
            }
        }
    }];

}

- (IBAction)gotoLoginBtn:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
