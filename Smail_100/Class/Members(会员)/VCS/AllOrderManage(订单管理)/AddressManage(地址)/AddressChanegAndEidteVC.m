//
//  AddressChanegAndEidteVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/23.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "AddressChanegAndEidteVC.h"
#import "LZCityPickerController.h"
@interface AddressChanegAndEidteVC ()<UITextFieldDelegate>


@end

@implementation AddressChanegAndEidteVC
{
    __weak IBOutlet UITextField *nameTF;
    __weak IBOutlet UITextField *phoneTF;
    __weak IBOutlet UITextField *xxdzText;
    __weak IBOutlet UIButton *adressBtn;
    __weak IBOutlet UIButton *saveBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfiguration];
}

/// 配置基础设置
- (void)setConfiguration
{
    saveBtn.backgroundColor = BACKGROUND_COLORHL;

    if (_bChooseType == BAddType) {
        self.title = @"新增地址";
        _model = [GoodsOrderAddressModel new];
    }else{
        self.title = @"编辑地址";
        nameTF.text = _model.contact_username;
        phoneTF.text = _model.contact_mobile;
        xxdzText.text = _model.detail;
        [adressBtn setTitle:[NSString stringWithFormat:@"%@%@%@",_model.province,_model.city,_model.district] forState:UIControlStateNormal];
    }
    [adressBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    adressBtn.titleLabel.font = PLACEHOLDERFONT;
    adressBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    nameTF.delegate = self;
    phoneTF.delegate = self;
    xxdzText.delegate = self;

}

- (IBAction)selectAddress:(id)sender {
    [self.view endEditing:YES];

    WEAKSELF;
    [LZCityPickerController showPickerInViewController:self selectBlock:^(NSString *address, NSString *province, NSString *city, NSString *area) {
        // 选择结果回调
            NSLog(@"%@--%@--%@--%@",address,province,city,area);
            weakSelf.model.province = province;
           weakSelf.model.city = city;
           weakSelf.model.district = area;

        [adressBtn setTitle:address forState:UIControlStateNormal];
    }];

}

///保存地址
- (IBAction)didSavaBtn:(id)sender {
    [self.view endEditing:YES];
    if (KX_NULLString(_model.contact_username)) {
        [self.view toastShow:@"请输入联系人~"];
        return;
    }
    if (![Common isValidateMobile:_model.contact_mobile]) {
        [self.view toastShow:@"请输入有效电话号码~"];
        return;
    }
    
    if (KX_NULLString(_model.province) || KX_NULLString(_model.city) || KX_NULLString(_model.district)) {
        [self.view toastShow:@"请选择所在地区~"];
        return;
    }
    
    
    if (KX_NULLString(_model.detail) || (_model.detail.length <5 || _model.detail.length>60)) {
        [self.view toastShow:@"详细地址在5-60个字之间~"];
        return;
    }
 
    [self getDefaultAddressRequest];
}


/// 保存
- (void)getDefaultAddressRequest
{
    WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];

    if (_bChooseType == BAddType) {
        [param setObject:@"add" forKey:@"method"];
        [param setObject:@"" forKey:@"id"];
        /// 是否设置默认地址
        if (_addressArr.count == 0) {
            [param setObject:@"Y" forKey:@"is_default"];
        }else{
            [param setObject:@"N" forKey:@"isDefault"];
        }
    }else{
        [param setObject:@"edit" forKey:@"method"];
        [param setObject:_model.addr_id forKey:@"addr_id"];
        [param setObject:_model.is_default forKey:@"is_default"];
    }

    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_model.contact_username  forKey:@"contact_username"];
    [param setObject:_model.contact_mobile  forKey:@"contact_mobile"];
    [param setObject:_model.detail  forKey:@"detail"];
    [param setObject:_model.province forKey:@"province"];
    [param setObject:_model.city  forKey:@"city"];
    [param setObject:_model.district forKey:@"district"];
    
    [BaseHttpRequest postWithUrl:@"/ucenter/address" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单地址 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
//        NSInteger state = [[result valueForKey:@"data"][@"state"] integerValue];
        NSString *msg = result[@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            [weakSelf.view toastShow:msg];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            [weakSelf.view toastShow:msg];

        }
    }];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == nameTF) {
        _model.contact_username = textField.text;
    }
    if (textField == phoneTF) {
        _model.contact_mobile = phoneTF.text;
    }
    
    if (textField == xxdzText) {
        _model.detail = xxdzText.text;
    }
    LOG(@"%@",textField.text);
}


@end
