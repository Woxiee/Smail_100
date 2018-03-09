//
//  ActionOfficeCell.m
//  MyCityProject
//
//  Created by Faker on 17/7/13.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "ActionOfficeCell.h"

@implementation ActionOfficeCell
{

    __weak IBOutlet UILabel *priceLB;
    
    __weak IBOutlet UILabel *markLB;
    
    __weak IBOutlet UILabel *timeLB;

    __weak IBOutlet UIView *lineView;
    __weak IBOutlet UILabel *compangLB;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
}

/// 配置基础设置
- (void)setConfiguration
{
    lineView.backgroundColor = LINECOLOR;
    priceLB.textColor = TITLETEXTLOWCOLOR;
    markLB.textColor = DETAILTEXTCOLOR;
    
    compangLB.textColor = DETAILTEXTCOLOR;
    timeLB.textColor = DETAILTEXTCOLOR;
}


-(void)setModel:(GoodSDetailModel *)model
{
    _model = model;
    priceLB.text = [NSString stringWithFormat:@"价格：￥%@",_model.offerPrice];
    compangLB.text = [NSString stringWithFormat:@"竞拍企业：%@",_model.userName];
    if ([_model.top isEqualToString:@"1"]) {
        markLB.text = @"领先";
        markLB.textColor = BACKGROUND_COLORHL;
    }else{
        markLB.text = @"出局";
        markLB.textColor = DETAILTEXTCOLOR;
    }

    timeLB.text = _model.createTime;

}


@end
