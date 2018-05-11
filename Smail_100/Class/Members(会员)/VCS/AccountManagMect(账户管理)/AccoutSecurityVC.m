//
//  AccoutSecurityVC.m
//  Smail_100
//
//  Created by ap on 2018/4/3.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AccoutSecurityVC.h"
#import "SetLoginPwdVC.h"
#import "SetPayPwdVC.h"

@interface AccoutSecurityVC ()

@end

@implementation AccoutSecurityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户安全设置";
    self.tableView.tableFooterView = [UIView new];
    NSArray *dataArray;

    if (KX_NULLString([KX_UserInfo sharedKX_UserInfo].pay_password)) {

        dataArray = @[@"修改登录密码",@"设置支付密码"];
    }else{
        dataArray = @[@"修改登录密码",@"修改支付密码"];
    }

    [self.resorceArray addObjectsFromArray:dataArray];
    
    [self.tableView reloadData];
}

#pragma mark - UITaleViewDelegate and UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.resorceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"indefiiecell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"indefiiecell"];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text =  self.resorceArray[indexPath.row];
    cell.textLabel.font = Font15;
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *titleStr = self.resorceArray[indexPath.row];
    if ([titleStr isEqualToString:@"修改登录密码"]) {
        SetLoginPwdVC *VC = [[SetLoginPwdVC alloc] init];
        VC.title = titleStr;
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    //    NSArray *dataArray = @[@"基本资料",@"实名认证",@"银行卡管理",@"我的收货地址",@"账户安全设置"];
    //
    else if ([titleStr isEqualToString:@"修改支付密码"]) {
        SetPayPwdVC *VC = [[SetPayPwdVC alloc] init];
        VC.title = titleStr;

        [self.navigationController pushViewController:VC animated:YES];
        
    }
  
    
    
}

@end
