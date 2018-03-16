//
//  ChangeSexVC.m
//  ShiShi
//
//  Created by mac_KY on 17/3/3.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "KYBaseCell.h"


#import "ChangeSexVC.h"
#import "KYBaseCell.h"

@interface ChangeSexVC ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *sourceData;

@end

@implementation ChangeSexVC

#pragma mark - set懒加载
/*懒加载*/
-(UITableView *)tableView
{
    if (!_tableView) {
        //初始化数据
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];//默认设置为空
        [_tableView setSeparatorInset:UIEdgeInsetsZero];//默认设置下划线左边移动 15.0f
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
    KYBaseCellItem *item = [KYBaseCellItem itemWithTitle:@"男" selectRightIcom:@"xuanzhe2.png"];
    KYBaseCellItem *item1 = [KYBaseCellItem itemWithTitle:@"女" selectRightIcom:@"xuanzhe2.png"];
    KYBaseCellItem *item2 = [KYBaseCellItem itemWithTitle:@"保密" selectRightIcom:@"xuanzhe2.png"];
    if ([_sex isKindOfClass:[NSString class]]) {
        if (_sex.length == 2) {
            item2.cellSelect = YES;
        }else  if ([_sex isEqualToString:@"男"]) {
            item.cellSelect = YES;
        }else if([_sex isEqualToString:@"女"]){
            item1.cellSelect = YES;
        }
       
    }

    
    [self.sourceData addObjectsFromArray:@[item,item1,item2]];}

#pragma mark - 设置子View
-(void)loadSubView
{
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark - 得到网络数据
-(void)loadData
{
    self.title = @"性别";
}
#pragma mark - 点击方法

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID = @"KYBaseCellID";
    
    KYBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell ) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"KYBaseCell" owner:nil options:nil]lastObject];
    }
    
    cell.baseItem = [self.sourceData objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = RGB(53, 53, 53);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //cellSelect
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.sourceData setValue:@(0) forKey:@"cellSelect"];
    KYBaseCellItem *item = [self.sourceData objectAtIndex:indexPath.row];
    item.cellSelect = YES;
    
    if (_selectDex) {
       
        _selectDex(item.title);
    }
    [tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    return 50;
}


#pragma mark - public 共有方法



@end
