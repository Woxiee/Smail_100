//
//  OrderWeekInfoCell.m
//  MyCityProject
//
//  Created by Faker on 17/6/9.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderWeekInfoCell.h"

@implementation OrderWeekInfoCell
{
    __weak IBOutlet UILabel *titleLb1;
    __weak IBOutlet UILabel *titleLb2;
    __weak IBOutlet UILabel *titleLb3;
    
    __weak IBOutlet UILabel *titleLb4;
    
    __weak IBOutlet UILabel *titleLb5;
    
    __weak IBOutlet UILabel *bhLB;
    __weak IBOutlet UILabel *lxLB;
    __weak IBOutlet UILabel *timeLB;
    __weak IBOutlet UILabel *yjLB;
        __weak IBOutlet UILabel *allYjLb;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];

}


/// 配置基础设置
- (void)setConfiguration
{
    titleLb1.textColor = TITLETEXTLOWCOLOR;
    titleLb2.textColor = TITLETEXTLOWCOLOR;
    titleLb3.textColor = TITLETEXTLOWCOLOR;
    titleLb4.textColor = TITLETEXTLOWCOLOR;
    titleLb5.textColor = TITLETEXTLOWCOLOR;

    
    bhLB.textColor = DETAILTEXTCOLOR;
    lxLB.textColor = DETAILTEXTCOLOR;
    timeLB.textColor = BACKGROUND_COLORHL;
    
    yjLB.textColor = DETAILTEXTCOLOR;
    allYjLb.textColor = DETAILTEXTCOLOR;
}

-(void)setModel:(OrderDetailModel *)model
{
    _model = model;
    yjLB.text = _model.order.deposit;
    allYjLb.text = _model.order.depositAmout;

    bhLB.text = [NSString stringWithFormat:@"%@至%@",_model.order.leaseStartTimeData,_model.order.leaseEndTimeData];
    lxLB.text = _model.payValue;
    timeLB.text =  [NSString stringWithFormat:@"￥%@",_model.order.sumAmout];
    
}
@end
