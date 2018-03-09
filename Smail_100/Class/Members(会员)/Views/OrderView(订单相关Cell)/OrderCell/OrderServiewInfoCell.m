//
//  OrderServiewInfoCell.m
//  MyCityProject
//
//  Created by Faker on 17/6/9.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderServiewInfoCell.h"

@implementation OrderServiewInfoCell
{
    __weak IBOutlet UILabel *titleLb1;
    __weak IBOutlet UILabel *titleLb2;
    __weak IBOutlet UILabel *titleLb3;
    __weak IBOutlet UILabel *titleLb4;
    
    __weak IBOutlet UIView *lineVIew;
    __weak IBOutlet UIView *lineVIew1;
    __weak IBOutlet UIView *lineVIew2;
    __weak IBOutlet UIView *lineVieww3;

    __weak IBOutlet UILabel *bhLB;
    __weak IBOutlet UILabel *lxLB;
    __weak IBOutlet UILabel *timeLB;
    
    __weak IBOutlet UILabel *buyCoutLB;
    
    
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
    
    lineVIew.backgroundColor = LINECOLOR;
    lineVIew1.backgroundColor = LINECOLOR;
    lineVIew2.backgroundColor = LINECOLOR;
    lineVieww3.backgroundColor = LINECOLOR;


    bhLB.textColor = DETAILTEXTCOLOR;
    lxLB.textColor = DETAILTEXTCOLOR;
    timeLB.textColor = DETAILTEXTCOLOR;
    buyCoutLB.textColor = DETAILTEXTCOLOR;

}

-(void)setModel:(OrderDetailModel *)model
{
    _model = model;
    bhLB.text = _model.order.serviceStartTime;
    lxLB.text = _model.order.serviceEndTime;
    
    timeLB.text = _model.order.modelsType;
    buyCoutLB.text = _model.order.countNumber;

}

@end
