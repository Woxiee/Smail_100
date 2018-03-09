//
//  ShopCarGoodsCell.h
//  ShiShi
//
//  Created by ac on 16/3/28.
//  Copyright © 2016年 fec. All rights reserved.
//

#import "MGSwipeTableCell.h"
#import "OrderGoodsModel.h"

@interface ShopCarGoodsCell : MGSwipeTableCell

@property(nonatomic,strong) OrderGoodsModel * goodsModel;

//数量加
@property(nonatomic,copy)void(^addBlock)(OrderGoodsModel * goodsModel);

//数量减
@property(nonatomic,copy)void(^reduceBlock)(OrderGoodsModel * goodsModel);

//勾选
@property(nonatomic,copy)void(^selectBlock)(OrderGoodsModel * goodsModel);

// 手动改变购物车数量
@property (nonatomic, copy) void(^changeNumberBlock)(OrderGoodsModel * goodsModel);
@end
