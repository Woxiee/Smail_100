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
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSString *is_default;


@end

@implementation CardManageVC
static NSString * const CardCellID = @"CardCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
            [weakSelf.resorceArray removeAllObjects];
            NSArray *arr = [NSArray yy_modelArrayWithClass:[CardModel class] json:result[@"data"]];
            [weakSelf.resorceArray addObjectsFromArray:arr];
            [weakSelf.tableView reloadData];
            [weakSelf stopRefresh];

        }
        else{
            [weakSelf.view toastShow:msg];
        }


    }];
    
}


- (void)getMainCardRequest:(CardModel*)model isDelete:(BOOL)isDelete
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    if (isDelete) {
        [param setObject:@"unbind" forKey:@"method"];
        [param setObject:model.bank_account forKey:@"bank_account"];
        [param setObject:model.bank_id forKey:@"bank_id"];


    }else{
        [param setObject:@"edit" forKey:@"method"];
        [param setObject:@"Y" forKey:@"is_default"];
        [param setObject:model.bank_id forKey:@"bank_id"];

    }
    [param setObject:model.bind_id forKey:@"bind_id"];


    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/ucenter/bank" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = result[@"msg"];
        if ([result[@"code"] integerValue] == 000) {
            [weakSelf requestListNetWork];
        }
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
    self.tableView.tableFooterView = [UIView new];
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
    return self.resorceArray.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:CardCellID forIndexPath:indexPath];
    cell.didClickItemBlcok = ^(CardModel *model, NSInteger index) {
        if (index == 0) {
            [weakSelf getMainCardRequest:model isDelete:NO];
        }else{
            [weakSelf getMainCardRequest:model isDelete:YES];

        }
        
        
    };
    cell.indexPath = indexPath;
    cell.model = self.resorceArray[indexPath.section];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_didClickCellBlock) {
        _didClickCellBlock(self.resorceArray[indexPath.section]);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        AddCardVC *VC = [[AddCardVC alloc] init];
        VC.model = self.resorceArray[indexPath.section];
        [self.navigationController pushViewController:VC animated:YES];
    }

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(void)stopRefresh
{
    [self.tableView stopFresh:self.resorceArray.count pageIndex:1];
    if (self.resorceArray.count == 0) {
        [self.tableView addSubview:[KX_LoginHintView notDataView]];
    }else{
        [KX_LoginHintView removeFromSupView:self.tableView];
    }
    
}

@end
