//
//  AddressManageVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/22.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "AddressManageVC.h"
#import "AddressListCell.h"
#import "AddressChanegAndEidteVC.h"
#import "InvoiceModel.h"
@interface AddressManageVC ()
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, weak) KX_LoginHintView  *loginHintView ;
@end

@implementation AddressManageVC
static NSString *const defaultAdressCellID = @"DefaultAdressCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];

}

- (void)viewWillAppear:(BOOL)animated
{
    [self getDefaultAddressRequest];

}

/// 配置基础设置
- (void)setConfiguration
{
    self.title  = @"管理收获地址";
    self.view.backgroundColor = BACKGROUND_COLOR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = BACKGROUND_COLOR;
    [_bottomView layerForViewWith:0 AndLineWidth:0.5];
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressListCell" bundle:nil] forCellReuseIdentifier:defaultAdressCellID];
    _submitBtn.backgroundColor = BACKGROUND_COLORHL;
    
}


/// 初始化视图
- (void)setup
{
    
}

- (IBAction)addAddressClick:(id)sender {
    if (self.resorceArray.count > 20) {
        [self.view toastShow:@"亲，地址最多不超过20个~"];
        return;
    }
    AddressChanegAndEidteVC *VC = [[AddressChanegAndEidteVC alloc] init];
    VC.bChooseType = BAddType;
    VC.addressArr = self.resorceArray;
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark = request
/// 获取地址
- (void)getDefaultAddressRequest
{
    WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:@"get" forKey:@"method"];
//    [param setObject:@"get" forKey:@"method"];

    [BaseHttpRequest postWithUrl:@"/ucenter/address" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单地址 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSArray *dataArr = [result valueForKey:@"data"];
        if ([dataArr isKindOfClass:[NSArray class]]) {
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                if (weakSelf.resorceArray.count >0) {
                    [weakSelf.resorceArray removeAllObjects];
                }
                NSArray *listArray = [GoodsOrderAddressModel mj_objectArrayWithKeyValuesArray:dataArr];
                [weakSelf.resorceArray addObjectsFromArray:listArray];
            }
        }
        if (weakSelf.resorceArray.count >0) {
            [_loginHintView removeFromSuperview];
            _loginHintView= nil;
        }else{
            KX_LoginHintView  *loginHintView = [KX_LoginHintView loginHintViewWithImage:@"shangchengdingdan2@3x.png" andMsg:@"暂无地址" andBtnTitle:nil andFrame:weakSelf.tableView.bounds];
            [self.view addSubview:loginHintView];
            _loginHintView = loginHintView;
            
        }
        [weakSelf.tableView reloadData];
    }];

}

///地址数据(修改、添加、设置默认)
- (void)getChangeAddressRequest:(NSString *)isDefault withAddressModel:(GoodsOrderAddressModel *)model
{
    WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:model.addr_id forKey:@"addr_id"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:isDefault forKey:@"is_default"];
    [param setObject:@"edit" forKey:@"method"];

    [BaseHttpRequest postWithUrl:@"/ucenter/address" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单地址 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];

//        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                [weakSelf getDefaultAddressRequest];

            }
        [weakSelf.tableView reloadData];
    }];
    
}

/// 删除地址
- (void)getChangeAddressRequestAddressModel:(GoodsOrderAddressModel *)model
{
    WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:model.addr_id forKey:@"addr_id"];
    [param setObject:@"delete" forKey:@"method"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];

    [BaseHttpRequest postWithUrl:@"/ucenter/address" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        //        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            [weakSelf getDefaultAddressRequest];
            
        }
        [weakSelf.tableView reloadData];
    }];

}

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
    GoodsOrderAddressModel *model = self.resorceArray[indexPath.section];
    AddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultAdressCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    cell.didClickBtnBlock = ^(NSInteger index, BOOL state){
        if (index == 0) {
            if (![model.isDefault isEqualToString:@"1"]) {
                SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"确认设为默认地址吗?" clickDex:^(NSInteger clickDex) {
                    if (clickDex == 1) {
                        [weakSelf getChangeAddressRequest:@"1" withAddressModel:model];
                    }
                }];
                [successV showSuccess];
            }
           
        }
        else if (index == 1){
            AddressChanegAndEidteVC *VC = [[AddressChanegAndEidteVC alloc] init];
            VC.bChooseType = BEdiType;
            VC.model = model;
            VC.addressArr = self.resorceArray;
            [weakSelf.navigationController pushViewController:VC animated:YES];
        }
        
        else if (index == 2){
            SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"确认删除该地址吗?" clickDex:^(NSInteger clickDex) {
                if (clickDex == 1) {
                    [weakSelf getChangeAddressRequestAddressModel:model];
                }
                
            }];
            [successV showSuccess];
        }
    };
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{

    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (KX_NULLString(_isValue)) {
        GoodsOrderAddressModel *model = self.resorceArray[indexPath.section];
        _model.addressID = model.id;
        if (_didClickAddressCellBlock) {
            _didClickAddressCellBlock(model);
        }
        
        [self.navigationController popViewControllerAnimated:YES];

    }
}



@end
