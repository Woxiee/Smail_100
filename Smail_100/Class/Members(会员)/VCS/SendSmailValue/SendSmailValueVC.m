//
//  SendSmailValueVC.m
//  Smail_100
//
//  Created by Faker on 2018/4/15.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SendSmailValueVC.h"
#import "AcctoutWater.h"

@interface SendSmailValueVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accoutTF;
@property (weak, nonatomic) IBOutlet UITextField *samilTF;
@property (weak, nonatomic) IBOutlet UITextField *pointTF;
@property (weak, nonatomic) IBOutlet UITextField *kongcTF;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *smailBtn;
@property (weak, nonatomic) IBOutlet UIButton *pointBtn;
@property (weak, nonatomic) IBOutlet UIButton *kongCBtn;


@property (strong, nonatomic) NSString *type;


@end

@implementation SendSmailValueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
}

#pragma mark - request
- (void)requestListNetWork
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_type forKey:@"type"];
    [param setObject:_accoutTF.text forKey:@"to_mobile"];
    if ([_type isEqualToString:@"point"]) {
        [param setObject:_pointTF.text forKey:@"value"];
    }
    else if ([_type isEqualToString:@"coins_money"]) {
        [param setObject:_samilTF.text forKey:@"value"];
    }
    else{
        [param setObject:_kongcTF.text forKey:@"value"];
    }

    WEAKSELF;
    //    [param setObject:@"" forKey:@"bind_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/ucenter/transfer" andParameters:param andRequesultBlock:^(id result, NSError *error) {
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
    self.title = @"笑脸转赠";
   
    [self setRightNaviBtnTitle:@"转赠记录" withTitleColor:[UIColor whiteColor]];
    _submitBtn.backgroundColor = KMAINCOLOR;
    
    _type = @"coins_money";
    _smailBtn.selected = YES;
    
    _samilTF.placeholder = [NSString stringWithFormat:@"当前可转%@激励笑脸",[KX_UserInfo sharedKX_UserInfo].money];
    _pointTF.placeholder = [NSString stringWithFormat:@"当前可转%@积分",[KX_UserInfo sharedKX_UserInfo].point];
    
    _kongcTF.placeholder = [NSString stringWithFormat:@"当前可转%@空充笑脸",[KX_UserInfo sharedKX_UserInfo].air_money];

}



- (IBAction)didClickAction:(UIButton *)sender {

    if (sender.tag == 100) {
        _smailBtn.selected = YES;
        _pointBtn.selected = NO;
        _kongCBtn.selected = NO;
        _type = @"coins_money";

        _samilTF.userInteractionEnabled = YES;
        _pointTF.userInteractionEnabled = NO;
        _kongcTF.userInteractionEnabled = NO;

        
    }
    
    else if (sender.tag == 101) {
        _smailBtn.selected = NO;
        _pointBtn.selected = YES;
        _kongCBtn.selected = NO;
        _type = @"point";
        
        _samilTF.userInteractionEnabled = NO;
        _pointTF.userInteractionEnabled = YES;
        _kongcTF.userInteractionEnabled = NO;

    }
    else{
        _smailBtn.selected = NO;
        _pointBtn.selected = NO;
        _kongCBtn.selected = YES;
        _type = @"coins_air_money";
        
        _samilTF.userInteractionEnabled = NO;
        _pointTF.userInteractionEnabled = NO;
        _kongcTF.userInteractionEnabled = YES;

    }

    
}




- (IBAction)submitBtn:(id)sender {
    [self.view endEditing:YES];
    if (KX_NULLString(_accoutTF.text)) {
        [self.view toastShow:_accoutTF.placeholder];
        return;
    }
    
    if (KX_NULLString(_samilTF.text) &&  KX_NULLString(_pointTF.text)   &&  KX_NULLString(_kongcTF.text)) {
        [self.view toastShow:@"至少输入一种转赠方式~"];
        return;
    }
    
    if (KX_NULLString(_samilTF.text)) {
        [self.view toastShow:_samilTF.placeholder];
        return;
    }
  
    
    
    [self requestListNetWork];

}

- (void)didClickRightNaviBtn
{
    AcctoutWater *VC = [[AcctoutWater alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
//    @property (weak, nonatomic) IBOutlet UITextField *accoutTF;
//
//    @property (weak, nonatomic) IBOutlet UITextField *samilTF;
//    @property (weak, nonatomic) IBOutlet UITextField *pointTF;
//    @property (weak, nonatomic) IBOutlet UITextField *kongcTF;
//    if (textField == _accoutTF.text) {
//        _model.real_name = textField.text;
//    }
//    if (textField == _codeTF) {
//        _model.bank_account = _codeTF.text;
//    }
//
//    if (textField == _bankNameTF) {
//        _model.bank_address = _bankNameTF.text;
//    }
}


@end
