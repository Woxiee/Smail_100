//
//  OrdersPayTypeCell.m
//  MyCityProject
//
//  Created by Faker on 17/7/4.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrdersPayTypeCell.h"

@implementation OrdersPayTypeCell
{
    __weak IBOutlet UILabel *title1LB;
    
    __weak IBOutlet UILabel *title2LB;
    
    __weak IBOutlet UILabel *title3LB;
    
    
    __weak IBOutlet UILabel *detail1LB;
    
    __weak IBOutlet UILabel *detail2LB;
    
    __weak IBOutlet UILabel *detail3LB;
    
    __weak IBOutlet UIView *lineView1;
    
    __weak IBOutlet UIView *lineView2;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    lineView1.backgroundColor = LINECOLOR;
    lineView2.backgroundColor = LINECOLOR;
    
    title1LB.textColor = DETAILTEXTCOLOR;
    title1LB.font = Font15;

    title2LB.textColor = DETAILTEXTCOLOR;
    title2LB.font = Font15;
    
    title3LB.textColor = DETAILTEXTCOLOR;
    title3LB.font = Font15;
    
    detail1LB.textColor = DETAILTEXTCOLOR;
    detail1LB.font = Font15;
    
    detail2LB.textColor = DETAILTEXTCOLOR;
    detail2LB.font = Font15;
    
    
    detail3LB.textColor = DETAILTEXTCOLOR;
    detail3LB.font = Font15;

}


- (void)setModel:(GoodsOrderModel *)model
{
    _model = model;
    detail1LB.text = [NSString stringWithFormat:@"%@",_model.productInfo.monthSettlementDownPayment];
    detail2LB.text = [NSString stringWithFormat:@"%@",_model.productInfo.monthSettlementBalanceStage];
    detail3LB.text = [NSString stringWithFormat:@"%@",_model.productInfo.monthSettlementTimeInterval];

}

@end
