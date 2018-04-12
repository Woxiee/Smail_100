//
//  SelectBankCardVC.m
//  Smail_100
//
//  Created by ap on 2018/4/12.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SelectBankCardVC.h"
@interface SelectBankCardVC ()

@end

@implementation SelectBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];

    [self requestListNetWork];
}



#pragma mark - request
- (void)requestListNetWork
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
//    [param setObject:@"get" forKey:@"method"];
//    //    [param setObject:@"" forKey:@"bind_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/ucenter/get_banks" andParameters:nil andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = result[@"msg"];
        if ([result[@"code"] intValue] == 0) {
            NSArray *listArr = [NSArray yy_modelArrayWithClass:[CardModel class] json:result[@"data"]];
            [weakSelf.resorceArray addObjectsFromArray:listArr];
            [weakSelf.tableView reloadData];
        }
        else{
            [weakSelf.view toastShow:msg];
        }
    }];
    
}

#pragma mark - private
- (void)setup
{
    self.title = @"开户银行";
    self.tableView.tableFooterView = [UIView new];
}

- (void)setConfiguration
{
    
}

#pragma mark - publice


#pragma mark - set & get



#pragma mark - delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resorceArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    CardModel *model = self.resorceArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardModel *model = self.resorceArray[indexPath.row];
    if (self.didSelectItemBlock) {
        self.didSelectItemBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
