//
//  AccountManagVC.m
//  Smile_100
//
//  Created by ap on 2018/3/2.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "AccountManagVC.h"
#import "AddressManageVC.h"

@interface AccountManagVC ()

@end

@implementation AccountManagVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = BACKGROUNDNOMAL_COLOR;
//    self.tableView.backgroundColor = BACKGROUNDNOMAL_COLOR;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"账户管理";
    self.tableView.tableFooterView = [UIView new];
    NSArray *dataArray = @[@"基本资料",@"实名认证",@"英航卡管理",@"我的收获地址",@"账户安全设置"];
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
    if ([titleStr isEqualToString:@"我的收获地址"]) {
        AddressManageVC *VC = [[AddressManageVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];

    }
}
@end
