//
//  AgentPlatformVC.m
//  Smail_100
//
//  Created by ap on 2018/3/21.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AgentPlatformVC.h"
#import "AgentPlatfoemMainVC.h"
#import "OpenBusinssVC.h"
#import "AgentPaltFormCell.h"
#import "AgentPaltLoactionCell.h"
#import "MyteamModel.h"
#import "SDCycleScrollView.h"
#import "PartenrIncentiveListVC.h"
#import "PartenrincentTeamVC.h"

@interface AgentPlatformVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *tableHeadView;
@property (weak, nonatomic)   SDCycleScrollView *cycleView;
@property (nonatomic, strong) MyteamModel *model;

@property (nonatomic, strong) NSMutableArray *agentList;
@property (nonatomic, strong) NSMutableArray *shopList;

@end

@implementation AgentPlatformVC
static NSString* AgentPaltFormCellID = @"AgentPaltFormCell";

static NSString* AgentPaltLoactionCellID = @"AgentPaltLoactionCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self getRequestData];
}


#pragma mark - request
- (void)getRequestData
{
    
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].agent_level forKey:@"agent_level"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/group/myAgent" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                MyteamModel *model = [MyteamModel yy_modelWithJSON:result[@"data"]];
                model.banners = [NSArray yy_modelArrayWithClass:[Banners class] json:model.banners];
                model.count = [Count yy_modelWithJSON:result[@"data"][@"count"]];
//                model.count.agent = [Agent yy_modelWithJSON:model.count.agent];
//                model.count.shop = [Shop yy_modelWithJSON:model.count.shop];
                
                
                model.content = [Content yy_modelWithJSON:result[@"data"][@"content"]];
                
                model.content.agent_location = [NSArray yy_modelArrayWithClass:[Agent_location class] json: model.content.agent_location];
                
                NSArray *agentList = @[model.count.agent.reg,model.count.agent.pay,model.count.agent.money];
                for (int i = 0; i< _agentList.count; i++) {
                    UILabel *lb = _agentList[i];
                    lb.text = [NSString stringWithFormat:@"%@", agentList[i]];
                    
                }
                NSArray *shopList = @[model.count.shop.count,model.count.shop.month_money,model.count.shop.money];
                for (int i = 0; i< _shopList.count; i++) {
                    UILabel *lb = _shopList[i];
                    lb.text = [NSString stringWithFormat:@"%@", shopList[i]];

                    
                }
              
                weakSelf.model = model;
                NSMutableArray *imgList = [[NSMutableArray alloc] init];
                for (Banners *banner in model.banners) {
                    [imgList addObject:banner.pict_url];
                }
                _cycleView.imageURLStringsGroup = imgList;
//                NSArray *dataList = @[_model.count.reg,_model.count.pay,_model.count.money];
//                self.selectTeamView.dataList = dataList;
//                self.teamPersenView.model = model;
               
//                }
                
                [weakSelf.tableView reloadData];
                
            }
        }
        
        
    }];

}

#pragma mark - private
- (void)setup
{
    self.title  = @"代理平台";
    _agentList = [[NSMutableArray alloc] init];
    _shopList = [[NSMutableArray alloc] init];

    [self.view addSubview:self.tableView];
    _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200 *hScale+70+5+70)];
    self.tableView.tableHeaderView = _tableHeadView;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  200 *hScale)];
    headView.backgroundColor = KMAINCOLOR;
    [self.view addSubview:headView];
    
    
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:headView.bounds delegate:self placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    [headView addSubview:cycleView];
    self.cycleView = cycleView;
    
    UIView *head1View = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), SCREEN_WIDTH, 70)];
    head1View.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:head1View];
    
    NSArray *listArr = @[@"推荐人数",@"总激活人数",@"团队总业绩(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "];
    NSArray *numberArr = @[@"8888",@"18888",@"888888                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "];

    for (NSInteger i = 0; i < 3; i++) {
        UILabel *numberLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, 15, SCREEN_WIDTH / 3, 20)];
        numberLB.text = numberArr[i];
        numberLB.font = [UIFont systemFontOfSize:22];
        numberLB.textColor = KMAINCOLOR;
        numberLB.textAlignment = NSTextAlignmentCenter;
        [head1View addSubview:numberLB];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, CGRectGetMaxY(numberLB.frame)+5, SCREEN_WIDTH / 3, 20)];
        titleLB.text = listArr[i];
        titleLB.font = Font14;
        titleLB.textColor = DETAILTEXTCOLOR;;
        titleLB.textAlignment = NSTextAlignmentCenter;
        [head1View addSubview:titleLB];
        [_agentList addObject:numberLB];
    }
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(head1View.frame), SCREEN_WIDTH, 5)];
    lineView.backgroundColor = LINECOLOR;
    [self.view addSubview:lineView];

    
    UIView *head2View = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), SCREEN_WIDTH, 70)];
    head2View.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:head2View];
    
    NSArray *listArr1 = @[@"我的商家数",@"今日商家营业额(元) ",@"商家总营业额(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "];
    NSArray *numberArr2 = @[@"88",@"16666",@"88888                                                                                                                                                                                                                                                                                                                                                                                                                                                              "];
    for (NSInteger i = 0; i < 3; i++) {
        UILabel *numberLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, 15, SCREEN_WIDTH / 3, 20)];
        numberLB.text = numberArr2[i];
        numberLB.font = [UIFont systemFontOfSize:22];
        numberLB.textColor = KMAINCOLOR;
        numberLB.textAlignment = NSTextAlignmentCenter;
        [head2View addSubview:numberLB];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, CGRectGetMaxY(numberLB.frame)+5, SCREEN_WIDTH / 3, 20)];
        titleLB.text = listArr1[i];
        titleLB.font = Font14;
        titleLB.textColor = DETAILTEXTCOLOR;;
        titleLB.textAlignment = NSTextAlignmentCenter;
        [head2View addSubview:titleLB];
        [_shopList addObject:numberLB];

    }
    
    

}

- (void)setConfiguration
{
    
}


- (void)didClickItemsAction:(NSString * )title
{
    if ([title isEqualToString:@"团队管理"]) {
        PartenrincentTeamVC *VC = [[PartenrincentTeamVC alloc] init];
        VC.title = @"团队管理";
        [self.navigationController pushViewController:VC animated:YES];
    }
    
   else  if ([title isEqualToString:@"代理激励"]  || [title isEqualToString:@"合伙人激励"]) {
        PartenrIncentiveListVC *VC = [[PartenrIncentiveListVC alloc] init];
        VC.title = title;
        
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    else if ([title isEqualToString:@"合伙人列表"]) {
        [self.navigationController pushViewController:[NSClassFromString(@"ParterListVC") new] animated:YES];

    }
    
    else if ([title isEqualToString:@"开通商家"]) {
        OpenBusinssVC *VC = [[OpenBusinssVC alloc] init];
        VC.title = @"开通商家";
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    else if ([title isEqualToString:@"商家列表"]) {
        AgentPlatfoemMainVC *VC = [[AgentPlatfoemMainVC alloc] init];
        VC.title = @"商家列表";
        
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    
    else{
        [self.view makeToast:@"该功能暂未开放,敬请期待!"];

    }
    
   
}

#pragma mark - publice


#pragma mark - set & get
/*懒加载*/
-(UITableView *)tableView
{
    if (!_tableView) {
        //初始化数据
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 ) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];//默认设置为空
        [_tableView setSeparatorInset:UIEdgeInsetsZero];//默认设置下划线左边移动 15.0f
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = BACKGROUND_COLOR;
        [_tableView registerClass:[AgentPaltFormCell class] forCellReuseIdentifier:AgentPaltFormCellID];
        [_tableView registerClass:[AgentPaltLoactionCell class] forCellReuseIdentifier:AgentPaltLoactionCellID];

    }
    return _tableView;
}




#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    if (indexPath.section == 0) {
        AgentPaltLoactionCell *cell = [tableView dequeueReusableCellWithIdentifier:AgentPaltLoactionCellID forIndexPath:indexPath];
//        cell.accessoryType =  UITableViewCellAccessoryCheckmark;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _model;
        return cell;
    }
    
    if (indexPath.section == 1) {
        AgentPaltFormCell *cell = [tableView dequeueReusableCellWithIdentifier:AgentPaltFormCellID forIndexPath:indexPath];
        cell.didClickOrderItemsBlock = ^(NSString *title){
            [weakSelf didClickItemsAction:title];
            
            
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return [tableView cellHeightForIndexPath:indexPath model:_model keyPath:@"model" cellClass:[AgentPaltLoactionCell class] contentViewWidth:SCREEN_WIDTH];
    }
    if (indexPath.section == 1) {
        return 500;
    }
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    OrderModel  *model = self.resorceArray[indexPath.section];
    //    //    _waitSendVC.orderTypeTitle = @"4";
    //    if ([_orderTypeTitle isEqualToString:@"4"]) {
    //        SaleAfterVC *VC = [[SaleAfterVC alloc] init];
    //        VC.model = model;
    //        [self.navigationController pushViewController:VC animated:YES];
    //    }else{
    //        OrderDetailVC *VC = [[OrderDetailVC alloc] init];
    //        VC.model = model;
    //        [self.navigationController pushViewController:VC animated:YES];
    //    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
}


#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    LOG(@"点击了第%ld张图片",(long)index);
    Banners *banner = _model.banners[index];
    
    if ([banner.click_type isEqualToString:@"web"]) {
        if (KX_NULLString(banner.url)) {
            return;
        }
        GoodsAuctionXYVC *VC = [GoodsAuctionXYVC new];
        VC.clickUrl = banner.url;
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if ([banner.click_type isEqualToString:@"app_category"]){
        GoodsScreeningVC *VC = [[GoodsScreeningVC alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        VC.category_id = banner.id;
        VC.title =  banner.title;
        [self.navigationController pushViewController:VC animated:YES];
    }
    else {
        if (KX_NULLString(banner.goods_id) ) {
            [self.view makeToast:@"该活动暂未开始，请等通知"];
            return;
        }
        /// 商品类型=1:新机。2:配构件。3:整机流转
        GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                     navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        vc.productID = banner.goods_id;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController: vc animated:YES];
    }
    
}

@end
