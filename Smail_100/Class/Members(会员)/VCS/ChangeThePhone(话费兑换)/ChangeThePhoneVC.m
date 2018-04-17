//
//  ChangeThePhoneVC.m
//  Smail_100
//
//  Created by ap on 2018/3/21.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "ChangeThePhoneVC.h"
#import "SDCycleScrollView.h"
#import "LevePartnerModel.h"
#import "LevePartnerCell.h"
#import "GoodsDetailVC.h"

@interface ChangeThePhoneVC ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) SDCycleScrollView  *cycleView;

@property (nonatomic,strong)  LevePartnerModel *leveModel;

@property (nonatomic, strong) NSMutableArray *detailList;

@end

@implementation ChangeThePhoneVC
static NSString * const levePartnerCellID = @"LevePartnerCellID";

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
    [param setObject:@"10" forKey:@"page_size"];
    [param setObject:@"1" forKey:@"pageno"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/goods/getPhoneGoods" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            LevePartnerModel *model = [LevePartnerModel yy_modelWithJSON:result[@"data"]];
            NSDictionary *userinfoDic = result[@"data"][@"user_info"];
            model.banner = [NSArray yy_modelArrayWithClass:[Banners class] json:model.banner];

            NSMutableArray *imgList = [[NSMutableArray alloc] init];
            for (Banners *banner in model.banner) {
                [imgList addObject:banner.pict_url];
            }
            _cycleView.imageURLStringsGroup = imgList;
            weakSelf.leveModel = model;
            [self.resorceArray removeAllObjects];
            [self.detailList removeAllObjects];

            [self.resorceArray addObject:@"我的账号"];
            [self.resorceArray addObject:@"话费余额"];
            [self.resorceArray addObject:@"话费有效期"];
            [self.detailList addObject:[NSString stringWithFormat:@"%@",userinfoDic[@"username"]]];
            [self.detailList addObject:[NSString stringWithFormat:@"%@元",userinfoDic[@"phone_money"]]];
            [self.detailList addObject:[NSString stringWithFormat:@"%@",userinfoDic[@"valid_time"]]];

            for (NSDictionary *dic  in  model.list) {
                ItemContentList *item = [ItemContentList yy_modelWithJSON:dic[@"itemContentList"]];
                item.showType = @"2"; // 费话
                [self.resorceArray addObject:item];
            }
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf.view toastShow:msg];
            
        }
        
        
    }];

    
}

#pragma mark - private
- (void)setup
{
    self.title = @"话费兑换";

    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220 *hScale) delegate:self placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW]];
    self.cycleView = cycleView;
    self.tableView.tableHeaderView = cycleView;
    [self.tableView registerNib:[UINib nibWithNibName:@"LevePartnerCell" bundle:nil] forCellReuseIdentifier:levePartnerCellID];
    self.tableView.tableFooterView = [UIView new];


}



#pragma mark - publice


#pragma mark - set & get
- (NSMutableArray *)detailList
{
    if (_detailList == nil) {
        _detailList = [[NSMutableArray alloc] init];
    }
    return _detailList;
}


#pragma mark - delegate

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resorceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.resorceArray[indexPath.section] isKindOfClass:[NSString class]]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"indefiiecell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"indefiiecell"];
        }
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text =  self.resorceArray[indexPath.section];
        cell.detailTextLabel.text = self.detailList[indexPath.section];
        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        
        cell.detailTextLabel.font = Font14;
        cell.textLabel.font = Font15;
        return cell;
    }else{
        LevePartnerCell *cell = [tableView dequeueReusableCellWithIdentifier:levePartnerCellID forIndexPath:indexPath];
        cell.itemContentList = self.resorceArray[indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.didClickItemBlock = ^(NSString *goodsId) {
            GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                         navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
            vc.productID = goodsId;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: vc animated:YES];
        };
        return cell;
    }

  
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.resorceArray[indexPath.section] isKindOfClass:[NSString class]]) {
        return 50;
    }
    return 130;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView  *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    lineView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    return lineView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}


@end
