//
//  OrderMoneyCell.m
//  MyCityProject
//
//  Created by Faker on 17/6/10.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderMoneyCell.h"

@implementation OrderMoneyCell
{
    __weak IBOutlet UILabel *titlelB;

    __weak IBOutlet UILabel *detailLn;
    
    __weak IBOutlet UILabel *detailLb2;
    
    __weak IBOutlet UIView *lineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
}




/// 配置基础设置
- (void)setConfiguration
{
    titlelB.font = PLACEHOLDERFONT;
    titlelB.textColor  = TITLETEXTLOWCOLOR;
    
    detailLn.font = Font11;
    detailLn.textColor  = DETAILTEXTCOLOR1;

    detailLb2.font = PLACEHOLDERFONT;
    detailLb2.textColor  = DETAILTEXTCOLOR;
    lineView.backgroundColor = LINECOLOR;
}

-(void)setModel:(PayRecordList *)model
{
    _model = model;
    titlelB.text = [NSString stringWithFormat:@"付款：%@",_model.proceedsAmout];
    detailLn.text = _model.postTime;

    detailLb2.text = _model.payTypeTitle;
}


- (void)setPayDetailList:(PayDetailList *)payDetailList
{
    _payDetailList = payDetailList;
    
    if (_indexPath.row == 0) {
        titlelB.text = [NSString stringWithFormat:@"%@:￥%@",_payDetailList.number ,_payDetailList.payAmount];
    }else{
        titlelB.text = [NSString stringWithFormat:@"第%@期:￥%@",_payDetailList.number ,_payDetailList.payAmount];
    }
    detailLn.text = _payDetailList.payTime;
    if ([_payDetailList.status integerValue] == 0 ) {
        detailLb2.text = @"未支付";
        detailLb2.textColor = DETAILTEXTCOLOR;
    }else{
        detailLb2.text = @"已支付";
        detailLb2.textColor = BACKGROUND_COLORHL;
    }
    
    
}


@end
