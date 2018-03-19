//
//  MeunLineOffVC.m
//  Smail_100
//
//  Created by ap on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "MeunLineOffVC.h"
#import "GoodsCategoryCell.h"
#import "RighMeumtCell.h"

@interface MeunLineOffVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (nonatomic, strong) NSMutableArray *titleArr;

@property (weak, nonatomic) IBOutlet UITableView *rightTableview;

@end

@implementation MeunLineOffVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}


- (void)setUI
{
    self.title = @"查看商家产品";
    
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.backgroundColor = BACKGROUND_COLOR;
    
    _rightTableview.dataSource = self;
    _rightTableview.delegate = self;
    _rightTableview.rowHeight = 44.f;
    _rightTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _rightTableview.backgroundColor = BACKGROUND_COLOR;
    
    [self setRightNaviBtnImage:[UIImage imageNamed:@"moreOne@2x.png"]];

    
}


#pragma mark UITableView  delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _leftTableView) {
        return 60;
    }
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _leftTableView) {
        static NSString *cellID = @"GoodsCategoryCellID";
        GoodsCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCategoryCell" owner:nil options:nil]lastObject];
        }
        
        LeftCategory * model = _titleArr[indexPath.row];
        if (model.select) {
            cell.backgroundColor = [UIColor clearColor];
        }else{
            cell.backgroundColor = BACKGROUNDNOMAL_COLOR;
        }
        cell.model = model;
        
        return cell;
    }
    
    static NSString *cellID = @"GoodsCategoryCellID";
    RighMeumtCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RighMeumtCell" owner:nil options:nil]lastObject];
    }
    
//    LeftCategory * model = _titleArr[indexPath.row];
//    if (model.select) {
//        cell.backgroundColor = [UIColor clearColor];
//    }else{
//        cell.backgroundColor = BACKGROUNDNOMAL_COLOR;
//    }
//    cell.model = model;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
        [KX_UserInfo presentToLoginView:self];
        return;
    }
//    for (LeftCategory * model in _titleArr) {
//        model.select = NO;
//    }
//    LeftCategory * model = _titleArr[indexPath.row];
//    model.select = YES;
//    [tableView reloadData];
//    [self getLeveGoodsRequestIds:model.id];
    
    
}


@end
