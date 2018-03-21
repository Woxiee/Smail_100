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

@end

@implementation AddGoodsMuenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加分类";
    
}

- (void)getRequestData
{
        WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_inputTF.text forKey:@"name"];
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
        [self.view toastShow:@"输入内容不能为空"];
        return;
    }
    [self getRequestData];
}

@end
