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
#import "MyteamListModel.h"

@interface MyTeamListVC ()
@property(nonatomic,assign)NSUInteger page;


@property (nonatomic, strong)   MySelectTeamView *headView;
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
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_group_user_id?_group_user_id:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_group_user_id?_group_user_id:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"group_user_id"];
    if (_teamType == FirstTeamListType) {
        [param setObject:@"1" forKey:@"level"];
    }
    else if (_teamType == SecondTeamListType) {
        [param setObject:@"2" forKey:@"level"];
    }else if (_teamType == ThreeTeamListType){
        [param setObject:@"3" forKey:@"level"];
    }
    else{
        
    }
    if (_page == 0) {
        _page = 1;
    }
    [param setObject:@(_page) forKey:@"pageno"];
    [param setObject:@"10" forKey:@"page_size"];
    
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/group/groupList" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            
            NSArray *dataList = [NSArray yy_modelArrayWithClass:[MyteamListModel class] json:result[@"data"][@"list"]];
            
            NSDictionary *contenDic = result[@"data"][@"count"][@"reg_info"];
            //            [self setUI];
            NSArray *titleArr = @[contenDic[@"reg"],contenDic[@"pay"],contenDic[@"money"]];
//            self.selectTeamView.dataList = dataList;
            _headView.dataList = titleArr;
            if (weakSelf.page == 1) {
                [weakSelf.resorceArray removeAllObjects];
            }
            [weakSelf.resorceArray addObjectsFromArray:dataList];
            [weakSelf.tableView reloadData];
            
            
        }
        [weakSelf stopRefresh];

    }];
}



#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.resorceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     return 110;
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
    MyteamListModel *model = self.resorceArray[indexPath.section];
    cell.model = model;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyteamListModel *model = self.resorceArray[indexPath.section];

    MyTeamListVC *VC = [[MyTeamListVC alloc] init];
    VC.group_user_id = model.user_id;
    VC.teamType = OtherTeamListType;
    
    [VC requestListNetWork];
    [self.superVC.navigationController  pushViewController:VC animated:YES];
    

}



- (void)setup
{
    NSArray *titleArr = @[@"推荐人数",@"激活创客",@"I团队业绩(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                          "];
    if (_teamType == FirstTeamListType) {
        titleArr = @[@"推荐人数",@"激活创客",@"I团队业绩(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                          "];
    }
    else if (_teamType == SecondTeamListType) {
        titleArr = @[@"推荐人数",@"激活创客",@"II团队业绩(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                          "];
    }else{
        titleArr = @[@"推荐人数",@"激活创客",@"III团队业绩(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                          "];
    }
    
    MySelectTeamView *headView = [[MySelectTeamView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90) titleArray:@[@"88",@"49",@"8888"] andContenArr:titleArr];
    
    self.tableView.tableHeaderView = headView;
    _headView = headView;
}

/// 配置基础设置
- (void)setConfiguration
{
    _page = 1;
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

-(void)stopRefresh
{
    [self.tableView stopFresh:self.resorceArray.count pageIndex:self.page];
    if (self.resorceArray.count == 0) {
        [self.tableView addSubview:[KX_LoginHintView notDataView]];
    }else{
        [KX_LoginHintView removeFromSupView:self.tableView];
    }
    
}

@end
