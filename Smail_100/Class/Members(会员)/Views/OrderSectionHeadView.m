//
//  OrderSectionHeadView.m
//  Smail_100
//
//  Created by ap on 2018/3/14.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "OrderSectionHeadView.h"

@implementation OrderSectionHeadView
{
    
    __weak IBOutlet UILabel *orderNumberLB;
    
    __weak IBOutlet UILabel *payStateLB;
    
    __weak IBOutlet UIView *headLineView;
    __weak IBOutlet UIView *linevIEW;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    linevIEW.backgroundColor = LINECOLOR;
    payStateLB.textColor = KMAINCOLOR;
    
    headLineView.backgroundColor = BACKGROUND_COLOR;
    
}


- (void)setModel:(OrderModel *)model
{
    _model = model;
    payStateLB.text = _model.paystatus_title;
    orderNumberLB.text = [NSString stringWithFormat:@"订单号:%@",_model.orderno];
}


@end
