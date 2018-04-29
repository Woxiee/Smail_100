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
#import "AcctoutWater.h"
#import "AllSet.h"
#import "ChangeThePhoneVC.h"
#import "AgentPlatformVC.h"

#import "LevepartnerVC.h"
#import "SmileForVC.h"
#import "SendSmailValueVC.h"

#import "MyCodeVC.h"

#import "BaseInforVC.h"
#define NAVBAR_COLORCHANGE_POINT - IMAGE_HEIGHT
#define NAV_HEIGHT 64
#define IMAGE_HEIGHT 0
#define SCROLL_DOWN_LIMIT 0
#define LIMIT_OFFSET_Y -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)


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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLogin)];
    [_headerView addGestureRecognizer:tap];
    [self setRefresh];


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self getUserInfo];
    [_headerView refreshInfo];

    [self.resorceArray removeAllObjects];
    NSArray *dataArray = nil;

    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
        dataArray = @[@[@"订单管理"],@[@"账户管理",@"钱包转赠",@"笑脸兑换",@"账户流水",@"话费兑换",@"消息中心",@"官方客服",@"帮助反馈",@"系统设置"]];
        
    }else{
        dataArray = @[@[@"账户积分"],@[@"订单管理"],@[@"账户管理",@"钱包转赠",@"笑脸兑换",@"账户流水",@"话费兑换",@"消息中心",@"官方客服",@"帮助反馈",@"系统设置"]];
    }
   
    [self.resorceArray addObjectsFromArray:dataArray];
    [self.tableView reloadData];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//    [self.navigationController setNavigationBarHidden:NO animated:NO];

}


- (void)getUserInfo
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:@"get" forKey:@"method"];
//http://39.108.4.18:6803/api/ucenter/user  user_id=84561&method=get

    [BaseHttpRequest postWithUrl:@"/ucenter/user" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            KX_UserInfo *userinfo = [KX_UserInfo sharedKX_UserInfo];
            NSDictionary *dataDic = [result valueForKey:@"data"];
            userinfo.paytime =  dataDic[@"paytime"];
            userinfo.mall_id = dataDic[@"mall_id"];
            userinfo.status = dataDic[@"status"];
            userinfo.openid = dataDic[@"openid"];
            userinfo.ctime = dataDic[@"ctime"];
            userinfo.openid = dataDic[@"openid"];
            userinfo.nickname = dataDic[@"nickname"];
            userinfo.pid_trees = dataDic[@"pid_trees"];
            userinfo.agent = dataDic[@"agent"];
            userinfo.sex = dataDic[@"sex"];
            userinfo.qrcode = dataDic[@"qrcode"];
            userinfo.mtime = dataDic[@"mtime"];
            userinfo.user_id = dataDic[@"user_id"];
            userinfo.realname = dataDic[@"realname"];
            userinfo.avatar_url = dataDic[@"avatar_url"];
            userinfo.agent_trees = dataDic[@"agent_trees"];
            userinfo.wxname = [NSString stringWithFormat:@"%@",dataDic[@"wxname"]];
            userinfo.department = dataDic[@"department"];
            userinfo.mobile = dataDic[@"mobile"];
            userinfo.pid = dataDic[@"pid"];
            userinfo.pay_password = dataDic[@"pay_password"];
            userinfo.password = dataDic[@"password"];
            userinfo.phone_money = dataDic[@"phone_money"];
            userinfo.username = dataDic[@"username"];
            
            //                    "used_point" = 0.00,
            
            userinfo.point = dataDic[@"point"];
            userinfo.used_point = dataDic[@"used_point"];
            //                    "money" = 15006.93,
            //                    "air_money" = 0.00,
            
            userinfo.air_money   = dataDic[@"coins"][@"air_money"];
            userinfo.money   = dataDic[@"coins"][@"money"];
            userinfo.maker_level = dataDic[@"maker_level"];
            userinfo.shop_level = dataDic[@"shop_level"];
            userinfo.agent_level = dataDic[@"agent_level"];
            userinfo.idcard_auth = dataDic[@"idcard_auth"];

            [[KX_UserInfo sharedKX_UserInfo] saveUserInfoToSanbox];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self stopRefresh];
//            });
            [_headerView refreshInfo];

        }

    }];
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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -50 - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 44;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _headerView = [MemberCenterHeaderView membershipHeadView];
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 165);
    WEAKSELF;
    _headerView.didClickHHRBlock = ^{
        LevepartnerVC *VC = [[LevepartnerVC alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:VC animated:YES];
    };
    
    _headerView.didClickMyCodeBlock = ^{
        MyCodeVC *VC = [[MyCodeVC alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:VC animated:YES];
    };
    self.tableView.tableHeaderView = _headerView;
//    self.tableView.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT-64, 0, 0, 0);
//
//    [self wr_setNavBarBarTintColor:KMAINCOLOR];
//    [self wr_setNavBarBackgroundAlpha:0];
//    [self wr_setNavBarShadowImageHidden:NO];
    self.title = @"我的";
}



//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat offsetY = scrollView.contentOffset.y;
//
//    if (offsetY > NAVBAR_COLORCHANGE_POINT)
//    {
//        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
//        [self wr_setNavBarBackgroundAlpha:alpha];
//        if (alpha > 0.5) {
//            [self wr_setNavBarTintColor:[UIColor redColor]];
//            [self wr_setNavBarTitleColor:[UIColor whiteColor]];
//            [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
//        } else {
//            [self wr_setNavBarTintColor:[UIColor whiteColor]];
//            [self wr_setNavBarTitleColor:[UIColor clearColor]];
//            [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
//        }
//    }
//    else
//    {
//        [self wr_setNavBarBackgroundAlpha:0];
//        [self wr_setNavBarTintColor:[UIColor whiteColor]];
//        [self wr_setNavBarTitleColor:[UIColor clearColor]];
//        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
//    }
//
//    //限制下拉的距离
//    if(offsetY < LIMIT_OFFSET_Y) {
//        [scrollView setContentOffset:CGPointMake(0, LIMIT_OFFSET_Y)];
//    }
//
//    // 改变图片框的大小 (上滑的时候不改变)
//    // 这里不能使用offsetY，因为当（offsetY < LIMIT_OFFSET_Y）的时候，y = LIMIT_OFFSET_Y 不等于 offsetY
//    CGFloat newOffsetY = scrollView.contentOffset.y;
//    if (newOffsetY < -IMAGE_HEIGHT)
//    {
//        self.headerView.frame = CGRectMake(0, newOffsetY, kScreenWidth, -newOffsetY);
//    }
//}
//


#pragma mark - UITaleViewDelegate and UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resorceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSMutableArray* )self.resorceArray[section] count];
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
        NSArray *imageList  = @[@"gerenzhongxin11@3x.png",@"gerenzhongxin13@3x.png",@"gerenzhongxin14@3x.png",@"gerenzhongxin15@3x.png",@"gerenzhongxin115@3x.png",@"gerenzhongxin16@3x.png",@"gerenzhongxin17@3x.png",@"gerenzhongxin18@3x.png",@"gerenzhongxin19@3x.png",@"gerenzhongxin19@3x.png"];
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
        return 50;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section == 0) {
        return 0;
    }
    return 5;
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

    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
        [KX_UserInfo presentToLoginView:self];
        return;
    }
    NSString *titleStr = self.resorceArray[indexPath.section][indexPath.row];
    if ([titleStr isEqualToString:@"账户管理"]) {
        AccountManagVC *vc = [[AccountManagVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
   else if ([titleStr isEqualToString:@"账户流水"]) {
        AcctoutWater *vc = [[AcctoutWater alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
       vc.title = titleStr;
        [self.navigationController pushViewController:vc animated:YES];
    }
   else if ([titleStr isEqualToString:@"话费兑换"]) {
       ChangeThePhoneVC *vc = [[ChangeThePhoneVC alloc] init];
       vc.hidesBottomBarWhenPushed = YES;
       [self.navigationController pushViewController:vc animated:YES];
   }
   else if ([titleStr isEqualToString:@"系统设置"]) {
        AllSet *vc = [[AllSet alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
   else if ([titleStr isEqualToString:@"笑脸兑换"]) {
       SmileForVC *vc = [[SmileForVC alloc] init];
       vc.title = titleStr;
       vc.hidesBottomBarWhenPushed = YES;
       [self.navigationController pushViewController:vc animated:YES];
   }
   else if ([titleStr isEqualToString:@"钱包转赠"]) {
       SendSmailValueVC *vc = [[SendSmailValueVC alloc] init];
       vc.hidesBottomBarWhenPushed = YES;
       [self.navigationController pushViewController:vc animated:YES];
   }
    
    
    
    
    else{
        [self.view makeToast:@"该功能暂未开放,请稍后!"];
    }
    
    
}

#pragma mark - private
- (void)clickLogin
{
    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
        [KX_UserInfo presentToLoginView:self];

    }else{
        BaseInforVC *VC = [[BaseInforVC alloc]init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
}


- (void)pushVCIndex:(NSInteger )index
{

    if (index == 4) {
//        [KX_UserInfo sharedKX_UserInfo].maker_level = @"0";
        if ([KX_UserInfo sharedKX_UserInfo].maker_level.integerValue >0) {
            MerchantCenterVC *VC = [[MerchantCenterVC alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController  pushViewController:VC animated:YES];
        }else{
            [self.view makeToast:@"您还不是商家，请开通商家后进入"];
        }
    }
    
    else if (index == 6) {
        if ([KX_UserInfo sharedKX_UserInfo].agent_level.integerValue >0) {
            AgentPlatformVC *VC = [[AgentPlatformVC alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController  pushViewController:VC animated:YES];
        }else{
            [self.view makeToast:@"您还不是代理商，请签约成为代理。"];
        }
     
    }
    
//    else if (index == 7) {
//        MyTeamDetailVC *VC = [[MyTeamDetailVC alloc] init];
//        VC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController  pushViewController:VC animated:YES];
//    }
     else if  (index == 0) {
        AllOrderManageVC *VC = [AllOrderManageVC new];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
     else if  (index == 1) {
         AllOrderManageVC *VC = [AllOrderManageVC new];
         VC.hidesBottomBarWhenPushed = YES;
         VC.orderTitleType = OffLineTitleType;
         [self.navigationController pushViewController:VC animated:YES];
     }
     else if  (index == 2) {
//         AllOrderManageVC *VC = [AllOrderManageVC new];
//         VC.hidesBottomBarWhenPushed = YES;
//         [self.navigationController pushViewController:VC animated:YES];
         self.tabBarController.selectedIndex = 3;
     }
    else{
        [self.view makeToast:@"该功能暂未开放,请稍后!"];
    }
    
}



#pragma mark - refresh 添加刷新方法
-(void)setRefresh
{
    WEAKSELF;
    [self.tableView headerWithRefreshingBlock:^{
        [weakSelf loadNewDate];
    }];
    
   
    
}

-(void)loadNewDate
{

    [self getUserInfo];
}



-(void)stopRefresh
{
    [self.tableView  endRefreshTableView];
}

@end
