//
//  ParterDetailVC.m
//  Smail_100
//
//  Created by ap on 2018/5/18.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "ParterDetailVC.h"
#import "MySelectTeamView.h"
#import "PaterModel.h"

@interface ParterDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) MySelectTeamView *selectTeamView1;
@property (nonatomic, strong) MySelectTeamView *selectTeamView2;

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong)  UIImageView *iconImageVeiw;




@end

@implementation ParterDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setup];
    [self loadData];
//    470
}


- (void)setup{
    WEAKSELF;

    //config
    self.title = [KX_UserInfo sharedKX_UserInfo].agent_level.integerValue == 2? @"代理人信息":@"合伙人信息";
    //config
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 475/2)];
    
    _headView.backgroundColor = BACKGROUNDNOMAL_COLOR;
//    [self.view addSubview:_headView];
    
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    iconView.backgroundColor = [UIColor whiteColor];
    
    [_headView addSubview:iconView];

    UIImageView *iconImageVeiw = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 45)/2,8, 44, 44)];
    [iconView addSubview:iconImageVeiw];
    _iconImageVeiw = iconImageVeiw;
    [_iconImageVeiw layerForViewWith:22 AndLineWidth:0];
    
    UILabel *namelb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconImageVeiw.frame)+5, SCREEN_WIDTH, 15)];
    namelb.text = @"册数";
    namelb.textAlignment = NSTextAlignmentCenter;
    namelb.font = Font13;
    [iconView addSubview:namelb];

    
    MySelectTeamView *selectTeamView1 = [[MySelectTeamView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconView.frame)+5, SCREEN_WIDTH,75) titleArray:@[@"0",@"0",@"0"] andContenArr:@[@"总推荐人数",@"总激活创客",@"团队总业绩(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                                "]];
    selectTeamView1.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:selectTeamView1];
    self.selectTeamView1 = selectTeamView1;
    
    
    MySelectTeamView *selectTeamView2 = [[MySelectTeamView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(selectTeamView1.frame)+5, SCREEN_WIDTH,75) titleArray:@[@"0",@"0",@"0"] andContenArr:@[@"商家数",@"今日商家营业额(元)",@"商家总营业额((元)                                                                                                                                                                                                                                                                                                                                                                                                                                                                "]];
    selectTeamView2.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:selectTeamView2];
    self.selectTeamView2 = selectTeamView2;
    
    
    self.mainTable.tableHeaderView = _headView;
//    self.mainTable.sd_layout.topSpaceToView(self.view,470/2);
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.rowHeight = 45.0f;
    
    
    _titleArr = @[@"级        别:",@"账        号:",@"姓        名:",@"身份证号:",@"联系手机:",@"电子邮箱:",@"创建时间:",@"账户状态:",];
    
}



- (void)loadData {
    
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
 

    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];

    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/group/agentInfo" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            PaterModel *model = [PaterModel yy_modelWithJSON:result[@"data"][@"info"]];
//            model.count = [Count yy_modelWithJSON:result[@"data"][@"count"]];
            NSDictionary *countDic = result[@"data"][@"count"];
            _selectTeamView1.dataList = @[countDic[@"agent"][@"reg"],countDic[@"agent"][@"pay"],countDic[@"agent"][@"money"]];
            
            _selectTeamView2.dataList = @[countDic[@"shop"][@"count"],countDic[@"shop"][@"today_money"],countDic[@"shop"][@"money"]];

            NSString *leveStr = [KX_UserInfo sharedKX_UserInfo].agent_level.integerValue == 2?@"代理人":@"合伙人";
            NSString *statusStr = @"";
       
            if ([KX_UserInfo sharedKX_UserInfo].agent_level.integerValue == 2) {
                if (model.maker_level.integerValue == 1) {
                    statusStr = @"激活";
                }
            }else{
                
                if ([model.status isEqualToString:@"Enabled"]) {
                    statusStr = @"冻结";
                }
                else{
                   statusStr = @"正常";
                    
                    
                }
            }
            
            NSArray *detailArr = @[leveStr,model.mobile,model.realname,model.idcard,model.mobile,model.emall,model.ctime,statusStr];
            [weakSelf.resorceArray addObjectsFromArray:detailArr];
            
            
            [_iconImageVeiw sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW]];

//            weakSelf.resorceArray addObject:
//            NSArray *dataList = [NSArray yy_modelArrayWithClass:[MyteamListModel class] json:result[@"data"][@"list"]];
//
//            NSDictionary *contenDic = result[@"data"][@"count"][@"agent"];
//            //            [self setUI];
//            NSArray *titleArr = @[contenDic[@"reg"],contenDic[@"money"]];
//            self.headView.selectTeamView.dataList = titleArr;
//            self.headView.seachTF.placeholder = [KX_UserInfo sharedKX_UserInfo].agent_level.integerValue == 2?@"代理人账号":@"合伙人账号";
//            if (weakSelf.page == 1) {
//                [weakSelf.resorceArray removeAllObjects];
//            }
//            [weakSelf.resorceArray addObjectsFromArray:dataList];
            [weakSelf.mainTable reloadData];
            
            
        }
        
    }];
}




#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
 }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.resorceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ParterListCell *cell = [tableView dequeueReusableCellWithIdentifier:[ParterListCell cellID] forIndexPath:indexPath];
//    
//    MyteamListModel *model = [self.resorceArray objectAtIndex:indexPath.section];
//    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
//    cell.model = model;
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = _titleArr [indexPath.row];
    cell.textLabel.font =  Font14;
    cell.textLabel.textColor =  TITLETEXTLOWCOLOR;

    cell.detailTextLabel.text = self.resorceArray[indexPath.row];
    cell.detailTextLabel.font =  Font14;
    cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.textColor = TITLETEXTLOWCOLOR;
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
//    MyteamListModel *model = self.resorceArray[indexPath.section];
//    ParterDetailVC *VC = [[ParterDetailVC alloc] init];
//    [self.navigationController  pushViewController:VC animated:YES];
    
    
    //
    //    MyTeamListVC *VC = [[MyTeamListVC alloc] init];
    //    VC.group_user_id = model.user_id;
    //    VC.teamType = OtherTeamListType;
    //
    //    [VC requestListNetWork];
    //
    
}


@end
