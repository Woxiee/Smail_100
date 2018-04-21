//
//  GoodManageVC.m
//  Smail_100
//
//  Created by ap on 2018/3/21.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "GoodManageVC.h"
#import "ChildModel.h"
#import "StoreMangerVC.h"
#import "GoodsManagerVC.h"
#import "SelectGoodSClassVC.h"
#import "AddOrEidtGoodVC.h"


@interface GoodManageVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation GoodManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
    
}


#pragma mark - request


#pragma mark - private
- (void)setup
{
    self.title  = @"商品管理";
    
    [self.view addSubview:self.tableView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, 50);
    [btn setTitle:@"发布商品" forState:UIControlStateNormal];
    btn.backgroundColor = MainColor;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBottomAction) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = Font15;
    [self.view addSubview:btn];
    
    [self.resorceArray addObject:@"分类管理"];
    [self.resorceArray addObject:@"商品管理"];
    [self.tableView reloadData];

}

- (void)setConfiguration
{
    
}

#pragma mark - publice


#pragma mark - set & get



#pragma mark - delegate
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resorceArray.count;
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString* cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell ) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"shangjiazhongxin9@3x.png"];

    }else{
        cell.imageView.image = [UIImage imageNamed:@"shangjiazhongxin10@3x.png"];

    }
    cell.textLabel.text = self.resorceArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        SelectGoodSClassVC *vc = [[SelectGoodSClassVC alloc] init];
        vc.isManage = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        GoodsManagerVC *vc = [[GoodsManagerVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    
}


#pragma mark - set懒加载
/*懒加载*/
-(UITableView *)tableView
{
    if (!_tableView) {
        //初始化数据
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 50) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];//默认设置为空
        [_tableView setSeparatorInset:UIEdgeInsetsZero];//默认设置下划线左边移动 15.0f
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        
        _tableView.backgroundColor = BACKGROUND_COLOR;
    }
    return _tableView;
}


/// 确认选择
- (void)didClickBottomAction
{
    AddOrEidtGoodVC *vc = [[AddOrEidtGoodVC alloc] init];
    vc.title = @"发布商品";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
