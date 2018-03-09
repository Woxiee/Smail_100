//
//  HomeScrollCell.h
//  ShiShi
//
//  Created by ac on 16/3/24.
//  Copyright © 2016年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHeaderImageModel.h"
#import "ColumnModel.h"
@protocol HomePageCycScrollViewDelegate <NSObject>

/** 点击图片回调 */
- (void)didSelectCycleScrollViewItemAtIndex:(NSInteger)index;

@end

@interface HomeScrollCell : UICollectionViewCell


@property (nonatomic, strong) ColumnModel *model;
@property(nonatomic,strong) NSMutableArray * modelArray;             ///轮播图数据源

@property(nonatomic,strong) NSMutableArray * newsList;             //公告数据源

@property (nonatomic, strong)  NSMutableArray *homePageCellData;    ///轮播图下面的collection 数据源

@property (nonatomic, weak) id<HomePageCycScrollViewDelegate>delegate;
@end
