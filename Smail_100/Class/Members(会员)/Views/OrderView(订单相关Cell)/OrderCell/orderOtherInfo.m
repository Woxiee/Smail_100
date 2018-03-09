//
//  orderOtherInfo.m
//  MyCityProject
//
//  Created by Faker on 17/6/8.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "orderOtherInfo.h"

@implementation orderOtherInfo
{
    
    __weak IBOutlet UILabel *titleLb1;
    __weak IBOutlet UILabel *titleLb2;
    __weak IBOutlet UILabel *titleLb3;
    __weak IBOutlet UIView *lineVIew;
    
    __weak IBOutlet UILabel *bhLB;
    __weak IBOutlet UILabel *lxLB;
    __weak IBOutlet UILabel *timeLB;
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
    lineVIew.backgroundColor = LINECOLOR;
    bhLB.textColor = DETAILTEXTCOLOR;
    lxLB.textColor = DETAILTEXTCOLOR;
    timeLB.textColor = DETAILTEXTCOLOR;
}


-(void)setModel:(OrderDetailModel *)model
{
    _model = model;
    bhLB.text = _model.order.orderCode;
    lxLB.text = _model.order.orderTypeTitle;
    timeLB.text = _model.order.createTime;
    
}

@end
