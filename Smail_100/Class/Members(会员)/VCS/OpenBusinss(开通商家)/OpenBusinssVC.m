//
//  OpenBusinssVC.m
//  Smail_100
//
//  Created by ap on 2018/3/22.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "OpenBusinssVC.h"
#import "FYLCityPickView.h"
#import "SelectBusinssVC.h"
#import "AgentPlatformModel.h"
#import "GoodsAuctionXYVC.h"

@interface OpenBusinssVC ()
@property (nonatomic, strong) AgentPlatformModel *agentmodel;
@end

@implementation OpenBusinssVC
{
    __weak IBOutlet UIScrollView *scrollView;
    
    __weak IBOutlet UITextField *_accoutTF;
    __weak IBOutlet UITextField *_nameTF;
    __weak IBOutlet UITextField *_storeIntoreTf;
    __weak IBOutlet UITextField *_tellTF;
    __weak IBOutlet KYTextView *_mainLineTxet;
    
    __weak IBOutlet UIView *addressView;
    
    __weak IBOutlet UITextField *addressTF;
    
    __weak IBOutlet UITextField *_addreDetailTF;
    
    __weak IBOutlet UIView *timeView;
    __weak IBOutlet UIView *_industryView;
    
    __weak IBOutlet UITextField *_industryTf;
    
    __weak IBOutlet UIButton *_btn1;
    __weak IBOutlet UIButton *_btn2;
    __weak IBOutlet UIButton *_btn3;
    __weak IBOutlet UIButton *_btn4;
    
    __weak IBOutlet UIImageView *_doorImageView;
    
    __weak IBOutlet UIImageView *zzImageView;
    
    __weak IBOutlet UIImageView *XyImageView;
    
    __weak IBOutlet UIImageView *idOnImageView;
    
    __weak IBOutlet UIImageView *idDownImageView;
    
    __weak IBOutlet UIButton *agrreBnt;
    
    __weak IBOutlet UIButton *_xyBtn;
    
    __weak IBOutlet UIButton *didSureBtn;
    
    
    __weak IBOutlet UIButton *starBtn;
    
    __weak IBOutlet UIButton *endBtn;
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];

    
    [self setConfiguration];
    [self getProportionRequest];
    
    UITapGestureRecognizer *tagGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickAddressAction)];
    [addressView addGestureRecognizer:tagGesture1];
    
    UITapGestureRecognizer *tagGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickIndustryAction)];
    [_industryView addGestureRecognizer:tagGesture2];
    
    

    
}


-(void)viewDidLayoutSubviews{
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1050);
}

#pragma mark - request
- (void)getRequestData
{
//    __weak IBOutlet UITextField *_accoutTF;
//    __weak IBOutlet UITextField *_nameTF;
//    __weak IBOutlet UITextField *_storeIntoreTf;
//    __weak IBOutlet UITextField *_tellTF;
//    __weak IBOutlet UITextField *_timeTF;
//
//    __weak IBOutlet UITextView *_mainLineTF;
//
//    __weak IBOutlet UIView *addressView;
//
//    __weak IBOutlet UITextField *addressTF;
//
//    __weak IBOutlet UITextField *_addreDetailTF;
//
//    __weak IBOutlet UIView *_industryView;
//
//    __weak IBOutlet UITextField *_industryTf;
    
   
    
//    http://39.108.4.18:6803/api/shop/interest_config
}


/// 获得比例
- (void)getProportionRequest
{
    WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/shop/interest_config" andParameters:nil andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = result[@"msg"];
        if ([result[@"code"] integerValue] == 0) {
            NSArray *listArr = result[@"data"];
            for (int i = 0; i<listArr.count; i++) {
                NSDictionary *dic = listArr[i];
                if (i == 0) {
                    NSArray *present_poinArr = dic[@"present_point"];
                    NSDictionary *presentDic = present_poinArr[0];
                    [_btn1 setTitle:dic[@"title"] forState:UIControlStateNormal];
                    [_btn2 setTitle:presentDic[@"title"] forState:UIControlStateNormal];

                    weakSelf.agentmodel.title1 = dic[@"title"];
                    weakSelf.agentmodel.value1 = dic[@"value"];
                    
                    weakSelf.agentmodel.title2 = presentDic[@"title"];
                    weakSelf.agentmodel.value2 = presentDic[@"value"];
                }else{
                    NSArray *present_poinArr = dic[@"present_point"];
                    NSDictionary *presentDic = present_poinArr[0];
                    [_btn3 setTitle:dic[@"title"] forState:UIControlStateNormal];
                    [_btn4 setTitle:presentDic[@"title"] forState:UIControlStateNormal];
                    weakSelf.agentmodel.title3 = dic[@"title"];
                    weakSelf.agentmodel.value3 = dic[@"value"];
                    
                    weakSelf.agentmodel.title4 = presentDic[@"title"];
                    weakSelf.agentmodel.value4 = presentDic[@"value"];
                }
                
            
            }
//            [weakSelf.view toastShow:msg];
//            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        else{
            [weakSelf.view toastShow:msg];
        }
        
    }];
}

#pragma mark - private
- (void)setup
{
    self.title = @"开通商家";
    if (_agentmodel == nil) {
        _agentmodel = [AgentPlatformModel new];
    }
    _mainLineTxet.KYPlaceholderColor = RGB(207, 207, 211);
    _mainLineTxet.KYPlaceholder = @"请输入店铺主营业务（60字内）";
    _mainLineTxet.maxTextCount = 60;
    [starBtn setTitleColor:RGB(207, 207, 211) forState:UIControlStateNormal];
    [starBtn setTitle:@"开始时间" forState:UIControlStateNormal];
    [endBtn setTitleColor:RGB(207, 207, 211) forState:UIControlStateNormal];

    [endBtn setTitle:@"结束时间" forState:UIControlStateNormal];

}



- (void)setConfiguration
{
    
}

//__weak IBOutlet UIButton *_btn1;
//__weak IBOutlet UIButton *_btn2;
//
//__weak IBOutlet UIButton *_btn3;
//__weak IBOutlet UIButton *_btn4;
/// 让利
- (IBAction)benefitBtn:(UIButton *)sender {
    if (sender == _btn1) {
        _btn1.selected = YES;
        _btn2.selected = NO;
        _btn3.selected = YES;
        _btn4.selected = NO;

    }else{
        _btn1.selected = NO;
        _btn2.selected = YES;
        _btn3.selected = NO;
        _btn4.selected = YES;
    }
    
    
}


/// 积分比例
- (IBAction)integralBtn:(UIButton *)sender {
    if (sender == _btn3) {
        _btn1.selected = YES;
        _btn2.selected = NO;
        _btn3.selected = YES;
        _btn4.selected = NO;
        
        
    }else{
        _btn1.selected = NO;
        _btn2.selected = YES;
        _btn3.selected = NO;
        _btn4.selected = YES;
    }
}



/// 选择图片
- (IBAction)didClickImageBtnAction:(UIButton *)sender {
    /// 1000 上传门头   1001 上传营业  1002 上传签约  1003身份证正面  1004 反面

    KX_ActionSheet *sheetView  = [KX_ActionSheet  sheetWithTitle:@"选择图片" cancelButtonTitle:@"取消" clicked:^(KX_ActionSheet *actionSheet, NSInteger buttonIndex) {
        NSString *filename = @"";
        if (sender.tag == 1000) {
            filename = @"shop_image";
        }
        else if (sender.tag == 1001)
        {
            filename = @"license_image";
        }
        else if (sender.tag == 1002)
        {
            filename = @"agreement_image";
        }
        else if (sender.tag == 1003)
        {
            filename = @"idcard_image";
        }
        else if (sender.tag == 1004)
        {
            filename = @"idcard_image_back";
        }
        WEAKSELF;
        NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[KX_UserInfo sharedKX_UserInfo].user_id,@"user_id", nil];
        [param setObject:@"Shop" forKey:@"department"];
        [param setObject:filename forKey:@"filename"];
        [param setObject:@"file" forKey:@"file"];
        if (buttonIndex == 1) {
            [weakSelf selectImageByPhotoWithBlock:^(UIImage *image)
             {
                 [BaseHttpRequest requestUploadImage:image Url:@"/ucenter/upload_image" Params:param  andFileContents:nil andBlock:^(NSString *imageName) {
//                     weakSelf.stortImageView.image = image;
                     if (sender.tag == 1000) {
                         
                         _doorImageView.image = image;
                     }
                     else if (sender.tag == 1001)
                     {
                         zzImageView.image = image;
                     }
                     else if (sender.tag == 1002)
                     {
                         XyImageView.image = image;
                     }
                     else if (sender.tag == 1003)
                     {
                         idOnImageView.image = image;
                     }
                     else if (sender.tag == 1004)
                     {
                         idDownImageView.image = image;

                     }
                     
                 }];
                 
             }];
        }
        else if(buttonIndex == 2)
        {
            [weakSelf selectImageByCameraWithBlock:^(UIImage *image)
            {
                [BaseHttpRequest requestUploadImage:image Url:@"/ucenter/upload_image" Params:param  andFileContents:nil andBlock:^(NSString *imageName) {
                  if (sender.tag == 1000) {
                      
                      _doorImageView.image = image;
                  }
                  else if (sender.tag == 1001)
                  {
                      zzImageView.image = image;
                  }
                  else if (sender.tag == 1002)
                  {
                      XyImageView.image = image;
                  }
                  else if (sender.tag == 1003)
                  {
                      idOnImageView.image = image;
                  }
                  else if (sender.tag == 1004)
                  {
                      idDownImageView.image = image;
                      
                  }
                }];
            }];
        }
        
    
                                  
        } otherButtonTitleArray:@[@"相册",@"照相"]];
    [sheetView show];

    
}


/// 同意协议/ 查看协议
- (IBAction)didClickAgrreAndXXAction:(UIButton *)sender {
    agrreBnt.selected =! agrreBnt.selected;
}


- (IBAction)lookXYAction:(id)sender {
    
    GoodsAuctionXYVC *VC = [GoodsAuctionXYVC new];
    VC.clickUrl = [NSString stringWithFormat:@"%@/api/shop/agreement",HEAD__URL] ;
    VC.hidesBottomBarWhenPushed = YES;
    VC.title = @"<商家签约协议>";
    [self.navigationController pushViewController:VC animated:YES];
}


- (IBAction)didClickSureBtn:(UIButton *)sender {
    
  
    if (KX_NULLString(_accoutTF.text)) {
        [self.view toastShow:@"开通账号未填写"];
        return;
    }
    
    if (KX_NULLString(_storeIntoreTf.text)) {
        [self.view toastShow:@"店铺简介未填写"];
        return;
    }
    
    if (KX_NULLString(_tellTF.text)) {
        [self.view toastShow:@"店铺联系电话未填写"];
        return;
    }
    
    if (KX_NULLString(_mainLineTxet.text)) {
        [self.view toastShow:@"店铺主营范围未填写"];
        return;
    }
    
    if (KX_NULLString(_agentmodel.province )) {
        [self.view toastShow:@"店铺地址未选择"];
        return;
    }
    
    if (KX_NULLString(_addreDetailTF.text )) {
        [self.view toastShow:@"店铺详细地址未填写"];
        return;
    }
    
    if (KX_NULLString(starBtn.titleLabel.text) || KX_NULLString(endBtn.titleLabel.text)) {
        [self.view toastShow:@"营业时间未填写完整"];
        return;
    }
    
    if (_xyBtn.selected == NO) {
        [self.view toastShow:@"请同意<商家签约协议>"];
        return;
    }
//    if (KX_NULLString(_addreDetailTF.text )) {
//        [self.view toastShow:@"店铺详细地址未填写"];
//        return;
//    }
    
    WEAKSELF;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[KX_UserInfo sharedKX_UserInfo].user_id,@"user_id", nil];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_agentmodel.address forKey:@"address"];
    [param setObject:_accoutTF.text forKey:@"join_mobile"];
    [param setObject:@"Shop" forKey:@"department"];
    [param setObject:[NSString stringWithFormat:@"%@-%@",starBtn.titleLabel.text,endBtn.titleLabel.text] forKey:@"ontime_scope"];
    [param setObject:_nameTF.text  forKey:@"shop_name"];
    [param setObject:_tellTF.text forKey:@"contact_phone"];
    [param setObject:_storeIntoreTf.text forKey:@"description"];
    [param setObject:_mainLineTxet.text forKey:@"business_info"];

    [param setObject:_agentmodel.category_id forKey:@"category_id"];
    [param setObject:_agentmodel.province forKey:@"province"];
    [param setObject:_agentmodel.city forKey:@"city"];
    [param setObject:_agentmodel.district forKey:@"district"];
    [param setObject:_agentmodel.address forKey:@"address"];
    [param setObject:_btn1.selected?_agentmodel.value1:_agentmodel.value2 forKey:@"interest_perc"];
    [param setObject:_btn3.selected?_agentmodel.value3:_agentmodel.value4 forKey:@"present_point_perc"];
    
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/ucenter/join" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@" == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSString *msg = [result valueForKey:@"msg"];
        
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [weakSelf.view toastShow:msg];

        }else{
            [weakSelf.view toastShow:msg];
            
        }
        
        
    }];

}

/// 选择地址
- (void)didClickAddressAction
{
    WEAKSELF;
    [FYLCityPickView showPickViewWithComplete:^(NSArray *arr) {
        addressTF.text = [NSString stringWithFormat:@"%@-%@-%@",arr[0],arr[1],arr[2]];
        weakSelf.agentmodel.province = arr[0];
        weakSelf.agentmodel.city = arr[1];
        weakSelf.agentmodel.district = arr[2];

    }];
}

/// 选择行业
- (void)didClickIndustryAction
{
    WEAKSELF;
//    _industryTf.text = @"饮食";
    SelectBusinssVC *vc = [[SelectBusinssVC alloc] init];
    vc.didClickCompleBlock = ^(ChildModel *model) {
        _industryTf.text = model.name;
        weakSelf.agentmodel.category_id = model.id;
    };
    [self.navigationController pushViewController:vc animated:YES];
}


/// 选择时间
- (IBAction)didClickTimeAction:(UIButton *)sender {
    
    KYDatePickView *datePickView = [[KYDatePickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

    datePickView.datePickViewType  = KYDatePickViewTypeNomal;

    datePickView.completeBlock = ^(NSString *dataStr){
        if (sender == starBtn) {
            [starBtn setTitle:dataStr forState:UIControlStateNormal];
            [starBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
        }
        else{
            
            if (![NSString compareOneDay:starBtn.titleLabel.text withAnotherDay:dataStr]) {
                [self showHint:@"结束时间不能小于开始时间~"];
                
            }else{
                [endBtn setTitle:dataStr forState:UIControlStateNormal];
                [endBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];

            }
        }
    };
    datePickView.datePickerMode = UIDatePickerModeTime;
    [datePickView showDataPicKView];
}



#pragma mark - publice


#pragma mark - set & get



#pragma mark - delegate





@end
