//
//  StoreMangerVC.m
//  Smail_100
//
//  Created by Faker on 2018/3/20.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "StoreMangerVC.h"
#import "AgentPlatformModel.h"

@interface StoreMangerVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *pohoteBtn;
@property (weak, nonatomic) IBOutlet UIButton *imagePickBtn;
@property (weak, nonatomic) IBOutlet UIImageView *doorImageView;

@property (weak, nonatomic) IBOutlet UITextField *telTF;


@property (weak, nonatomic) IBOutlet KYTextView *businessTX;
@property (weak, nonatomic) IBOutlet UIView *storeAddressView;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;

@property (weak, nonatomic) IBOutlet UITextField *storeAddressTF;
@property (weak, nonatomic) IBOutlet UITextField *industryTF;
@property (weak, nonatomic) IBOutlet UITextField *benefitT;
@property (weak, nonatomic) IBOutlet UITextField *jfblTF;
@property (weak, nonatomic) IBOutlet UITextField *recommendedTF;
@property (nonatomic, strong) AgentPlatformModel *agentmodel;



@property (weak, nonatomic) IBOutlet  UIButton *starBtn;
@property (weak, nonatomic) IBOutlet  UIButton *endBtn;

@end

@implementation StoreMangerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self getDtaInfoRequest];
    
}

- (void)getDtaInfoRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_shopID forKey:@"shop_id"];
    [param setObject:@"1" forKey:@"is_examine"];
    [BaseHttpRequest postWithUrl:@"/shop/shop_detail" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        NSString *msg = result[@"msg"];

        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            weakSelf.agentmodel = [AgentPlatformModel yy_modelWithJSON:result[@"data"]];
            [weakSelf refreshViewModel: weakSelf.agentmodel];
        }else{
            [weakSelf.view toastShow:msg];

        }

    }];

    
    
    
}

// 选择图片
//- (IBAction)didClickImageBtnAction:(UIButton *)sender {
//    /// 1000 上传门头   1001 上传营业  1002 上传签约  1003身份证正面  1004 反面
//
//    KX_ActionSheet *sheetView  = [KX_ActionSheet  sheetWithTitle:@"选择图片" cancelButtonTitle:@"取消" clicked:^(KX_ActionSheet *actionSheet, NSInteger buttonIndex) {
//        NSString *filename = @"";
//        if (sender.tag == 1000) {
//            filename = @"shop_image";
//        }
//        else if (sender.tag == 1001)
//        {
//            filename = @"license_image";
//        }
//        else if (sender.tag == 1002)
//        {
//            filename = @"agreement_image";
//        }
//        else if (sender.tag == 1003)
//        {
//            filename = @"idcard_image";
//        }
//        else if (sender.tag == 1004)
//        {
//            filename = @"idcard_image_back";
//        }
//        WEAKSELF;
//        if (buttonIndex == 1) {
//            [weakSelf selectImageByPhotoWithBlock:^(UIImage *image)
//             {
//                 [BaseHttpRequest requestUploadImage:image Url:@"/ucenter/upload_image" Params:param  andFileContents:nil andBlock:^(NSString *imageName) {
//                     //                     weakSelf.stortImageView.image = image;
//                     if (sender.tag == 1000) {
//
//                         _doorImageView.image = image;
//                     }
//                     else if (sender.tag == 1001)
//                     {
//                         zzImageView.image = image;
//                     }
//                     else if (sender.tag == 1002)
//                     {
//                         XyImageView.image = image;
//                     }
//                     else if (sender.tag == 1003)
//                     {
//                         idOnImageView.image = image;
//                     }
//                     else if (sender.tag == 1004)
//                     {
//                         idDownImageView.image = image;
//
//                     }
//
//                 }];
//
//             }];
//        }
//        else if(buttonIndex == 2)
//        {
//            [weakSelf selectImageByCameraWithBlock:^(UIImage *image)
//             {
//                 [BaseHttpRequest requestUploadImage:image Url:@"/ucenter/upload_image" Params:param  andFileContents:nil andBlock:^(NSString *imageName) {
//                     if (sender.tag == 1000) {
//
//                         _doorImageView.image = image;
//                     }
//                     else if (sender.tag == 1001)
//                     {
//                         zzImageView.image = image;
//                     }
//                     else if (sender.tag == 1002)
//                     {
//                         XyImageView.image = image;
//                     }
//                     else if (sender.tag == 1003)
//                     {
//                         idOnImageView.image = image;
//                     }
//                     else if (sender.tag == 1004)
//                     {
//                         idDownImageView.image = image;
//
//                     }
//                 }];
//             }];
//        }
//
//
//
//    } otherButtonTitleArray:@[@"相册",@"照相"]];
//    [sheetView show];
//
//
//}


- (IBAction)didClickphotoAction:(UIButton *)sender {
    
    WEAKSELF;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[KX_UserInfo sharedKX_UserInfo].user_id,@"user_id", nil];
    [param setObject:@"Shop" forKey:@"department"];
    [param setObject:@"shop_image" forKey:@"filename"];
    [param setObject:@"file" forKey:@"file"];

//    [param setObject:_model.goods_id?_model.goods_id:@"0" forKey:@"goods_id"];
    if (sender.tag == 100) {
        [self selectImageByPhotoWithBlock:^(UIImage *image)
         {
             [BaseHttpRequest requestUploadImage:image Url:@"/shop/upload_image" Params:param  andFileContents:nil andBlock:^(NSString *imageName) {
                 weakSelf.doorImageView.image = image;
             }];
             
         }];
    }
    
    
    if (sender.tag == 101) {
        [self selectImageByCameraWithBlock:^(UIImage *image)
         {
             [BaseHttpRequest requestUploadImage:image Url:@"/shop/upload_image" Params:param  andFileContents:nil andBlock:^(NSString *imageName) {
                 weakSelf.doorImageView.image = image;
             }];
         }];
    }
    
}


#pragma mark - private
- (void)setup
{
    self.title = @"门店管理";
    if (_agentmodel == nil) {
        _agentmodel = [AgentPlatformModel new];
    }
    _businessTX.KYPlaceholderColor = RGB(207, 207, 211);
    _businessTX.KYPlaceholder = @"请输入店铺主营业务（60字内）";
    _businessTX.maxTextCount = 60;
    [_starBtn setTitleColor:RGB(207, 207, 211) forState:UIControlStateNormal];
    [_starBtn setTitle:@"开始时间" forState:UIControlStateNormal];
    [_endBtn setTitleColor:RGB(207, 207, 211) forState:UIControlStateNormal];
    [_endBtn setTitle:@"结束时间" forState:UIControlStateNormal];
    
}



-(void)viewDidLayoutSubviews{
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 950);
}


- (void)refreshViewModel:(AgentPlatformModel *)model
{
    _addressTF.text = [NSString stringWithFormat:@"%@%@%@",model.province,model.city,model.province];
    _storeAddressTF.text = [NSString stringWithFormat:@"%@",model.address];
    _industryTF.text =  [NSString stringWithFormat:@"%@",model.category_name];
    _benefitT.text =  [NSString stringWithFormat:@"%@",model.interest_perc];
    _jfblTF.text =  [NSString stringWithFormat:@"%@",model.present_point_perc];
    
    _recommendedTF.text = [NSString stringWithFormat:@"%@",model.applicant_mobile];

}
        

/// 选择时间
- (IBAction)didClickTimeAction:(UIButton *)sender {
    
    KYDatePickView *datePickView = [[KYDatePickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    datePickView.datePickViewType  = KYDatePickViewTypeNomal;
    
    datePickView.completeBlock = ^(NSString *dataStr){
        if (sender == _starBtn) {
            [_starBtn setTitle:dataStr forState:UIControlStateNormal];
            [_starBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
        }
        else{
            
            if (![NSString compareOneDay:_starBtn.titleLabel.text withAnotherDay:dataStr]) {
                [self showHint:@"结束时间不能小于开始时间~"];
                
            }else{
                [_endBtn setTitle:dataStr forState:UIControlStateNormal];
                [_endBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
                
            }
        }
    };
    datePickView.datePickerMode = UIDatePickerModeTime;
    [datePickView showDataPicKView];
}


- (IBAction)didSureAciton:(id)sender {
    [self.view endEditing:YES];
    if (KX_NULLString(_telTF.text)) {
        [self.view toastShow:@"店铺联系电话未填写"];
        return;
    }
    
  
    if (KX_NULLString(_starBtn.titleLabel.text) || KX_NULLString(_endBtn.titleLabel.text)) {
        [self.view toastShow:@"营业时间未填写完整"];
        return;
    }
    
    if (KX_NULLString(_businessTX.text)) {
        [self.view toastShow:@"店铺简介未填写"];
        return;
    }
    
    
    
    WEAKSELF;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:_telTF.text forKey:@"contact_phone"];

    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_shopID forKey:@"shop_id"];
    [param setObject:@"Shop" forKey:@"department"];
    [param setObject:@"1" forKey:@"is_examine"];
    [param setObject:_businessTX.text forKey:@"business_info"];

    [param setObject:[NSString stringWithFormat:@"%@-%@",_starBtn.titleLabel.text,_endBtn.titleLabel.text] forKey:@"ontime_scope"];
    [MBProgressHUD showMessag:@"提交中..." toView:self.view];

    [BaseHttpRequest postWithUrl:@"/ucenter/join" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@" == %@",result);
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



@end
