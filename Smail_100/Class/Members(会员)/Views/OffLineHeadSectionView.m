//
//  OffLineHeadSectionView.m
//  Smail_100
//
//  Created by ap on 2018/5/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "OffLineHeadSectionView.h"

@implementation OffLineHeadSectionView
{
    
    __weak IBOutlet UILabel *shopNameLB;

    __weak IBOutlet UILabel *orderNumberLB;
    
    __weak IBOutlet UILabel *payStateLB;
    
    __weak IBOutlet UIView *headLineView;
    __weak IBOutlet UIView *linevIEW;
    
    __weak IBOutlet UIView *lineView2;
    
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    linevIEW.backgroundColor = LINECOLOR;
    payStateLB.textColor = KMAINCOLOR;
    
    headLineView.backgroundColor = BACKGROUND_COLOR;
    lineView2.backgroundColor = LINECOLOR;
    
    orderNumberLB.textColor = TITLETEXTLOWCOLOR;
}


- (void)setModel:(OrderModel *)model
{
    _model = model;
    shopNameLB.text = _model.shop_name;
    payStateLB.text = _model.paystatus_title;
    orderNumberLB.text = [NSString stringWithFormat:@"订单号:%@",_model.orderno];
}



@end
