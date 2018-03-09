//
//  GoodsScreenOutCell.h
//  MyCityProject
//
//  Created by Faker on 17/5/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsScreenListModel.h"
#import "HistoryModel.h"

@interface GoodsScreenOutCell : UITableViewCell
@property (nonatomic, strong) GoodsScreenListModel *model;
@property (nonatomic, strong) GoodsScreenListModel *collectModel;  ///收藏所用Model

@property (nonatomic, assign) BOOL isCollect; /// 是否是收藏
@property (nonatomic, strong) HistoryModel *historyModel;

@end
