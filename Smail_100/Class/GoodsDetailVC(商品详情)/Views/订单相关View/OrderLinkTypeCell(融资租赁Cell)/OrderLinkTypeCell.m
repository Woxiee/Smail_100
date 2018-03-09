//
//  OrderLinkTypeCell.m
//  MyCityProject
//
//  Created by Faker on 17/8/18.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderLinkTypeCell.h"

@implementation OrderLinkTypeCell
{
    __weak IBOutlet UILabel *title1LB;
    
    __weak IBOutlet UILabel *title2LB;
    
    __weak IBOutlet UILabel *title3LB;
    
    __weak IBOutlet UILabel *title4LB;
    __weak IBOutlet UILabel *title5LB;
    __weak IBOutlet UILabel *title6LB;
    __weak IBOutlet UILabel *title7LB;
    __weak IBOutlet UILabel *title8LB;
    __weak IBOutlet UILabel *title9LB;

    
    __weak IBOutlet UILabel *detail1LB;
    
    __weak IBOutlet UILabel *detail2LB;
    
    __weak IBOutlet UILabel *detail3LB;
    __weak IBOutlet UILabel *detail4LB;
    
    __weak IBOutlet UILabel *detail5LB;
    
    __weak IBOutlet UILabel *detail6LB;
    __weak IBOutlet UILabel *detail7LB;
    
    __weak IBOutlet UILabel *detail8LB;
    
    __weak IBOutlet UILabel *detail9LB;
    
    __weak IBOutlet UIView *lineView1;
    
    __weak IBOutlet UIView *lineView2;
    __weak IBOutlet UIView *lineView3;

    __weak IBOutlet UIView *lineView4;

    __weak IBOutlet UIView *lineView5;
    __weak IBOutlet UIView *lineView6;
    __weak IBOutlet UIView *lineView7;
    
    __weak IBOutlet UIView *lineView8;
    

    __weak IBOutlet UIView *lineView9;

}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
}

/// 配置基础设置
- (void)setConfiguration
{
    lineView1.backgroundColor = LINECOLOR;
    lineView2.backgroundColor = LINECOLOR;
    lineView3.backgroundColor = LINECOLOR;
    lineView4.backgroundColor = LINECOLOR;
    lineView5.backgroundColor = LINECOLOR;
    lineView6.backgroundColor = LINECOLOR;
    lineView7.backgroundColor = LINECOLOR;
    lineView8.backgroundColor = LINECOLOR;
    lineView9.backgroundColor = LINECOLOR;
    
    
    title1LB.textColor = DETAILTEXTCOLOR;
    title1LB.font = Font15;
    
    title2LB.textColor = DETAILTEXTCOLOR;
    title2LB.font = Font15;
    
    title3LB.textColor = DETAILTEXTCOLOR;
    title3LB.font = Font15;
    
    
    title4LB.textColor = DETAILTEXTCOLOR;
    title4LB.font = Font15;
    
    title5LB.textColor = DETAILTEXTCOLOR;
    title5LB.font = Font15;
    
    title6LB.textColor = DETAILTEXTCOLOR;
    title6LB.font = Font15;
    
    title7LB.textColor = DETAILTEXTCOLOR;
    title7LB.font = Font15;
    
    
    title8LB.textColor = DETAILTEXTCOLOR;
    title8LB.font = Font15;
    
    title9LB.textColor = DETAILTEXTCOLOR;
    title9LB.font = Font15;

    
    detail1LB.textColor = DETAILTEXTCOLOR;
    detail1LB.font = Font15;
    
    detail2LB.textColor = DETAILTEXTCOLOR;
    detail2LB.font = Font15;
    
    
    detail3LB.textColor = DETAILTEXTCOLOR;
    detail3LB.font = Font15;
    
    detail4LB.textColor = DETAILTEXTCOLOR;
    detail4LB.font = Font15;
    
    detail5LB.textColor = DETAILTEXTCOLOR;
    detail5LB.font = Font15;
    
    
    detail6LB.textColor = DETAILTEXTCOLOR;
    detail6LB.font = Font15;
    
    detail7LB.textColor = DETAILTEXTCOLOR;
    detail7LB.font = Font15;
    
    detail8LB.textColor = DETAILTEXTCOLOR;
    detail8LB.font = Font15;
    
    detail9LB.textColor = DETAILTEXTCOLOR;
    detail9LB.font = Font15;

}


-(void)setModel:(GoodsOrderModel *)model
{
    _model = model;
    
    detail1LB.text = [NSString stringWithFormat:@"%@",_model.productInfo.financingMargin];
    detail2LB.text = [NSString stringWithFormat:@"%@",_model.productInfo.financingProportion];
    detail3LB.text = [NSString stringWithFormat:@"%@",_model.productInfo.financingAnnualInterestRate];
    
    if ([_model.productInfo.benchmarkProfitsRise isEqualToString:@"%"]) {
        title4LB.text = @"固定利率";
        detail4LB.text = _model.productInfo.fixedProfit;
    }else{
        title4LB.text = @"基准利率上浮";
        detail4LB.text = _model.productInfo.benchmarkProfitsRise;
    }
    detail5LB.text = [NSString stringWithFormat:@"%@",_model.productInfo.poundage];
    detail6LB.text = [NSString stringWithFormat:@"%@",_model.productInfo.theFinancing];
    
    detail7LB.text = [NSString stringWithFormat:@"%@",_model.productInfo.monthlyPaymentAmount];
    detail8LB.text = [NSString stringWithFormat:@"%@",_model.productInfo.needToBuyInsurance];
    detail9LB.text = [NSString stringWithFormat:@"%@",_model.productInfo.otherFees];
}

@end
