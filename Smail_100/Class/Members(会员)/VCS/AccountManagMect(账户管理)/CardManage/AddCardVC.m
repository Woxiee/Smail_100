//
//  AddCardVC.m
//  Smail_100
//
//  Created by ap on 2018/4/12.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AddCardVC.h"
#import "LZCityPickerController.h"
#import "SelectBankCardVC.h"

@interface AddCardVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIView *BankTypeView;
@property (weak, nonatomic) IBOutlet UITextField *bankTypeTF;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *bankNameTF;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation AddCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];


}

#pragma mark - request
- (void)requestListNetWork
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    if (!_isAdd) {
        [param setObject:_model.bind_id forKey:@"bind_id"];
        [param setObject:@"edit" forKey:@"method"];

    }else{
        [param setObject:@"bind" forKey:@"method"];

    }
    [param setObject:[KX_UserInfo sharedKX_UserInfo].realname forKey:@"real_name"];
    [param setObject:_model.bank_id forKey:@"bank_id"];

    
    [param setObject:_model.bank_account forKey:@"bank_account"];
    [param setObject:_model.bank_name forKey:@"bank_name"];
//    [param setObject:_model.bank_mobile forKey:@"bank_mobile"];
    [param setObject:_model.bank_region forKey:@"bank_region"];
    [param setObject:_model.bank_address forKey:@"bank_address"];

    
    [param setObject:@"N" forKey:@"is_default"];
    WEAKSELF;
    //    [param setObject:@"" forKey:@"bind_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/ucenter/bank" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = result[@"msg"];
        if ([result[@"code"] integerValue] == 000) {
            [weakSelf.view toastShow:msg];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        else{
            [weakSelf.view toastShow:msg];
        }
        
    }];
    
}


- (void)setup
{
    if (_isAdd) {
        self.title = @"银行卡管理";
        _model = [[CardModel alloc] init];
        
        _nameTF.text = [NSString stringWithFormat:@"%@",[KX_UserInfo sharedKX_UserInfo].realname];
    }
    else{
        _nameTF.text = _model.real_name;
        _codeTF.text = _model.bank_account;
        _bankTypeTF.text = _model.bank_name;
        _addressTF.text =  _model.bank_region;
        _bankNameTF.text = _model.bank_address;

//        if (KX_NULLString( _nameTF.text)) {
//            [self.view toastShow:_nameTF.placeholder];
//            return;
//        }
//        if (KX_NULLString( _codeTF.text)) {
//            [self.view toastShow:_codeTF.placeholder];
//            return;
//        }
//        if (![Common validateBankAccount:_codeTF.text]) {
//            [self.view toastShow:@"请输入有效的银行卡号"];
//            return;
//        }
//        
//        if (KX_NULLString(_bankTypeTF.text)) {
//            [self.view toastShow:_bankTypeTF.placeholder];
//            return;
//        }
//        if (KX_NULLString( _addressTF.text)) {
//            [self.view toastShow:_addressTF.placeholder];
//            return;
//        }
//        if (KX_NULLString( _bankNameTF.text)) {
//            [self.view toastShow:_bankNameTF.placeholder];
//            return;
//        }

        
    }
    
    _nameTF.delegate = self;
    _codeTF.delegate = self;
    _bankNameTF.delegate = self;
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = PLACEHOLDERFONT;
    _sureBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    _sureBtn.backgroundColor = KMAINCOLOR;
    
    _BankTypeView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBankTypeAction)];
    [_BankTypeView  addGestureRecognizer:tap1];
    
    
    _addressView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickAddressAction)];
    [_addressView  addGestureRecognizer:tap2];
}


- (void)didClickBankTypeAction
{
    WEAKSELF;
    SelectBankCardVC *vc = [[SelectBankCardVC alloc] init];
    vc.didSelectItemBlock = ^(CardModel *model) {
        weakSelf.model.bank_id = model.id;
        weakSelf.model.bank_name = model.name;
        weakSelf.bankTypeTF.text = model.name;

    };
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didClickAddressAction
{
    [self.view endEditing:YES];

    WEAKSELF;
    [LZCityPickerController showPickerInViewController:self selectBlock:^(NSString *address, NSString *province, NSString *city, NSString *area) {
        // 选择结果回调
        NSLog(@"%@--%@--%@--%@",address,province,city,area);
        //        weakSelf.model.province = province;
        //        weakSelf.model.city = city;
        weakSelf.model.bank_region = address;
        weakSelf.addressTF.text = address;
        //        [adressBtn setTitle:address forState:UIControlStateNormal];
    }];
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _nameTF) {
        _model.real_name = textField.text;
    }
    if (textField == _codeTF) {
        _model.bank_account = _codeTF.text;
    }
    
    if (textField == _bankNameTF) {
        _model.bank_address = _bankNameTF.text;
    }
}

- (IBAction)didClickSureAction:(id)sender {
    
    [self.view endEditing:YES];
    if (![[KX_UserInfo sharedKX_UserInfo].idcard_auth isEqualToString:@"Y"] ) {
        [self.view toastShow:@"请先实名认证后在添加银行卡"];
        return ;
    }
//    if (KX_NULLString( _nameTF.text)) {
//        [self.view toastShow:_nameTF.placeholder];
//        return;
//    }
    if (KX_NULLString( _codeTF.text)) {
        [self.view toastShow:_codeTF.placeholder];
        return;
    }
    if (![Common validateBankAccount:_codeTF.text]) {
        [self.view toastShow:@"请输入有效的银行卡号"];
        return;
    }

    if (KX_NULLString(_bankTypeTF.text)) {
        [self.view toastShow:_bankTypeTF.placeholder];
        return;
    }
    if (KX_NULLString( _addressTF.text)) {
        [self.view toastShow:_addressTF.placeholder];
        return;
    }
    if (KX_NULLString( _bankNameTF.text)) {
        [self.view toastShow:_bankNameTF.placeholder];
        return;
    }

    [self requestListNetWork];
}


@end
