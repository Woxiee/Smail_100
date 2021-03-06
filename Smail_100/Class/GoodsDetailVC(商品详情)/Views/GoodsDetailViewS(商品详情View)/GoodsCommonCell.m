//
//  GoodsCommonCell.m
//  ShiShi
//
//  Created by Faker on 17/3/22.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "GoodsCommonCell.h"

@implementation GoodsCommonCell
{

    __weak IBOutlet UIView *lineView2;
    __weak IBOutlet UIView *lineView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
}

/// 配置基础设置
- (void)setConfiguration
{
    lineView.backgroundColor = LINECOLOR;
    lineView2.backgroundColor = LINECOLOR;
    _titleLabel.font = Font15;
    _titleLabel.textColor = DETAILTEXTCOLOR;
   _titleLabel.textAlignment = NSTextAlignmentLeft;
    
    _goodSCommentLabel.font = Font13;
   _goodSCommentLabel.textAlignment = NSTextAlignmentLeft;
    
    
}

- (void)setOrderModel:(GoodsOrderModel *)orderModel
{
    _orderModel = orderModel;
    _titleLabel.text = [NSString stringWithFormat:@"积分抵扣: %@",_orderModel.point];
}
@end
