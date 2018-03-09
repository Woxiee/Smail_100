//
//  KYChangePhoneVC.m
//  KuaiCloud
//
//  Created by mac_KY on 17/2/21.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "KYChangePhoneVC.h"

#import "KYVercationCode.h"




@interface KYChangePhoneVC ()

@property(nonatomic,strong) KYVercationCode *codeView;

@property(nonatomic,strong)NSString *mobileNetCode;

@property (strong, nonatomic) NSString *imageCodeStr; ///图片验证码
@property (strong, nonatomic)  UIView *imageCodeView;
@property (strong, nonatomic)  UITextField *codeImageTF;
@property (strong, nonatomic)  UIImageView *codeImageView;

@end

@implementation KYChangePhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadComment];
    [self loadSubView];
    
}

#pragma mark - 常数设置
-(void)loadComment
{
    self.title = @"新手机验证码";
}


#pragma mark - 初始化子View
-(void)loadSubView
{
    //18818568431
    [self loadNavItem];
    self.view.backgroundColor = [UIColor whiteColor];
    KYVercationCode *codeView = [[KYVercationCode alloc]initWithFrame:CGRectMake(0, 0, self.view.width   ,100  ) hideClickBtn:NO];
    [self.view addSubview:codeView];
    codeView.headerLb.text =  [NSString stringWithFormat:@"我们将手机号码发送到您的手机 %@",[KX_UserInfo sharedKX_UserInfo].mobel];
    codeView.headerLb.textAlignment = NSTextAlignmentCenter;
    //next
    [codeView.getCodeBtn addTarget:self action:@selector(getCodeFromNet) forControlEvents:UIControlEventTouchUpInside];
    _codeView = codeView;
    __weak typeof(self) b_self = self;
    codeView.clickNextBlock = ^(){
        [b_self clickNext];
    };
    
//     CGRectGetMaxY(codeView.frame)+20
    _imageCodeView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(codeView.frame)+20, SCREEN_WIDTH, 44)];
    [self.view addSubview:_imageCodeView];
    
    _codeImageTF = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 100, 44)];
    _codeImageTF.placeholder = @"请输入图片验证码";
    [_imageCodeView addSubview:_codeImageTF];
    
    _codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_codeImageTF.frame), 0, 100, 44)];
    _codeImageView.image = [UIImage imageNamed:DEFAULTIMAGE];
    
    [_imageCodeView addSubview:_codeImageView];
    
    
    


    UIButton *bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(codeView.frame) + 20, SCREEN_WIDTH-2*12, 45)];
    [self.view addSubview:bottomBtn];
    [bottomBtn setConnerRediu:8];
    [bottomBtn setBackgroundImage: [self createImageWithColor:COLOR(242, 242, 242, 242)] forState:UIControlStateDisabled];
    [bottomBtn setTitle:@"完成" forState:UIControlStateDisabled];
    [bottomBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [bottomBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [bottomBtn setBackgroundImage: [self createImageWithColor: BACKGROUND_COLORHL] forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(clickNext) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self.codeView stopTime];
    
    
}

-(void)loadNavItem
{
    //导航栏设置
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"top-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:88.0/255.0 green:116.0/255.0 blue:216.0/255.0 alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];

}
#pragma mark - 点击事件



///点击下一步
-(void)clickNext
{
    if (_codeView.inputTF.text.length==0) {
        [self .view makeToast:@"请输入验证码"];
        return;
    }
    if (!_aNewMobile) {
         [self .view makeToast:@"系统异常"];
        return;
    }
    
    
 
     if ([self.mobileNetCode isEqualToString:self.codeView.inputTF.text] ) {
     

         
      }else{
            [self .view makeToast:@"验证失败"];
      }
 
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)getCodeFromNet
{
//    if (_aNewMobile.length == 0) {
//        [self .view makeToast:@"系统异常"];
//        return;
//    }
    
//    if ([Common  isValidateMobile:]) {
//        
//    }
    _codeView.getCodeBtn.enabled = NO;
    
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    /*1、注册时获取验证码 2、找回密码时获取验证码 3、修改登录密码时获取验证码 4、修改绑定手机时旧手机获取验证码 */
    [param setObject:@"4" forKey:@"type"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].ID  forKey:@"mid"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    
    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/m/m_003" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (error) {
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }else{
            if ([result[@"data"][@"state"] isEqualToString:@"0"]) {
//                [weakSelf.codeView.getCodeBtn startWithTime:60 title:@"重新获取" countDownTitle:@"(s)重新获取" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
                [weakSelf.codeView timeRun:^(int count) {
                    
                    
                }];
                [weakSelf.view makeToast:result[@"data"][@"msg"]];
                
            }else{
                [weakSelf.view makeToast:result[@"data"][@"msg"]];
            }
        }
    }];

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




#pragma mark - private


@end
