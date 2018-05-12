//
//  SmileForVC.m
//  Smail_100
//
//  Created by ap on 2018/4/12.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SmileForVC.h"
#import "CardCell.h"
#import "CardModel.h"
#import "CardManageVC.h"
#import "SmileForMoneyCell.h"
#import "GoodSOrderCommonCell.h"
#import "JHCoverView.h"
#import "SetPayPwdVC.h"
#import "SmileMainListVC.h"

@interface SmileForVC ()<JHCoverViewDelegate>
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) JHCoverView *coverView;
@property (nonatomic, strong) NSString *bind_id;


@end

@implementation SmileForVC
static NSString * const CardCellID = @"CardCell";
static NSString * const SmileForMoneyCellID = @"SmileForMoneyCell";

static NSString *const goodSOrderCommonCell = @"GoodSOrderCommonCellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self getCardRequest];
    
 
}


#pragma mark - request
- (void)getCardRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:@"get" forKey:@"method"];
    
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/ucenter/bank" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = result[@"msg"];
        if ([result[@"code"] integerValue] == 000) {
            [weakSelf.resorceArray removeAllObjects];
            NSArray *arr = [NSArray yy_modelArrayWithClass:[CardModel class] json:result[@"data"]];
            if (arr.count >0) {
                for ( CardModel * model in arr) {
                    if ([model.is_default isEqualToString:@"Y"]) {
                        model.isShow = YES;
                        weakSelf.bind_id = model.bind_id;
                        [weakSelf.resorceArray insertObject:model atIndex:0 ];
                        break;
                    }
                }
            }else{
                [weakSelf.resorceArray insertObject:@"添加银行卡" atIndex:0];

            }
            [weakSelf requestListNetWork];

                
//            for ( CardModel * model in arr) {
//                if ([model.is_default isEqualToString:@"Y"]) {
//                    model.isShow = YES;
//                    weakSelf.bind_id = model.bind_id;
//                    [weakSelf.resorceArray insertObject:model atIndex:0 ];
//                    [weakSelf requestListNetWork];
//
//                    break;
//                }else{
//                    [weakSelf.resorceArray insertObject:@"添加银行卡" atIndex:0];
//                    [weakSelf requestListNetWork];
//
//                    break;
//
//                }
//            }
        }
        else{
            [weakSelf.view makeToast:msg];
        }
        
        
    }];
}

- (void)requestListNetWork
{
    WEAKSELF;
    NSString *url = @"";
    url = @"/ucenter/withdraw";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];

    if (!KX_NULLString(_showType)) {
        url = @"/ucenter/withdraw_info";
        [param setObject:_shopID?_shopID:@"" forKey:@"shop_id"];
    }


    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/ucenter/withdraw_info" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = result[@"msg"];
        if ([result[@"code"] integerValue] == 000) {
            weakSelf.dataDic = result[@"data"];
            [weakSelf.resorceArray  addObject: weakSelf.dataDic];
            [weakSelf.tableView reloadData];
        }
        else{
            [weakSelf.view makeToast:msg];
        }
        
    }];
}

- (void)getReflectRequest
{
    WEAKSELF;
  

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_value forKey:@"value"];
    [param setObject:_bind_id forKey:@"bind_id"];
    if (!KX_NULLString(_showType)) {
        [param setObject:@"money" forKey:@"type"];
        [param setObject:_shopID?_shopID:@"" forKey:@"shop_id"];


    }else{
        [param setObject:@"coins_money" forKey:@"type"];
    }
    
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    
    [BaseHttpRequest postWithUrl:@"/ucenter/withdraw" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = result[@"msg"];
        if ([result[@"code"] integerValue] == 000) {
            [weakSelf.view makeToast:msg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeAfter * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];

            });
        }
        else{
            [weakSelf.view makeToast:msg];
        }
        
        
    }];
}


#pragma mark - private
- (void)setup
{
    self.view.backgroundColor = BACKGROUND_COLOR;
 

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"CardCell" bundle:nil] forCellReuseIdentifier:CardCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"SmileForMoneyCell" bundle:nil] forCellReuseIdentifier:SmileForMoneyCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodSOrderCommonCell" bundle:nil] forCellReuseIdentifier:goodSOrderCommonCell];
    self.tableView.backgroundColor = BACKGROUND_COLOR;

    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(0 ,SCREEN_HEIGHT - 49 - 64 , SCREEN_WIDTH, 49);
    sureBtn.userInteractionEnabled = YES;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(didClickSureAction) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.backgroundColor = BACKGROUND_COLORHL;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:sureBtn];
    
    JHCoverView *coverView = [[JHCoverView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    coverView.delegate = self;
    self.coverView = coverView;
    coverView.hidden = YES;
    coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [coverView show];
    
    if (KX_NULLString(_shopID)) {
        [self setRightNaviBtnTitle:@"兑换记录"];
        [sureBtn setTitle:@"确定兑换" forState:UIControlStateNormal];

        
    }else{
        [self setRightNaviBtnTitle:@"提现记录"];
        [sureBtn setTitle:@"确定提现" forState:UIControlStateNormal];

    }

}


- (void)setConfiguration
{
    
}



#pragma mark - publice
- (void)didClickRightNaviBtn
{
 
    SmileMainListVC *vc = [[SmileMainListVC alloc] init];
    if (!KX_NULLString(_showType)) {
        vc.shopID = _shopID;
        vc.isWithdrawal = @"1";
    }
    [self.navigationController pushViewController:vc animated:YES];
   
}

//
-(void)didClickSureAction
{
    [self.view endEditing:YES];
    if (KX_NULLString(_value)) {
        [self.view makeToast:@"请输入想要兑换的数量"];
        return;
    }
    WEAKSELF;
    if (KX_NULLString([KX_UserInfo sharedKX_UserInfo].pay_password)) {
        [self systemAlertWithTitle:nil andMsg:@"您还未设置支付密码" cancel:@"取消" sure:@"去设置" withOkBlock:^(BOOL isOk) {
            SetPayPwdVC  *vc = [[SetPayPwdVC alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }else{
        self.coverView.hidden = NO;
        [self.coverView.payTextField becomeFirstResponder];
        
    }

}


#pragma mark - set & get



#pragma mark - delegate

#pragma mark - UITaleViewDelegate and UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resorceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    
    if (indexPath.section == 0) {
        
        if ([self.resorceArray[indexPath.section] isKindOfClass:[NSString class]]) {
            GoodSOrderCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderCommonCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLB.text = self.resorceArray[indexPath.section];
            cell.titleLB.textColor = TITLETEXTLOWCOLOR;
            cell.detailLB.text = @"";
            return cell;
        }
        
        CardCell *cell = [tableView dequeueReusableCellWithIdentifier:CardCellID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.didClickItemBlcok = ^(CardModel *model, NSInteger index) {
            //        if (index == 0) {
            //            [weakSelf getMainCardRequest:model isDelete:NO];
            //        }else{
            //            [weakSelf getMainCardRequest:model isDelete:YES];
            //
            //        }
            
        };

        cell.indexPath = indexPath;
        cell.model = self.resorceArray[indexPath.section];
        return cell;
    }
    else{
        SmileForMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:SmileForMoneyCellID forIndexPath:indexPath];
        cell.showType = _showType;

        cell.dataDic = _dataDic;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.didClickValueBlock = ^(NSString *text) {
            weakSelf.value = text;
        };
        return cell;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ([self.resorceArray[indexPath.section] isKindOfClass:[NSString class]]) {
            return 45;
        }
        return 100;

    }else{
        return 280;
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        WEAKSELF;
        CardManageVC *vc = [[CardManageVC alloc] init];
        vc.didClickCellBlock = ^(CardModel *model) {
            model.isShow = YES;
            weakSelf.bind_id = model.bind_id;
            [weakSelf.resorceArray replaceObjectAtIndex:0 withObject:model];
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}



- (void)extracted {
    [self getReflectRequest];
}

/**
 JHCoverViewDelegate的代理方法，密码输入正确
 */
- (void)inputCorrectCoverView:(JHCoverView *)control
{
    [self extracted];
}

/**
 密码错误
 */
- (void)coverView:(JHCoverView *)control
{
    [self showHint:@"支付密码输入错误" yOffset:-200];
}

/**
 忘记密码
 */
- (void)forgetPassWordCoverView:(JHCoverView *)control
{
    FindPaypwdVC *vc = [[FindPaypwdVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
