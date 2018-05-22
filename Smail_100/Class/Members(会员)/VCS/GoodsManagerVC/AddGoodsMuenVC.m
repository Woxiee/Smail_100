//
//  AddGoodsMuenVC.m
//  Smail_100
//
//  Created by ap on 2018/3/21.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AddGoodsMuenVC.h"

@interface AddGoodsMuenVC ()
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation AddGoodsMuenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _isEdit?@"修改分类":@"添加分类";
    if (_isEdit) {
        _inputTF.text = _name;
    }
    _inputTF.placeholder = _isEdit?@"请输入名称":@"请输入要添加的分类名称";
    
    [_sureBtn setTitle:_isEdit?@"修改分类":@"添加分类" forState:UIControlStateNormal];
}

- (void)getRequestData
{
        WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_inputTF.text forKey:@"name"];
    
    if (_isEdit) {
        [param setObject:_sub_category_id forKey:@"sub_category_id"];

    }
    
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [BaseHttpRequest postWithUrl:@"/shop/add_sub_category" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"商品订单 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [weakSelf showHint:msg];
            }
        }else{
            [weakSelf showHint:msg];
        }
    }];
}



- (IBAction)didClickSureAction:(UIButton *)sender {
    
    if (KX_NULLString(_inputTF.text)) {
        [self.view makeToast:@"输入内容不能为空"];
        return;
    }
    [self getRequestData];
}

@end
