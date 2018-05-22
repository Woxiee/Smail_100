//
//  BaseTableVC.m
//  BangYou
//
//  Created by BangYou on 2017/9/18.
//  Copyright © 2017年 李麒. All rights reserved.
//

#import "BaseTableVC.h"

@interface BaseTableVC ()

@end

@implementation BaseTableVC

- (UITableView *)mainTable {
    
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0) style:UITableViewStylePlain];
        [self.view addSubview:_mainTable];
        _mainTable.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        _mainTable.separatorInset = UIEdgeInsetsZero;
        _mainTable.backgroundColor = BACKGROUNDNOMAL_COLOR;
        
        _mainTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _mainTable.tableFooterView = [UIView new];
    }
    return _mainTable;
}

-(NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}



+ (void)initialize {
    //初始化数据
    
}

- (void)viewDidLoad {
    [super viewDidLoad];


    [self setupBaseTableVC];
 
}

- (void)setupBaseTableVC {
    
    self.page = 1;
    [self mainTable];
    self.view.backgroundColor = BACKGROUNDNOMAL_COLOR;

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (@available(iOS 11.0, *))
    {
        self.mainTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    else
    {
        //self.automaticallyAdjustsScrollViewInsets = NO;
    }

}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];

}


@end
