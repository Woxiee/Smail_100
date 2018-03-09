//
//  OrderPayTypeCell.m
//  MyCityProject
//
//  Created by Faker on 17/6/8.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderPayTypeCell.h"

@implementation OrderPayTypeCell
{
    __weak IBOutlet UILabel *payLB;
    __weak IBOutlet UILabel *priceLB;
    
    __weak IBOutlet UILabel *titleLB1;
    
    __weak IBOutlet UILabel *titleLb2;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
    
}

/// 配置基础设置
- (void)setConfiguration
{
    titleLB1.textColor = TITLETEXTLOWCOLOR;
    titleLb2.textColor = TITLETEXTLOWCOLOR;

    payLB.textColor = DETAILTEXTCOLOR;
    priceLB.textColor = BACKGROUND_COLORHL;
}

-(void)setModel:(OrderDetailModel *)model
{
    _model = model;
  
    payLB.text = _model.payValue;

    priceLB.text = [NSString stringWithFormat:@"￥%@",_model.order.sumAmout];

    
}


@end
