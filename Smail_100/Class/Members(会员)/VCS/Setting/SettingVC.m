//
//  SettingVC.m
//  MyCityProject
//
//  Created by mac_KY on 17/5/22.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "SettingVC.h"
#import "KYOlderPhoneVC.h"
#import "LoginVC.h"





@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *sourceData;
/** <#des#> */
@property(nonatomic,strong)NSArray *contentVCs;
@property (nonatomic, strong) UIButton *outLoginBtn;
@end

@implementation SettingVC

#pragma mark - set懒加载
/*懒加载*/
-(UITableView *)tableView
{
    if (!_tableView) {
        //初始化数据
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44 ) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];//默认设置为空
        //[_tableView setSeparatorInset:UIEdgeInsetsZero];//默认设置下划线左边移动 15.0f
        [_tableView setSeparatorColor:BACKGROUNDNOMAL_COLOR];
        _tableView.backgroundColor = BACKGROUNDNOMAL_COLOR ;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
/*懒加载*/
-(NSMutableArray *)sourceData
{
    if (!_sourceData) {
        //初始化数据
        _sourceData = [NSMutableArray array];
    }
    return _sourceData;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadComment];
    [self loadSubView];
    [self loadData];
}

#pragma mark - 设置子常数
-(void)loadComment
{
    self.title = @"设置";
    self.view.backgroundColor  = BACKGROUNDNOMAL_COLOR;
//    [self.sourceData addObjectsFromArray:@[@[@"账户管理"],@[@"修改密码",@"修改手机号"],@[@"关于我们",@"投诉及意见反馈"]]];
    
    [self.sourceData addObjectsFromArray:@[@[@"账户管理"],@[@"修改密码"],@[@"关于我们",@"投诉及意见反馈"]]];

    if ([KX_UserInfo sharedKX_UserInfo].isMembers) {
//        _contentVCs = @[@[@"MemberInforVC"],@[@"ResetPassWord",@"KYOlderPhoneVC"],@[@"AboutVC",@"AddSuggestionVC"]];
        _contentVCs = @[@[@"MemberInforVC"],@[@"ResetPassWord"],@[@"AboutVC",@"AddSuggestionVC"]];

    }
    else{
        _contentVCs = @[@[@"MemberBaseInfoVC"],@[@"ResetPassWord"],@[@"AboutVC",@"AddSuggestionVC"]];
//        _contentVCs = @[@[@"MemberBaseInfoVC"],@[@"ResetPassWord",@"KYOlderPhoneVC"],@[@"AboutVC",@"AddSuggestionVC"]];

    }
}

#pragma mark - 设置子View
-(void)loadSubView
{
    [self.view addSubview:self.tableView];
    _outLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _outLoginBtn.frame = CGRectMake(12, SCREEN_HEIGHT - 64- 50 - 44, SCREEN_WIDTH - 24, 44);
    [_outLoginBtn layerForViewWith:2 AndLineWidth:0];
    [_outLoginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [_outLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _outLoginBtn.titleLabel.font = CONTENFONT;
    _outLoginBtn.backgroundColor = BACKGROUND_COLORHL;
    [_outLoginBtn addTarget:self action:@selector(didClickOutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_outLoginBtn];
}

#pragma mark - 得到网络数据
-(void)loadData
{
    
}
#pragma mark - 点击方法

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.sourceData objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return self.sourceData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString *cellID = @"SettingIDID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = DETAILTEXTCOLOR;
        cell.textLabel.font = CONTENFONT;
    }
    cell.textLabel.text = self.sourceData[indexPath.section][indexPath.row];
    return cell;
 
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NSString *vcString = _contentVCs[indexPath.section][indexPath.row];
    UIViewController *VC = [NSClassFromString(vcString) new];
    VC.view.backgroundColor = BACKGROUND_COLOR;
//    VC.title  = self.sourceData[indexPath.section][indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    return 44;
}

 - (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - public 共有方法

- (void)didClickOutAction
{
    //清除本地数据 返回登陆页面
    [[KX_UserInfo sharedKX_UserInfo] cleanUserInfoToSanbox];
    [KX_UserInfo presentToLoginView:self];
    [self.navigationController popToRootViewControllerAnimated:YES];

}

@end
