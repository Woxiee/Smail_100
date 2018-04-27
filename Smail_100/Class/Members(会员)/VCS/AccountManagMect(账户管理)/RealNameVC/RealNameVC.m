//
//  RealNameVC.m
//  Smail_100
//
//  Created by ap on 2018/4/16.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "RealNameVC.h"
#import "CustomAlertView.h"

@interface RealNameVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *idTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *deviceTF;
@property (weak, nonatomic) IBOutlet UIImageView *upImageView;
@property (weak, nonatomic) IBOutlet UIImageView *downImageView;
@property (weak, nonatomic) IBOutlet UIImageView *otherImageView;

@property (weak, nonatomic)  UIImageView *stateImageView;


@end

@implementation RealNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self getData];

}

#pragma mark - request
- (void)getData
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/ucenter/get_idcard" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([result[@"code"] intValue] == 0 ) {
            weakSelf.stateImageView.hidden = NO;
//            Enabled,已审核 DIsabled:待审核 ,Fail:审核失败
            if ([result[@"data"][@"status"] isEqualToString:@"Enabled"] || [result[@"data"][@"status"] isEqualToString:@"Disabled"]) {
                weakSelf.nameTF.text = result[@"data"][@"realname"];
                weakSelf.idTF.text = result[@"data"][@"idcard"];
                weakSelf.phoneTF.text = result[@"data"][@"mobile"];
                weakSelf.deviceTF.text = result[@"data"][@"devid"];
                weakSelf.deviceTF.placeholder = @"";
                [weakSelf.upImageView sd_setImageWithURL:[NSURL URLWithString:result[@"data"][@"idcard_image"]]];
                [weakSelf.downImageView sd_setImageWithURL:[NSURL URLWithString:result[@"data"][@"idcard_image_back"]]];
                [weakSelf.otherImageView sd_setImageWithURL:[NSURL URLWithString:result[@"data"][@"people_image"]]];

                weakSelf.nameTF.userInteractionEnabled = NO;
                weakSelf.idTF.userInteractionEnabled = NO;
                weakSelf.phoneTF.userInteractionEnabled = NO;
                weakSelf.deviceTF.userInteractionEnabled = NO;
                weakSelf.rightNaviBtn.hidden = YES;
                self.navigationItem.rightBarButtonItem = nil;
            }
            
            if ([result[@"data"][@"status"] isEqualToString:@"Disabled"]) {
               weakSelf.stateImageView.image = [UIImage imageNamed:@"waitImage@3x.png"];
                self.navigationItem.rightBarButtonItem = nil;

            }
            
        }else{
            [weakSelf.view makeToast:result[@"msg"]];

        }

    }];
  
}

- (void)requestListNetWork
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_nameTF.text forKey:@"realname"];
    [param setObject:_idTF.text forKey:@"idcard"];
    [param setObject:_phoneTF.text forKey:@"mobile"];
    [param setObject:_deviceTF.text forKey:@"devid"];
    NSData *imageData = UIImageJPEGRepresentation(self.upImageView.image , 0.3);
    NSData *imageData1 = UIImageJPEGRepresentation(self.downImageView.image , 0.3);
    NSData *imageData2 = UIImageJPEGRepresentation(self.otherImageView.image , 0.3);
    
    if (imageData == nil) {
        [self.view makeToast:@"请上传身份证正面照"];
        return;
    }
    if (imageData1 == nil) {
        [self.view makeToast:@"请上传身份证背面照"];
        return;
    }
    if (imageData2 == nil) {
        [self.view makeToast:@"请上传手持身份证正面照"];
        return;
    }
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [[BaseHttpRequest alloc] requestUploadImageList:@[self.upImageView.image,self.downImageView.image,self.otherImageView.image] Url:@"/ucenter/idcard_auth" Params:param andBlock:^(NSString *imageName) {
        [weakSelf.view makeToast:imageName];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    }];

    
}


- (void)setup
{
    
    self.title = @"实名认证";
    [self setRightNaviBtnTitle:@"提交" withTitleColor:[UIColor whiteColor]];

    UIImageView *stateImageView = [[UIImageView alloc] init];
    stateImageView.frame = CGRectMake((SCREEN_WIDTH - 110)/2, 120, 110, 110);
    stateImageView.image = [UIImage imageNamed:@"zhanghuguanli7@3x.png"];
    stateImageView.alpha = 0.7;
    [self.view addSubview:stateImageView];
    stateImageView.hidden = YES;

    self.stateImageView = stateImageView;
}



- (void)didClickRightNaviBtn
{
    if (KX_NULLString(_nameTF.text)) {
        [self.view makeToast:_nameTF.placeholder];
        return;
    }
    if (KX_NULLString(_idTF.text)) {
        [self.view makeToast:_idTF.placeholder];
        return;
    }
    
    if (KX_NULLString(_phoneTF.text)) {
        [self.view makeToast:_phoneTF.placeholder];
        return;
    }
    
  
    [self requestListNetWork];
}


/// 选择图片
- (IBAction)didClickImageBtnAction:(UIButton *)sender {
    
    WEAKSELF;
    CustomAlertView *alert = [[CustomAlertView alloc] initWithAlertViewHeight:320];
    alert.ButtonClick = ^void(UIButton*button){
        NSLog(@"%ld",(long)button.tag);
        
        if (button.tag==100) {
            [weakSelf selectImageByPhotoWithBlock:^(UIImage *image) {

                if (sender.tag == 100) {
                    weakSelf.upImageView.image = image;
                }
                else if (sender.tag == 101)
                {
                    weakSelf.downImageView.image = image;

                }
                else{
                    weakSelf.otherImageView.image = image;
                }
                
            }];
            
        }else{
            [weakSelf selectImageByCameraWithBlock:^(UIImage *image) {
                if (sender.tag == 100) {
                    weakSelf.upImageView.image = image;
                }
                else if (sender.tag == 101)
                {
                    weakSelf.downImageView.image = image;
                    
                }
                else{
                    weakSelf.otherImageView.image = image;
                }
            }];
        }
        
        
    };
 
    
    
}


@end
