//
//  AddCardVC.m
//  Smail_100
//
//  Created by ap on 2018/4/12.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AddCardVC.h"
#import "LZCityPickerController.h"
#import "CardModel.h"
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
@property (nonatomic, strong) CardModel *model;

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
    [param setObject:@"bind" forKey:@"method"];
    if (!_isAdd) {
        [param setObject:_model.bind_id forKey:@"bind_id"];
    }
    [param setObject:_model.bank_account forKey:@"bank_account"];
    [param setObject:_model.bank_mobile forKey:@"bank_address"];
    [param setObject:_model.bank_mobile forKey:@"bank_mobile"];
    [param setObject:_model.bank_region forKey:@"bank_region"];
    [param setObject:@"N" forKey:@"is_default"];

    //    [param setObject:@"" forKey:@"bind_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/ucenter/bank" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
    
}


- (void)setup
{
    if (_isAdd) {
        self.title = @"银行卡管理";
        _model = [[CardModel alloc] init];
    }
    else{
        
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
        weakSelf.bankTypeTF.text = model.name;
    
    };
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didClickAddressAction
{

    WEAKSELF;
    [LZCityPickerController showPickerInViewController:self selectBlock:^(NSString *address, NSString *province, NSString *city, NSString *area) {
        // 选择结果回调
        NSLog(@"%@--%@--%@--%@",address,province,city,area);
        //        weakSelf.model.province = province;
        //        weakSelf.model.city = city;
        weakSelf.model.bank_address = address;
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
        _model.bank_region = _bankNameTF.text;
    }
}

- (IBAction)didClickSureAction:(id)sender {
    
    [self.view endEditing:YES];
    [self requestListNetWork];
}


@end
