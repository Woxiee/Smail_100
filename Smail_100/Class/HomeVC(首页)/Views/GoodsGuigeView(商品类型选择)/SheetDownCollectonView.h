//
//  SheetDownCollectonView.h
//  MyCityProject
//
//  Created by Faker on 17/5/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsScreenmodel.h"
/// index  0  确定按钮   1加入购物车  2 购买
typedef void(^DidClikCollectionBlock)(Values *model, NSInteger tag);
@interface SheetDownCollectonView : UIView
@property (nonatomic, strong) GoodsScreenmodel *model;
@property (nonatomic, strong)   Values *values;

@property (nonatomic, copy) DidClikCollectionBlock didClickCollectionBlock;

- (void)show;

@end
