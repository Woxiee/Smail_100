//
//  ParterListVC.m
//  Smail_100
//
//  Created by 家朋 on 2018/5/16.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "ParterListVC.h"
#import "ParterListCell.h"
#import "SearchHeadView.h"
#import "MyteamListModel.h"
#import "ParterDetailVC.h"

@interface ParterListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)   SearchHeadView *headView;
@property (nonatomic, strong)   NSString  *searchText;
@end

@implementation ParterListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setup];
    [self loadData];
}

- (void)setup{
    //config
    self.title = @"合伙人列表";
    _searchText = @"";
    //config
    WEAKSELF;
    _headView = [[SearchHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 392.0/2) withType:[KX_UserInfo sharedKX_UserInfo].agent_level];
    _headView.didClickSearchBlock = ^(NSString *searhText) {
        weakSelf.searchText = searhText;
        [weakSelf loadData];
    };
    [self.view addSubview:_headView];
    self.mainTable.sd_layout.topSpaceToView(self.view, 392.0/2);
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.rowHeight = 95.0f;
  
    [self.mainTable registerClass:[ParterListCell class] forCellReuseIdentifier:[ParterListCell cellID]];
    [self setRefresh];

}


- (void)loadData {
    
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (self.page == 0) {
        self.page = 1;
    }
    [param setObject:@(self.page) forKey:@"pageno"];
    [param setObject:@"10" forKey:@"page_size"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"group_user_id"];
    [param setObject:_searchText forKey:@"search_mobile"];
    [param setObject:@"3" forKey:@"level"];
    
    
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/group/agentList" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            
            NSArray *dataList = [NSArray yy_modelArrayWithClass:[MyteamListModel class] json:result[@"data"][@"list"]];
            
            NSDictionary *contenDic = result[@"data"][@"count"][@"agent"];
            //            [self setUI];
            NSArray *titleArr = @[contenDic[@"reg"],contenDic[@"money"]];
            self.headView.selectTeamView.dataList = titleArr;
            self.headView.seachTF.placeholder = @"合伙人账号";
            if (weakSelf.page == 1) {
                [weakSelf.resorceArray removeAllObjects];
            }
            [weakSelf.resorceArray addObjectsFromArray:dataList];
            [weakSelf.mainTable reloadData];
         
            
        }
        [weakSelf stopRefresh];
        
    }];
}




#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.resorceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParterListCell *cell = [tableView dequeueReusableCellWithIdentifier:[ParterListCell cellID] forIndexPath:indexPath];
    
    MyteamListModel *model = [self.resorceArray objectAtIndex:indexPath.section];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.model = model;
//   cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    
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
     MyteamListModel *model = self.resorceArray[indexPath.section];
    ParterDetailVC *VC = [[ParterDetailVC alloc] init];
    [self.navigationController  pushViewController:VC animated:YES];
    
    
//
//    MyTeamListVC *VC = [[MyTeamListVC alloc] init];
//    VC.group_user_id = model.user_id;
//    VC.teamType = OtherTeamListType;
//
//    [VC requestListNetWork];
//
    
}


#pragma mark - refresh 添加刷新方法
-(void)setRefresh
{
    WEAKSELF;
    [self.mainTable headerWithRefreshingBlock:^{
        [weakSelf loadNewDate];
    }];
    
    [self.mainTable footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}

-(void)loadNewDate
{
    self.page = 1;
    [self loadData];
}

-(void)loadMoreData{
    
    self.page++;
    [self loadData];
}

-(void)stopRefresh
{
    [self.mainTable stopFresh:self.resorceArray.count pageIndex:self.page];
    if (self.resorceArray.count == 0) {
        [self.mainTable addSubview:[KX_LoginHintView notDataView]];
    }else{
        [KX_LoginHintView removeFromSupView:self.mainTable];
    }
    
}

@end
