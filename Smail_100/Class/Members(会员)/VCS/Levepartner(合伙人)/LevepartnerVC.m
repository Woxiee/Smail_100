//
//  LevepartnerVC.m
//  Smail_100
//
//  Created by Faker on 2018/4/7.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "LevepartnerVC.h"
#import "LevePartnerHeadCell.h"
#import "LevePartnerCell.h"
#import "LevePartNerHeadView.h"
#import "LevePartnerModel.h"
#import "SDCycleScrollView.h"
#import "GoodsDetailVC.h"
@interface LevepartnerVC ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)  LevePartnerModel *leveModel;
@property (weak, nonatomic) SDCycleScrollView  *cycleView;

@end

@implementation LevepartnerVC
static NSString * const levePartnerHeadCellID = @"LevePartnerHeadCellID";
static NSString * const levePartnerCellID = @"LevePartnerCellID";



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self getRequestData];
}

- (void)setup
{
    self.title = @"升级合伙人";
    
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220 *hScale) delegate:self placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW]];
    self.cycleView = cycleView;
    self.tableView.tableHeaderView = cycleView;
    
    [self.tableView registerClass:[LevePartnerHeadCell class] forCellReuseIdentifier:levePartnerHeadCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"LevePartnerCell" bundle:nil] forCellReuseIdentifier:levePartnerCellID];
    self.tableView.tableFooterView = [UIView new];
    
    
}


- (void)getRequestData
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@"10" forKey:@"page_size"];
    [param setObject:@"1" forKey:@"pageno"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];

    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/goods/getAgentGoods" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            LevePartnerModel *model = [LevePartnerModel yy_modelWithJSON:result[@"data"]];
            model.banner = [NSArray yy_modelArrayWithClass:[Banners class] json:model.banner];
            [self.resorceArray removeAllObjects];
            for (NSDictionary *dic  in  model.list) {
             ItemContentList *item = [ItemContentList yy_modelWithJSON:dic[@"itemContentList"]];
                
            [self.resorceArray addObject:item];
            }
            NSMutableArray *imgList = [[NSMutableArray alloc] init];
            for (Banners *banner in model.banner) {
                [imgList addObject:banner.pict_url];
            }
            _cycleView.imageURLStringsGroup = imgList;
            weakSelf.leveModel = model;
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf.view makeToast:msg];

        }


    }];

}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.resorceArray.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        LevePartnerHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:levePartnerHeadCellID];
        if (cell == nil) {
            cell = [[LevePartnerHeadCell alloc] initWithStyle:UITableViewCellStyleValue1
                                              reuseIdentifier:levePartnerHeadCellID];
        }
        cell.model = _leveModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
    }
    else{
        LevePartnerCell *cell = [tableView dequeueReusableCellWithIdentifier:levePartnerCellID forIndexPath:indexPath];
        cell.itemContentList = self.resorceArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.didClickItemBlock = ^(NSString *goodsId) {
//            if ([[KX_UserInfo sharedKX_UserInfo].agent_level intValue] == 0 ) {
//                [self.view makeToast:@"亲，购买创业礼包即可免费升级成为合伙人"];
//                return;
//            }
            GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                         navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
            vc.productID = goodsId;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: vc animated:YES];
        };
        return cell;
    }
    
    
    return nil;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return  [tableView cellHeightForIndexPath:indexPath model:_leveModel keyPath:@"model" cellClass:[LevePartnerHeadCell class] contentViewWidth:SCREEN_WIDTH];
    }
    return 130;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    self.topSreenView.backgroundColor = [UIColor redColor];
    if (self.resorceArray.count == 0) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];

    
    UIView  *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    lineView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    [view addSubview:lineView];
    
    LevePartNerHeadView *headerView = [[LevePartNerHeadView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 50)];
    headerView.titleLB.text =  @"-- 免费成为代理合伙人 --";
    headerView.detailLB.text = @"购买创业礼包即可免费升级";
    [view addSubview:headerView];
    
    
    UIView *lineView1 =[[UIView alloc] initWithFrame:CGRectMake(0, 54.5, SCREEN_WIDTH, 0.5)];
    lineView1.backgroundColor = LINECOLOR;
    [view addSubview:lineView1];
    
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 50;
}


@end
