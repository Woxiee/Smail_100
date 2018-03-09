//
//  GoodGuigeView.h
//  ShiShi
//
//  Created by Faker on 17/3/9.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodSDetailModel.h"

typedef NS_ENUM(NSInteger, GoodGuigeChooseType) {
     GoodGuigeAddCartOrBuyType, ///添加购物车或者购买
     GoodGuigeChooseGoodsType      /// 选择规格属性
};

/// index  0  确定按钮   1加入购物车  2 购买
typedef void(^DidClikSubmitBtnBlock)(GoodSDetailModel *model, NSInteger index);
@interface GoodGuigeView : UIView


@property (nonatomic, strong) GoodSDetailModel *model;
@property (nonatomic, copy) DidClikSubmitBtnBlock submitBlock;
@property (nonatomic, strong) NSString *oldAttrvalueStr; /// 记录上一次选择的规格
@property (nonatomic, assign)  GoodGuigeChooseType goodGuigeChooseType;

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame withChooseType:(GoodGuigeChooseType )chossType;
- (void)show;
@end
