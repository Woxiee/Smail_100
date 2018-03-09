//
//  MyTeamListVC.m
//  Smile_100
//
//  Created by Faker on 2018/2/21.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MyTeamListVC.h"
#import "MySelectTeamView.h"
#import "MyTeamListCell.h"

@interface MyTeamListVC ()
@property(nonatomic,assign)NSUInteger page;

@end

@implementation MyTeamListVC
static NSString * const myTeamListCellID = @"MyTeamListCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
    [self setRefresh];
    
}


- (void)requestListNetWork
{
    WEAKSELF;
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:[KX_UserInfo sharedKX_UserInfo].ID,@"mid", nil];
    //    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    
//    [HistoryVModel getHistoryListParam:param successBlock:^(NSArray<HistoryModel *> *dataArray, BOOL isSuccess) {
//        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//        if (isSuccess) {
//            if (weakSelf.resorceArray.count >0) {
//                [weakSelf.resorceArray removeAllObjects];
//            }
//            [self.resorceArray addObjectsFromArray:dataArray];
//            [weakSelf.tableView reloadData];
//        }
//        [weakSelf stopRefresh];
//
//    }];
}



#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     return 86;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
  
    return 10;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    headView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    return headView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTeamListCell *cell = [tableView dequeueReusableCellWithIdentifier:myTeamListCellID];
    if (cell == nil) {
        cell = [[MyTeamListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myTeamListCellID];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    MyTeamDetailVC *VC = [[MyTeamDetailVC alloc] init];
//    [self.navigationController  pushViewController:VC animated:YES];
}



- (void)setup
{
    MySelectTeamView *headView = [[MySelectTeamView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80) titleArray:@[@"88",@"49",@"8888"]];
    self.tableView.tableHeaderView = headView;
}

/// 配置基础设置
- (void)setConfiguration
{
    self.title = @"我的团队";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyTeamListCell" bundle:nil] forCellReuseIdentifier:myTeamListCellID];
    self.view.backgroundColor = BACKGROUNDNOMAL_COLOR;
    self.tableView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    
}


#pragma mark - refresh 添加刷新方法
-(void)setRefresh
{
    WEAKSELF;
    [self.tableView headerWithRefreshingBlock:^{
        [weakSelf loadNewDate];
    }];
    
    [self.tableView footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}

-(void)loadNewDate
{
    self.page = 0;
    [self requestListNetWork];
}

-(void)loadMoreData{
    
    self.page++;
    [self requestListNetWork];
}


@end
