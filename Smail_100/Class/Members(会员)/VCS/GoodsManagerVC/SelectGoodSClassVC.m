//
//  SelectGoodSClassVC.m
//  Smail_100
//
//  Created by ap on 2018/3/20.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SelectGoodSClassVC.h"
#import "SelectGoodsClassCell.h"
#import "GoodSDetailModel.h"
#import "ChildModel.h"
#import "AddGoodsMuenVC.h"

@interface SelectGoodSClassVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation SelectGoodSClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
}

#pragma mark - request
- (void)getRequestData
{
    WEAKSELF;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[KX_UserInfo sharedKX_UserInfo].user_id,@"user_id", nil];

    [BaseHttpRequest postWithUrl:@"/shop/sub_category" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单列表 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            NSArray *dataArr = [result valueForKey:@"data"];
            NSArray *listArray  = [[NSArray alloc] init];
            if ([dataArr isKindOfClass:[NSArray class]]) {
                if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                    listArray = [ChildModel mj_objectArrayWithKeyValuesArray:dataArr];
                    [weakSelf.resorceArray removeAllObjects];
                    [weakSelf.resorceArray addObjectsFromArray:listArray];
                    [weakSelf.tableView reloadData];
//                                        [weakSelf setRefreshs];
                }
            }
        }else{
            [weakSelf showHint:msg];
            
        }
        
        
    }];
    
}

 - (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getRequestData];
  
}

#pragma mark - private
- (void)setup
{
    [self.view addSubview:self.tableView];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, 50);
    [btn setTitle:@"发布商品" forState:UIControlStateNormal];
    btn.backgroundColor = MainColor;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBottomAction) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = Font15;
    [self.view addSubview:btn];
    
    self.title = _isManage?@"管理分类":@"";
    btn.hidden = _isManage;
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
    WEAKSELF;
    static NSString* cellID = @"ManagementCellID";
    SelectGoodsClassCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell ) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SelectGoodsClassCell" owner:nil options:nil]lastObject];
    }
   ChildModel *model = self.resorceArray[indexPath.row];
//    MeChantOrderModel *model = self.resorceArray[indexPath.section];
    if (_isManage) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    }
    cell.model = model;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_isManage) {
        AddGoodsMuenVC *vc = [[AddGoodsMuenVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        ChildModel *model = self.resorceArray[indexPath.row];
        //    MeChantOrderModel *model = self.resorceArray[indexPath.section];
        model.isSelect =! model.isSelect;
        
        [self.tableView reloadData];
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
    NSMutableArray *selectList = [[NSMutableArray alloc] init];
    for ( ChildModel *model  in self.resorceArray) {
        if (model.isSelect) {
            [selectList addObject:model];
        }
    }
    if (_didClickCompleBlock) {
        _didClickCompleBlock(selectList);
    }
    if (selectList.count == 0) {
        [self.view toastShow:@"至少选择一种分类"];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
