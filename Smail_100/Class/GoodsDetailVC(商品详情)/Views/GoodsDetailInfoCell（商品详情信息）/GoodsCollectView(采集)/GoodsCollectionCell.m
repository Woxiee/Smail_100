//
//  GoodsCollectionCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/16.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsCollectionCell.h"

@implementation GoodsCollectionCell
{
    __weak IBOutlet UILabel *pricLabel;

    __weak IBOutlet UILabel *_numberLabel;
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
}



/// 配置基础设置
- (void)setConfiguration
{
    pricLabel.textColor = BACKGROUND_COLORHL;
    pricLabel.font = Font15;

    _numberLabel.textColor = TITLETEXTLOWCOLOR;
    _numberLabel.font = Font13;
    
}


- (void)setModel:(GroupBuyPriceList *)model
{
    _model = model;
    pricLabel.text = [NSString stringWithFormat:@"￥%@",_model.jcPrice];

    _numberLabel.text = [NSString stringWithFormat:@"%@-%@台",_model.minCount,_model.maxCount];
}

@end
