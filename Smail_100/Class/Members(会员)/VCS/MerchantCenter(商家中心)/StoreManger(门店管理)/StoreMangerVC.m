//
//  StoreMangerVC.m
//  Smile_100
//
//  Created by ap on 2018/2/27.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "StoreMangerVC.h"
#import "StoreMangerVHeadView.h"
#import "KX_ApprovalMessgaCell.h"

@interface StoreMangerVC ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) StoreMangerVHeadView *headView;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation StoreMangerVC
static NSString * const ContentCellID = @"ContentCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}


- (void)setup
{
    [self.view addSubview:self.tableView];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = BACKGROUNDNOMAL_COLOR;
    self.tableView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    [self.tableView registerNib:[UINib nibWithNibName:@"KX_ApprovalMessgaCell" bundle:nil] forCellReuseIdentifier:ContentCellID];

    [self.resorceArray addObject:@"店铺名称:"];
    [self.resorceArray addObject:@"店铺介绍:"];
    [self.resorceArray addObject:@"店铺电话:"];
    [self.resorceArray addObject:@"营业时间:"];
    [self.resorceArray addObject:@"主营业务:"];
    [self.resorceArray addObject:@"店铺地址:"];
    [self.resorceArray addObject:@"详情地址:"];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT - 50 - 64, SCREEN_WIDTH, 50);
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    btn.backgroundColor = MainColor;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBottomAction) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = Font15;
    [self.view addSubview:btn];
    
    

    _headView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([StoreMangerVHeadView class]) owner:nil options:nil].lastObject;
    _headView.didClickStoreMangerBlock = ^(NSInteger index) {
        if (index == 0) {
            /// 照片
        }
        else{
            /// 拍摄
        }
    };
    self.tableView.tableHeaderView = _headView;

}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.resorceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KX_ApprovalMessgaCell *cell = [tableView dequeueReusableCellWithIdentifier:ContentCellID
                                                                  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.contenTextView.text = self.resorceArray[indexPath.row];
    cell.titleLabel.text = self.resorceArray[indexPath.row];
    cell.contenTextView.myPlaceholder = @"请输入15字内店铺名称";
    cell.contenTextView.delegate = self;
    cell.contenTextView.scrollEnabled = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    MyTeamDetailVC *VC = [[MyTeamDetailVC alloc] init];
    //    [self.navigationController  pushViewController:VC animated:YES];
}


#pragma mark - set懒加载
/*懒加载*/
-(UITableView *)tableView
{
    if (!_tableView) {
        //初始化数据
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 50) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];//默认设置为空
//        [_tableView setSeparatorInset:UIEdgeInsetsZero];//默认设置下划线左边移动 15.0f
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUND_COLOR;
    }
    return _tableView;
}

- (void)didClickBottomAction
{
    
}
@end
