//
//  KYFillVerficationCodeVC.m
//  KuaiCloud
//
//  Created by mac_KY on 17/2/21.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "KYFillVerficationCodeVC.h"

#import "KYVercationCode.h"

#import "KYChangePhoneVC.h"

#import "ChangeToNewMobile.h"
#import "LoginVModel.h"
@interface KYFillVerficationCodeVC ()


@property(nonatomic,strong)KYVercationCode *pooView;

@property (strong, nonatomic) NSString *imageCodeStr; ///图片验证码

@property (strong, nonatomic)  UIView *imageCodeView;
@property (strong, nonatomic)  UITextField *codeImageTF;
@property (strong, nonatomic)  UIImageView *codeImageView;
@end

@implementation KYFillVerficationCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改手机号";
    [self getCodeImageRequest];
    self.view.backgroundColor = BACKGROUNDNOMAL_COLOR;
    
    //header
    UILabel *headerLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [self.view addSubview:headerLb];
    headerLb.textColor =  DETAILTEXTCOLOR1;
    headerLb.backgroundColor = [UIColor clearColor];
    headerLb.font = [UIFont systemFontOfSize:12];
    headerLb.textAlignment = NSTextAlignmentCenter;
    headerLb.textAlignment = NSTextAlignmentCenter;
    headerLb.text =   @"修改手机号码后，下次登录使用新手机号登录";

    
    KYVercationCode *codeView = [[KYVercationCode alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerLb.frame), SCREEN_WIDTH, 44) hideClickBtn:YES];
   
    codeView.inputTF.placeholder = @"请输入新的手机号码";
    codeView.controlNextBtn = YES;
   [self.view addSubview:codeView];
    self.pooView = codeView;
    
    
    UIButton *bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(codeView.frame) + 20, SCREEN_WIDTH-2*12, 45)];
    [self.view addSubview:bottomBtn];
    [bottomBtn setConnerRediu:8];
    [bottomBtn setBackgroundImage: [self createImageWithColor:COLOR(242, 242, 242, 242)] forState:UIControlStateDisabled];
    [bottomBtn setTitle:@"下一步" forState:UIControlStateDisabled];
    [bottomBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [bottomBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [bottomBtn setBackgroundImage: [self createImageWithColor: BACKGROUND_COLORHL] forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(clickNext) forControlEvents:UIControlEventTouchUpInside];

}

///获取图片验证码
- (void)getCodeImageRequest
{
    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/o/o_123" andParameters:nil andRequesultBlock:^(id result, NSError *error) {
        //        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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

///检测手机号是否被注册过
- (void)cheakUserPhoneRequest
{
    if (![Common isValidateMobile:self.pooView.inputTF.text]) {
        [self.view makeToast:@"请输入正确的手机号！"];
        return;
    }
    WEAKSELF;
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:self.pooView.inputTF.text forKey:@"account"];
    [LoginVModel getUserPhoneIsVailParam:param SBlock:^(BOOL isSuccess, NSString *msg) {
        if (isSuccess) {
            ChangeToNewMobile *changeVC = [[ChangeToNewMobile alloc]init];
            changeVC.oldCode = _oldCode;
            changeVC.mobile = self.pooView.inputTF.text;
            changeVC.md5Str = _md5Str;
            changeVC.imageCode = _imageCode;
            [self.navigationController pushViewController:changeVC animated:YES];
            
        }
        else{
            [weakSelf.view toastShow:msg];
        }
    }];
}


#pragma mark - 点击下一步
-(void)clickNext
{
    [self.view endEditing:YES];
    if (self.pooView.inputTF.text.length ==0) {
         [self.view makeToast:@"请输入新的手机号码~"];
        return;
    }

    if (![Common isValidateMobile:self.pooView.inputTF.text]) {
        [self .view makeToast:@"请输入正确格式的手机号哦~"];
        return;
    }
    
    
    [self cheakUserPhoneRequest];
   
    
}



-(void)back{
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}
@end
