//
//  AcctoutWaterCell.m
//  Smail_100
//
//  Created by ap on 2018/3/15.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AcctoutWaterCell.h"

@implementation AcctoutWaterCell
{
    
    
    __weak IBOutlet UILabel *numberNO;
    __weak IBOutlet UILabel *nameType;
    __weak IBOutlet UILabel *numberLN;
    
    __weak IBOutlet UILabel *dateLNA;
    
    __weak IBOutlet UILabel *momeyLB;
    
    __weak IBOutlet UILabel *valueLB;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    numberLN.textColor = DETAILTEXTCOLOR;
    numberNO.textColor = DETAILTEXTCOLOR;
    dateLNA.textColor = DETAILTEXTCOLOR;
    momeyLB.textColor = KMAINCOLOR;
    valueLB.textColor = DETAILTEXTCOLOR;
}


- (void)setModel:(AcctoutWaterModel *)model
{
    _model = model;
    numberLN.text = _model.ass_mobile;
    numberNO.text = [NSString stringWithFormat:@"订单号:%@",_model.orderno];
    dateLNA.text = [NSString stringWithFormat:@"时间:%@",_model.ctime];
    if (_model.is_plus.integerValue == 1  ) {
        momeyLB.textColor = KMAINCOLOR;
    }else{
        momeyLB.textColor = RGB(99, 166, 95);
    }
    momeyLB.text = [NSString stringWithFormat:@"%@",_model.value];
    nameType.text = _model.title;

   
    if (!KX_NULLString(_model.shopId)) {
        valueLB.text =[NSString stringWithFormat:@"(含%@元营业额让利)",_model.fee];
    }
}


@end
