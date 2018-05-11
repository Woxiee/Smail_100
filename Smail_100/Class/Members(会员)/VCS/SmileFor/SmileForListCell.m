//
//  SmileForListCell.m
//  Smail_100
//
//  Created by Faker on 2018/4/14.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SmileForListCell.h"

@implementation SmileForListCell
{
    __weak IBOutlet UILabel *stateLb;
    
    __weak IBOutlet UILabel *orderNo;
    
    __weak IBOutlet UILabel *timeLB;
    
    __weak IBOutlet UILabel *cardLB;
    
    __weak IBOutlet UILabel *nameLB;
    __weak IBOutlet UILabel *countLB;
    
    
    __weak IBOutlet UILabel *socotLB;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    orderNo.textColor = TITLETEXTLOWCOLOR;
    timeLB.textColor = DETAILTEXTCOLOR;
    cardLB.textColor = DETAILTEXTCOLOR;
    nameLB.textColor = DETAILTEXTCOLOR;
    socotLB.textColor = DETAILTEXTCOLOR;
    countLB.textColor = TITLETEXTLOWCOLOR;

    
}


- (void)setModel:(AcctoutWaterModel *)model
{
    _model = model;
    
    if ([_model.status isEqualToString:@"Enabled"] ) {
        stateLb.text = @"已成功";
        countLB.textColor = KMAINCOLOR;
    }
    else if ([_model.status isEqualToString:@"Fail"] )
    {
        stateLb.text = @"已驳回";
        countLB.textColor = TITLETEXTLOWCOLOR;
    }
    else{
        if (KX_NULLString(_model.isWithdrawal)) {
            stateLb.text =  @"兑换中";

        }else{
            stateLb.text =  @"提现中";

        }
        countLB.textColor = TITLETEXTLOWCOLOR;

    }
    
//    if (_model.is_plus.integerValue == 1 ) {
//        countLB.textColor = KMAINCOLOR;
//    }else{
//        countLB.textColor = RGB(99, 166, 95);
//    }
    orderNo.text = [NSString stringWithFormat:@"订单号%@",_model.orderno];
    timeLB.text = [NSString stringWithFormat:@"时间:%@",_model.ctime];
    cardLB.text = [NSString stringWithFormat:@"%@",_model.bank_info];
    countLB.text = [NSString stringWithFormat:@"%@元",_model.value];
    if (!KX_NULLString(_model.fee)) {
        socotLB.text =[NSString stringWithFormat:@"(手续费:%@元)",_model.fee];
    }
    
}


@end
