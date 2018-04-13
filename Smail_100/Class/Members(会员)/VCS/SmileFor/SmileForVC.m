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

@interface SmileForVC ()
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSString *value;

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
    //    [param setObject:@"" forKey:@"bind_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/ucenter/bank" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = result[@"msg"];
        if ([result[@"code"] integerValue] == 000) {
            [weakSelf.resorceArray removeAllObjects];
            NSArray *arr = [NSArray yy_modelArrayWithClass:[CardModel class] json:result[@"data"]];
//            for ( CardModel * model in arr) {
//                if ([model.is_default isEqualToString:@"Y"]) {
//                    [weakSelf.resorceArray  addObject:model];
//                    break;
//                }else{
                    [weakSelf.resorceArray  addObject:@"添加银行卡"];

//                }
//            }
            [weakSelf requestListNetWork];

            
        }
        else{
            [weakSelf.view toastShow:msg];
        }
        
        
    }];
}

- (void)requestListNetWork
{
    WEAKSELF;
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/ucenter/withdraw_info" andParameters:nil andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = result[@"msg"];
        if ([result[@"code"] integerValue] == 000) {
            weakSelf.dataDic = result[@"data"];
            [weakSelf.resorceArray addObject: weakSelf.dataDic];
            [weakSelf.tableView reloadData];
        }
        else{
            [weakSelf.view toastShow:msg];
        }
        
        
    }];
}

- (void)getReflectRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:@"coins_money" forKey:@"type"];
    [param setObject:_value forKey:@"value"];

    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/ucenter/withdraw" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = result[@"msg"];
        if ([result[@"code"] integerValue] == 000) {
            [weakSelf.view toastShow:msg];
            [weakSelf.navigationController popViewControllerAnimated:YES];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                SuccessView *successV = [[SuccessView alloc] initWithTrueCancleTitle:@"您的账号出现异常，请重新登录，如若不是本人操作，请联系管理员~" cancelTitle:@"" clickDex:^(NSInteger clickDex) {
//                    if (clickDex == 1) {
//                        [KX_UserInfo presentToLoginView:self];
//
//                    }}];
//                [successV showSuccess];
//            });

          
            

        }
        else{
            [weakSelf.view toastShow:msg];
        }
        
        
    }];
}


#pragma mark - private
- (void)setup
{
    self.title = @"笑脸兑换";
    [self setRightNaviBtnTitle:@"兑换记录"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CardCell" bundle:nil] forCellReuseIdentifier:CardCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"SmileForMoneyCell" bundle:nil] forCellReuseIdentifier:SmileForMoneyCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodSOrderCommonCell" bundle:nil] forCellReuseIdentifier:goodSOrderCommonCell];
    self.tableView.backgroundColor = BACKGROUND_COLOR;

    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(0 ,SCREEN_HEIGHT - 49 - 64 , SCREEN_WIDTH, 49);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.userInteractionEnabled = YES;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(didClickSureAction) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.backgroundColor = BACKGROUND_COLORHL;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:sureBtn];
}


- (void)setConfiguration
{
    
}



#pragma mark - publice
- (void)didClickRightNaviBtn
{
    
}

//
-(void)didClickSureAction
{
    [self.view endEditing:YES];
    if (KX_NULLString(_value)) {
        [self.view toastShow:@"请输入想要兑换的数量"];
        return;
    }
    [self getReflectRequest];
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
        return 400;
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
    if ([self.resorceArray[indexPath.section] isKindOfClass:[NSString class]]) {
        WEAKSELF;
        CardManageVC *vc = [[CardManageVC alloc] init];
        vc.didClickCellBlock = ^(CardModel *model) {
            [weakSelf.resorceArray replaceObjectAtIndex:0 withObject:model];
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
