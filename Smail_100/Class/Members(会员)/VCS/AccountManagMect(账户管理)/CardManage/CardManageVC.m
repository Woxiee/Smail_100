//
//  CardManageVC.m
//  Smail_100
//
//  Created by ap on 2018/4/12.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "CardManageVC.h"
#import "CardCell.h"
#import "AddCardVC.h"

@interface CardManageVC ()

@end

@implementation CardManageVC
static NSString * const CardCellID = @"CardCell";

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
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:@"get" forKey:@"method"];
//    [param setObject:@"" forKey:@"bind_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/ucenter/bank" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = result[@"msg"];
        if ([result[@"code"] integerValue] == 000) {
            
        else{
            [weakSelf.view toastShow:msg];
        }


    }];
    
}

#pragma mark - private
- (void)setup
{
     self.title = @"银行卡管理";
    [self setRightNaviBtnTitle:@"添加"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CardCell" bundle:nil] forCellReuseIdentifier:CardCellID];
    
}



#pragma mark - publice
/// 右侧点击事件
- (void)didClickRightNaviBtn
{
    AddCardVC *VC = [[AddCardVC alloc] init];
    VC.isAdd = YES;
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - set & get



#pragma mark - delegate

#pragma mark - UITaleViewDelegate and UITableViewDatasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:CardCellID forIndexPath:indexPath];
    //    cell.model = self.resorceArray[indexPath.section];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    GoodsDetailVC *vc = [[GoodsDetailVC alloc] init];
    //    ProductModel *model = self.resorceArray[indexPath.section];
    //    vc.productID = [NSString stringWithFormat:@"%ld",(long)model.itemId];
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}



@end
