//
//  ShoppingCarHeaderView.h
//  ShiShi
//
//  Created by ac on 16/3/28.
//  Copyright © 2016年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OrderGoodsModel.h"
@interface ShoppingCarHeaderView : UIView

@property (nonatomic,strong)UIButton *allSelectbtn;
@property (nonatomic,strong) OrderGoodsModel *model;


-(id)initWithHeaderHadGoodsSelect:(void(^)())selectBlock delectAll:(void(^)())delectAllBlock;
-(id)initWithHeaderNotGoods;
@end
