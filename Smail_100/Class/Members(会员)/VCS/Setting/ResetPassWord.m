//
//  ResetPassWord.m
//  ShiShi
//
//  Created by ac on 16/3/18.
//  Copyright © 2016年 fec. All rights reserved.
//

#import "ResetPassWord.h"
#import "SuccessView.h"


@interface ResetPassWord ()

{
    __weak IBOutlet UITextField *currentPassword;
    __weak IBOutlet UITextField *newPassWord;
    __weak IBOutlet UITextField *makeSurePassword;

    BaseHttpRequest * eMessageCode;
}


@property (nonatomic,strong)SuccessView *successView;

@property(nonatomic,strong)NSDictionary *imageDict;
@end



@implementation ResetPassWord
/*懒加载*/
-(SuccessView *)successView
{
    if (!_successView) {
        //初始化数据
        _successView = [[SuccessView alloc]initWithStyle:SuccessStyleBottomWhite title:@"修改登陆密码成功" subTitle: @"返回重新登陆"];
    }
    return _successView;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改登录密码";
    self.view.backgroundColor = BACKGROUNDNOMAL_COLOR;
//    NSRange range = NSMakeRange(3, 4);
//    NSString * teleNun = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] stringByReplacingCharactersInRange:range withString:@"****"];
//    phoneNum.text = [NSString stringWithFormat:@"%@",teleNun];
//   
    self.successView.clickTrue = ^(){
      //去登陆
  
    };
}


- (void)savePassWordRequest
{
    if ([NSString cheakInputStrIsBlankSpace:currentPassword.text] ) {
        [self.view makeToast:@"原始密码未填写~"];
         return;
    }
    if (![currentPassword.text isEqualToString:[KX_UserInfo sharedKX_UserInfo].pwd] ) {
        [self.view makeToast:@"原始密码输入错误~"];
         return;
    }
    
    if ([NSString cheakInputStrIsBlankSpace:newPassWord.text]) {
        [self.view makeToast:@"新密码未填写~"];
        return;
    }
    
    if (!KX_NULLString( [NSString isOrNoPasswordStyle:newPassWord.text])) {
        [self.view makeToast: [NSString isOrNoPasswordStyle:newPassWord.text]];
        return;
    }
    
    if (![NSString codeCompareWithTheOne:newPassWord.text wihTwo:makeSurePassword.text]) {
        [self.view makeToast: @"两次输入的密码不同~"];
        return;
    }
    
    if (
        [NSString cheakInputStrIsBlankSpace:makeSurePassword.text]) {
        [self.view makeToast:@"确认新密码未填写~"];
        return;
    }

    



    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:currentPassword.text forKey:@"yuanPassword"];
    [param setObject:newPassWord.text forKey:@"password"];
    [param setObject:makeSurePassword.text forKey:@"rePassword"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
    
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/m/m_005" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (error) {
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }else{
            if ([result[@"data"][@"state"] isEqualToString:@"0"]) {
                [weakSelf.view makeToast:@"修改密码成功"];

//                [weakSelf.view makeToast:@"修改密码成功，下次登录需要用新密码登录~"];
//                [[KX_UserInfo  sharedKX_UserInfo] loadUserInfoFromSanbox];
//                [KX_UserInfo  sharedKX_UserInfo].pwd  = makeSurePassword.text;
//                [[KX_UserInfo  sharedKX_UserInfo] saveUserInfoToSanbox];
                
                //清除本地数据 返回登陆页面
                [[KX_UserInfo sharedKX_UserInfo] cleanUserInfoToSanbox];
                [KX_UserInfo  presentToLoginView:self];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [weakSelf.view makeToast:result[@"data"][@"msg"]];
            }
        }
    }];

}

#pragma mark - 提交

- (IBAction)upLoadInfor:(UIButton *)sender {
    
    [self.view endEditing:YES];
    [self savePassWordRequest];

}


@end
