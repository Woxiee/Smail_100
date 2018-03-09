//
//  KYOlderPhoneVC.m
//  KuaiCloud
//
//  Created by mac_KY on 17/2/21.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "KYOlderPhoneVC.h"
#import "KYFillVerficationCodeVC.h"
#import "KYOlderPhoneVC.h"
#import "KYVercationCode.h"

@interface KYOlderPhoneVC ()
@property(nonatomic,assign)BOOL iscoorect;
@property(nonatomic,strong)NSString *mobileNetCode;
@property (nonatomic, weak)  KYVercationCode *codeView;

@property (strong, nonatomic) NSString *imageCodeStr; ///图片验证码
@property (strong, nonatomic)  UIView *imageCodeView;
@property (strong, nonatomic)  UITextField *codeImageTF;
@property (strong, nonatomic)  UIImageView *codeImageView;
@property (nonatomic, assign) BOOL isLoading;
@end
@implementation KYOlderPhoneVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadComment];
    [self loadSubView];
    self.title = @"原手机验证";
    [self getCodeImageRequest];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];

}
#pragma mark - 常数设置
-(void)loadComment
{
    self.iscoorect = NO;
}



#pragma mark - 初始化子View
-(void)loadSubView
{
    
    self.view.backgroundColor = BACKGROUNDNOMAL_COLOR;

    //header
    UILabel *headerLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [self.view addSubview:headerLb];
    headerLb.textColor =  DETAILTEXTCOLOR1;
    headerLb.backgroundColor = [UIColor clearColor];
    headerLb.font = [UIFont systemFontOfSize:12];
    headerLb.textAlignment = NSTextAlignmentCenter;
    headerLb.textAlignment = NSTextAlignmentCenter;
    headerLb.text =  [NSString stringWithFormat:@"我们将验证码发送到您的手机 %@",  [KX_UserInfo sharedKX_UserInfo].mobel];
    
    _imageCodeView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerLb.frame), SCREEN_WIDTH, 44)];
    _imageCodeView.backgroundColor = [UIColor whiteColor];
    [_imageCodeView layerForViewWith:0 AndLineWidth:0.5];
    [self.view addSubview:_imageCodeView];
    
    _codeImageTF = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 100, 44)];
    _codeImageTF.font = Font15;
    _codeImageTF.placeholder = @"请输入图片验证码";
    [_imageCodeView addSubview:_codeImageTF];
    
    _codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_codeImageTF.frame) - 12, 0, 100, 44)];
    _codeImageView.image = [UIImage imageNamed:DEFAULTIMAGE];
    _codeImageView.userInteractionEnabled = YES;
    _codeImageView.image = [UIImage imageNamed:DEFAULTIMAGE];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCodeImageRequest)];
    [_codeImageView addGestureRecognizer:tapGesture];
    [_imageCodeView addSubview:_codeImageView];
    
    UILabel *alerLB = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageCodeView.frame), SCREEN_WIDTH-12, 20)];
    alerLB.text = @"点击验证码可刷新";
    alerLB.font = Font12;
    alerLB.textColor = DETAILTEXTCOLOR1;
    alerLB.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:alerLB];

    KYVercationCode *codeView = [[KYVercationCode alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_imageCodeView.frame)+20 , self.view.width, 44) hideClickBtn:NO];
    [self.view addSubview:codeView];
    _codeView = codeView;
    _iscoorect = NO;
    
    //next
    [codeView.getCodeBtn addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    
    __weak typeof(self) b_self = self;
    codeView.correctBlock = ^(BOOL correct){
        b_self.iscoorect = correct;
        if (correct) {
 
        }else{
            [b_self.view makeToast:@"验证码输入有误"];
        }
    };
    codeView.clickNextBlock = ^(){
        [b_self clickNext];
    };
    
   
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


#pragma mark - 从网络的到手机验证码
-(void)getCodeFromNet
{
   
    [self.view endEditing:YES];
    if (KX_NULLString(_codeImageTF.text)) {
        [self.view makeToast:@"请输入图片验证码!"];
        return;
    }
    
    if (![NSString codeCompareWithTheOne:_codeImageTF.text wihTwo:_imageCodeStr]) {
        [self.view makeToast:@"图片验证码输入错误!"];
        return;
    }
    
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
                _isLoading = YES;
                [weakSelf.codeView timeRun:^(int count) {
//                    [weakSelf getCodeImageRequest];
                }];
                _mobileNetCode = result[@"data"][@"obj"][@"messageCode"];

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
    [self.view endEditing:YES];

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



#pragma mark - 点击事件

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

///点击下一步
-(void)clickNext
{
    [self.view endEditing:YES];
    if (KX_NULLString(_codeImageTF.text)) {
        [self.view makeToast:@"请输入图片验证码~"];
        return;
    }
    
    if (![NSString codeCompareWithTheOne:_codeImageTF.text wihTwo:_imageCodeStr]) {
        [self.view makeToast:@"图片验证码输入错误~"];
        return;
    }
    
    if ([NSString cheakInputStrIsBlankSpace:_codeView.inputTF.text] ) {
        [self.view toastShow:@"还未输入验证码~"];
        return;
    }
    if (_codeView.inputTF.text.integerValue != _mobileNetCode.integerValue) {
        [self.view makeToast:@"验证码输入错误~"];
        return;
    }
    

        KYFillVerficationCodeVC *VC = [[KYFillVerficationCodeVC alloc]init]; 
        VC.imageCode = _imageCode;
        [self.navigationController pushViewController:VC animated:YES];
 
        
 
 
}
/**得到手机验证码*/
-(void)getCode:(UIButton *)sender
{
    if (_isLoading) {
        _codeImageTF.text = @"";
      
        [self getCodeImageRequest];
    }
    [self getCodeFromNet];
 
}

#pragma mark - private




@end
