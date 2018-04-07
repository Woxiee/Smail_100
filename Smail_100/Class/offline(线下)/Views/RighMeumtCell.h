//
//  RighMeumtCell.h
//  Smail_100
//
//  Created by ap on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "OrderGoodsModel.h"
@interface RighMeumtCell : UITableViewCell
@property(nonatomic,strong) void(^cellAdd)(OrderGoodsModel *model);
@property(nonatomic,strong) void(^cellReduce)(OrderGoodsModel *model);
@property(nonatomic,strong) void(^cellInputText)(OrderGoodsModel *model);

@property (nonatomic, strong) OrderGoodsModel *model;

@end
