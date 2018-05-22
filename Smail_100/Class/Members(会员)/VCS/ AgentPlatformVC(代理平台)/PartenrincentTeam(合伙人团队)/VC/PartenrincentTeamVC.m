//
//  PartenrincentTeamVC.m
//  Smail_100
//
//  Created by ap on 2018/5/18.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "PartenrincentTeamVC.h"
#import "SearchHeadView.h"
#import "ParterListCell.h"
#import "MyTeamListCell.h"
#import "MyteamListModel.h"

@interface PartenrincentTeamVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)   SearchHeadView *headView;
@property (nonatomic, strong)   NSString  *searchText;

@end

@implementation PartenrincentTeamVC
static NSString * const myTeamListCellID = @"MyTeamListCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadData];
}

- (void)setup{
    _searchText = @"";
    //config
    WEAKSELF;
    _headView = [[SearchHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 392.0/2) withType:@"1"];
    _headView.didClickSearchBlock = ^(NSString *searhText) {
        weakSelf.searchText = searhText;
        [weakSelf loadData];
    };
    [self.view addSubview:_headView];
    self.mainTable.sd_layout.topSpaceToView(self.view, 392.0/2);
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.rowHeight = 110;
    [self.mainTable registerNib:[UINib nibWithNibName:@"MyTeamListCell" bundle:nil] forCellReuseIdentifier:myTeamListCellID];

    [self setRefresh];
//    [self.mainTable headerWithRefreshingBlock:^{
//        weakSelf.page = 1;
//        [weakSelf loadData];
//    }];
//    [self.mainTable footerWithRefreshingBlock:^{
//        weakSelf.page++;
//        [weakSelf loadData];
//    }];
}



- (void)loadData {
    
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
 
    [param setObject:@(self.page) forKey:@"pageno"];
    [param setObject:@"10" forKey:@"page_size"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"group_user_id"];
    [param setObject:_searchText forKey:@"search_mobile"];
    [param setObject:@"2" forKey:@"level"];

 
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/group/agentList" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            
            NSArray *dataList = [NSArray yy_modelArrayWithClass:[MyteamListModel class] json:result[@"data"][@"list"]];
            for (MyteamListModel *model in dataList) {
                model.mobile = [NSString stringWithFormat:@"账号：%@",model.mobile];
            }
            
            NSDictionary *contenDic = result[@"data"][@"count"][@"agent"];
            //            [self setUI];
            NSArray *titleArr = @[contenDic[@"reg"],contenDic[@"pay"],contenDic[@"money"]];
            self.headView.selectTeamView.dataList = titleArr;
            
            if (weakSelf.page == 1) {
                [weakSelf.dataSource removeAllObjects];
            }
            [weakSelf.dataSource addObjectsFromArray:dataList];
            [weakSelf.mainTable reloadData];
            
            
        }
        [weakSelf stopRefresh];
        
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTeamListCell *cell = [tableView dequeueReusableCellWithIdentifier:myTeamListCellID];
    if (cell == nil) {
        cell = [[MyTeamListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myTeamListCellID];
    }
    MyteamListModel *model = self.dataSource[indexPath.section];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
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
    [self.mainTable stopFresh:self.dataSource.count pageIndex:self.page];
    if (self.dataSource.count == 0) {
        [self.mainTable addSubview:[KX_LoginHintView notDataView]];
    }else{
        [KX_LoginHintView removeFromSupView:self.mainTable];
    }
    
}



@end
