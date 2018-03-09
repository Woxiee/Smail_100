//
//  ContractOrderInfoCell.m
//  MyCityProject
//
//  Created by Faker on 17/7/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "ContractOrderInfoCell.h"

@implementation ContractOrderInfoCell
{
    __weak IBOutlet UILabel *titleLB1;

    __weak IBOutlet UILabel *titleLB2;

    __weak IBOutlet UILabel *titleLB3;
    
    __weak IBOutlet UILabel *titleLB4;
    
    __weak IBOutlet UILabel *titleLB5;
    
    __weak IBOutlet UILabel *titleLB6;
    
    __weak IBOutlet UILabel *titleLB7;
    
    
    
    __weak IBOutlet NSLayoutConstraint *constraintHight;
    
    __weak IBOutlet NSLayoutConstraint *constraintHight2;
    
    __weak IBOutlet NSLayoutConstraint *constraintHight3; /// 产权备案号

    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
}


/// 配置基础设置
- (void)setConfiguration
{
    titleLB1.textColor = DETAILTEXTCOLOR;
    titleLB2.textColor = DETAILTEXTCOLOR;
    titleLB3.textColor = DETAILTEXTCOLOR;
    titleLB4.textColor = DETAILTEXTCOLOR;
    titleLB5.textColor = DETAILTEXTCOLOR;
    titleLB6.textColor = DETAILTEXTCOLOR;
    titleLB7.textColor = DETAILTEXTCOLOR;

}


- (void)setModel:(ContracDetailModel *)model
{
    _model = model;
    titleLB1.text = [NSString stringWithFormat:@"商品名：%@",_model.order.productName];
    
    if (KX_NULLString(_model.contract.propertyRecordNumber)) {
        constraintHight3.constant = -3;
    }else{
        titleLB2.text = [NSString stringWithFormat:@"产权备案号：%@",_model.contract.propertyRecordNumber];

    }


    titleLB4.text = [NSString stringWithFormat:@"数量：%@",_model.order.buyCount];
    if (!KX_NULLString(_model.order.leaseEndTime)) {
        titleLB3.text = [NSString stringWithFormat:@"月租金额：%@元",_model.order.price];

        titleLB5.text = [NSString stringWithFormat:@"起租-结束时间：%@",_model.order.leaseEndTime];
        if (KX_NULLString(_model.order.deposit)) {
            titleLB7.text = @"押金：0.00元";
        }else{
            titleLB7.text = [NSString stringWithFormat:@"押金：%@元",_model.order.deposit];

        }

    }else{
        constraintHight.constant = -3;
        constraintHight2.constant = -3;
        titleLB3.text = [NSString stringWithFormat:@"商品单价：%@元",_model.order.price];

    }
    
    if ([_model.order.payMentType integerValue] == 1) {
        titleLB6.text = @"付款方式：直接付款";
    }
    else if ([_model.order.payMentType integerValue] == 2){
        titleLB6.text = @"付款方式：分期付款";
    }
    else if ([_model.order.payMentType integerValue] == 3){
        titleLB6.text = @"付款方式：先用后付";
    }
    else if ([_model.order.payMentType integerValue] == 4){
        titleLB6.text = @"付款方式：融资租赁";
    }

    
}

@end
