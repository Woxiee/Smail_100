//
//  BaseTableVC.h
//  BangYou
//
//  Created by BangYou on 2017/9/18.
//  Copyright © 2017年 李麒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KX_BaseViewController.h"
@interface BaseTableVC : KX_BaseViewController

/// 主要的table
@property (nonatomic,strong)UITableView *mainTable;
/// 数据源
@property (nonatomic,strong)NSMutableArray *dataSource;
// 第几页的数据
@property (nonatomic,assign)NSInteger page;

@end
