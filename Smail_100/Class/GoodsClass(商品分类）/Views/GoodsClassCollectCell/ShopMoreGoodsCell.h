//
//  ShopMoreGoodsCell.h
//  ShiShi
//
//  Created by ac on 16/6/6.
//  Copyright © 2016年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsClassModel.h"


@interface ShopMoreGoodsCell : UICollectionViewCell

@property(nonatomic,strong) Values * goodsModel;
@property(nonatomic,strong) void(^goodsAdd)(CGPoint btnPoint);

@end
