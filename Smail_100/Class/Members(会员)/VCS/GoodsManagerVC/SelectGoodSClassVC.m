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
static NSString* cellID = @"ManagementCellID";

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


- (void)deleteAGoods:(ChildModel *)model
{
    WEAKSELF;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[KX_UserInfo sharedKX_UserInfo].user_id,@"user_id",model.id, @"sub_category_id" ,nil];
    
    [BaseHttpRequest postWithUrl:@"/shop/delete_sub_category" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单列表 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            [weakSelf getRequestData];
            [weakSelf.view makeToast:msg];

        }else{
            [weakSelf.view makeToast:msg];

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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectGoodsClassCell" bundle:nil] forCellReuseIdentifier:cellID];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, 50);
//    [btn setTitle:@"发布商品" forState:UIControlStateNormal];
    btn.backgroundColor = MainColor;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBottomAction) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = Font15;
    [self.view addSubview:btn];
    
    self.title = _isManage?@"商品分类":@"选择分类";
    [btn setTitle:_isManage?@"添加分类":@"确定" forState:UIControlStateNormal];

//    btn.hidden = _isManage;
}

- (void)setConfiguration
{
    
}
-(NSArray *)createRightButtons:(ChildModel *)goods
{
    NSMutableArray * result = [NSMutableArray array];
    WS(b_self);
    //删除
    MGSwipeButton * deleteBtn = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor]callback:^BOOL(MGSwipeTableCell *sender) {
        
        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"确认删除分类吗?" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [b_self deleteAGoods:goods];
            }
        }];
        [successV showSuccess]; 
        return  NO;
    }];
    
//    //添加到收藏
//    MGSwipeButton * storeBtn = [MGSwipeButton buttonWithTitle:@"移入收藏" backgroundColor:[UIColor lightGrayColor]callback:^BOOL(MGSwipeTableCell *sender) {
//        [carVM collectShopCarGoods:goods state:@"1" handleback:^(NSInteger code) {
//            if (code == 0) {
//                [b_self.view makeToast:@"收藏成功!"];
//            }
//            [shopCarGoodsList reloadData];
//        }]; return  NO;
//    }];
    [result addObject:deleteBtn];
//    [result addObject:storeBtn];
    return result;
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
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
//
//    }
    
    
    SelectGoodsClassCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
   ChildModel *model = self.resorceArray[indexPath.row];
    if (_isManage) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.rightButtons = [self createRightButtons:model];
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
        for (ChildModel *model in self.resorceArray) {
            model.isSelect = NO;
        }
        ChildModel *model = self.resorceArray[indexPath.row];
        //    MeChantOrderModel *model = self.resorceArray[indexPath.section];
        model.isSelect =YES;
        
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
    if (_isManage) {
        AddGoodsMuenVC *vc = [[AddGoodsMuenVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
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
        [self.view makeToast:@"至少选择一种分类"];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
