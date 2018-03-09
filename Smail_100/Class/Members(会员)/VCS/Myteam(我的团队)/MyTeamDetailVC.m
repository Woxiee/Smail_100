//
//  MyTeamDetailVC.m
//  Smile_100
//
//  Created by ap on 2018/2/24.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MyTeamDetailVC.h"
#import "SDCycleScrollView.h"
#import "MySelectTeamView.h"
#import "MyRecommendCell.h"
#import "MyTeamPersenView.h"
#import "MyteamVC.h"

@interface MyTeamDetailVC ()<SDCycleScrollViewDelegate>
//@property (weak, nonatomic)  UIView *headView;
@property (weak, nonatomic)   SDCycleScrollView *cycleView;
@property (weak, nonatomic)   MySelectTeamView *selectTeamView;
@property (weak, nonatomic)   MyTeamPersenView *teamPersenView;


@end

static NSString *myRecommendCellID = @"MyRecommendCellID";

@implementation MyTeamDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.resorceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *title = self.resorceArray[indexPath.section];
    if ([title isEqualToString:@"推荐用户"]) {
        return 85;
    }
    
    return 44;
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
    NSString *title = self.resorceArray[indexPath.section];
    if ([title isEqualToString:@"推荐用户"]) {
        MyRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:myRecommendCellID];
        if (cell == nil) {
            cell = [[MyRecommendCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myRecommendCellID];
        }
        return cell;
    }
    NSArray *imageList  =  @[@"wodetuandui4@3x.png",@"wodetuandui4@3x.png",@"wodetuandui5@3x.png"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"indefiiecell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"indefiiecell"];
    }
    cell.imageView.image = [UIImage imageNamed:imageList[indexPath.section]];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text =  self.resorceArray[indexPath.section];
    cell.textLabel.font = Font14;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyteamVC *VC = [[MyteamVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];

}


/// 初始化视图
- (void)setup
{
    self.title = @"我的团队"; 
    // 设置导航栏默认的背景颜色
    self.view.backgroundColor = BACKGROUNDNOMAL_COLOR;
    self.tableView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyRecommendCell" bundle:nil] forCellReuseIdentifier:myRecommendCellID];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) delegate:self placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    [headView addSubview:cycleView];
    self.cycleView = cycleView;
    
    MySelectTeamView *selectTeamView = [[MySelectTeamView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cycleView.frame), SCREEN_WIDTH, 80) titleArray:@[@"88",@"49",@"8888"]];
    [headView addSubview:selectTeamView];
    self.selectTeamView = selectTeamView;
    
    MyTeamPersenView *teamPersenView = [[MyTeamPersenView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(selectTeamView.frame), SCREEN_WIDTH, 60)];
    [headView addSubview:teamPersenView];
    self.teamPersenView = teamPersenView;
    self.tableView.tableHeaderView = headView;
    
    [self.resorceArray addObject:@"推荐用户"];
    [self.resorceArray addObject:@"我的团队"];
    [self.resorceArray addObject:@"我的推广"];

    [self.tableView reloadData];

}



#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    LOG(@"点击了第%ld张图片",(long)index);
    
}




@end
