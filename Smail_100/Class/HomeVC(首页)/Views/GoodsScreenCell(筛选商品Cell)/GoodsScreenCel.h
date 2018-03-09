//
//  GoodsScreenCel.h
//  MyCityProject
//
//  Created by Faker on 17/5/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsScreenListModel.h"
#import "HistoryModel.h"

typedef NS_ENUM(NSInteger,  GoodsScreenCellType){
    GoodsScreenCellNomalType,           /// 正常显示
    GoodsScreenCellCollectType,           /// 采集
    GoodsScreenCellAuctionType,           /// 拍卖
    GoodsScreenCellWholeType,           ///  整机流转 &   共享
    GoodsScreenCellDetectionType,       ///  检测吊运
    GoodsScreenCellOtherType,           /// 其他显示
};

@interface GoodsScreenCel : UITableViewCell

@property (nonatomic, strong) GoodsScreenListModel *model;
@property (nonatomic, strong) GoodsScreenListModel *collectModel;  ///收藏所用Model

@property (nonatomic, assign) GoodsScreenCellType  cellShowType;

@property (nonatomic, assign) BOOL isCollect; /// 是否是收藏

@property (nonatomic, strong) HistoryModel *historyModel;
@end
