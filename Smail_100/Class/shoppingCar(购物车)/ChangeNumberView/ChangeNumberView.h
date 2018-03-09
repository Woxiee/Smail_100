//
//  ChangeNumberView.h
//  ShiShi
//
//  Created by Faker on 17/4/13.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderGoodsModel.h"
@interface ChangeNumberView : UIView
@property (nonatomic, strong) OrderGoodsModel *model;
- (void)show;
@end
