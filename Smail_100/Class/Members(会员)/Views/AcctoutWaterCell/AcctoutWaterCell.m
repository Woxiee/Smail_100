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
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    numberLN.textColor = DETAILTEXTCOLOR;
    numberNO.textColor = DETAILTEXTCOLOR;
    dateLNA.textColor = DETAILTEXTCOLOR;
    momeyLB.textColor = KMAINCOLOR;

}


- (void)setModel:(AcctoutWaterModel *)model
{
    _model = model;
    numberLN.text = _model.ass_mobile;
    numberNO.text = [NSString stringWithFormat:@"订单号:%@",_model.orderno];
    dateLNA.text = _model.ctime;
    momeyLB.text = [NSString stringWithFormat:@"+%@",_model.last_value];
    nameType.text = _model.title;

}


@end
