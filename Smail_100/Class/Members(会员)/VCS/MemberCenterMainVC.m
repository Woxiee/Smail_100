//
//  MemberCenterMainVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/3.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "MemberCenterMainVC.h"
#import "MemberCenterHeaderView.h"
#import "MemberCenterOrderCell.h"
#import "MemberMoneyCell.h"
#import "GoodsCommonCell.h"
#import "AllOrderManageVC.h"
#import "MyTeamDetailVC.h"
#import "MerchantCenterVC.h"
#import "AccountManagVC.h"

@interface MemberCenterMainVC ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) MemberCenterHeaderView * headerView;
@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MemberCenterMainVC
static NSString * const goodsCommonCellID = @"GoodsCommonCellID";
static NSString * const memberMoneyCellID = @"memberMoneyCellID";
static NSString * const memberCenterOrderCellID = @"memberCenterOrderCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
    NSArray *dataArray = nil;
//    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLogin)];
        [_headerView addGestureRecognizer:tap];
//    }
    
    dataArray = @[@[@"账户积分"],@[@"订单管理"],@[@"账户管理",@"我的推广",@"钱包转赠",@"笑脸兑换",@"账户流水",@"消息中心",@"官方客服",@"帮助反馈",@"系统设置"]];
    
    [self.resorceArray addObjectsFromArray:dataArray];
    [self.tableView reloadData];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [_headerView refreshInfo];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}


/// 配置基础设置
- (void)setConfiguration
{
    self.view.backgroundColor = BACKGROUNDNOMAL_COLOR;
    self.tableView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsCommonCell" bundle:nil] forCellReuseIdentifier:goodsCommonCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"MemberMoneyCell" bundle:nil] forCellReuseIdentifier:memberMoneyCellID];
    [self.tableView registerClass:[MemberCenterOrderCell class] forCellReuseIdentifier:memberCenterOrderCellID];
}


/// 初始化视图
- (void)setup
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -50) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 44;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _headerView = [MemberCenterHeaderView membershipHeadView];
    
    self.tableView.tableHeaderView = _headerView;
    if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
}




#pragma mark - UITaleViewDelegate and UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resorceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.resorceArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    NSString *titleStr = self.resorceArray[indexPath.section][indexPath.row];
    if ([titleStr isEqualToString:@"账户积分"]) {
        MemberMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:memberMoneyCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //  cell.model = self.resorceArray[indexPath.section];
        return cell;
    }
    if ([titleStr isEqualToString:@"订单管理"]) {
        MemberCenterOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:memberCenterOrderCellID forIndexPath:indexPath];
        cell.orderItemsBlock = ^(NSInteger index){
            if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
                [KX_UserInfo presentToLoginView:self];
                return;
            }
            
            [weakSelf pushVCIndex:index];
      
         
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{

        NSArray *imageList  = @[@"gerenzhongxin11@3x.png",@"gerenzhongxin12@3x.png",@"gerenzhongxin13@3x.png",@"gerenzhongxin14@3x.png",@"gerenzhongxin15@3x.png",@"gerenzhongxin16@3x.png",@"gerenzhongxin17@3x.png",@"gerenzhongxin18@3x.png",@"gerenzhongxin19@3x.png"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"indefiiecell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"indefiiecell"];
        }
        cell.imageView.image = [UIImage imageNamed:imageList[indexPath.row]];
       cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
         cell.textLabel.text =  self.resorceArray[indexPath.section][indexPath.row];
        cell.textLabel.font = Font14;
        return cell;
        
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleStr = self.resorceArray[indexPath.section][indexPath.row];
    if ([titleStr isEqualToString:@"账户积分"]) {
        return 70;
    }
    else if ([titleStr isEqualToString:@"订单管理"]){
        return 150;
    }
    else{
        return 44;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    headView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    return headView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *titleStr = self.resorceArray[indexPath.section][indexPath.row];
    if ([titleStr isEqualToString:@"账户管理"]) {
        AccountManagVC *vc = [[AccountManagVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - private
- (void)clickLogin
{
    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
        [KX_UserInfo presentToLoginView:self];

    }else{
     
    }
}


- (void)pushVCIndex:(NSInteger )index
{
   
    if (index == 4) {
        MerchantCenterVC *VC = [[MerchantCenterVC alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController  pushViewController:VC animated:YES];

    }
    
    else if (index == 6) {
        
    }
    
    else if (index == 7) {
        MyTeamDetailVC *VC = [[MyTeamDetailVC alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController  pushViewController:VC animated:YES];
    }
    else{
        AllOrderManageVC *VC = [AllOrderManageVC new];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

@end
