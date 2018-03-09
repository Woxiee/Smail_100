//
//  GoodsCollectTimeCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/16.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsCollectTimeCell.h"

@implementation GoodsCollectTimeCell
{
    __weak IBOutlet UILabel *title1Label;
    
    __weak IBOutlet UIView *lineView;
    __weak IBOutlet UILabel *title2Label;
    
    __weak IBOutlet UIView *lineView2;
    __weak IBOutlet UILabel *title3Label;
    
    __weak IBOutlet UILabel *depriceLB;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
}

/// 配置基础设置
- (void)setConfiguration
{
    title1Label.font =Font13;
    title1Label.textColor =DETAILTEXTCOLOR1;
    title3Label.font =Font13;
    title3Label.textColor =DETAILTEXTCOLOR1;
    
    title2Label.font =Font13;
    title2Label.textColor =DETAILTEXTCOLOR1;
    lineView.backgroundColor = LINECOLOR;
    lineView2.backgroundColor =  LINECOLOR;
    
    depriceLB.font = Font13;
    depriceLB.textColor =DETAILTEXTCOLOR1;

}

- (void)setModel:(GroupBuyResult *)model
{
    _model = model;
        title1Label.text = [NSString stringWithFormat:@"开始时间: %@",_model.startTime];
        title2Label.text = [NSString stringWithFormat:@"已参与人数：%@",_model.joinCount];
    
      title3Label.text = [NSString stringWithFormat:@"结束时间: %@",_model.endTime];
 
    if (!KX_NULLString(_model.marginPrice)) {
        depriceLB.text = [NSString stringWithFormat:@"保证金: %@",_model.marginPrice];

    }
}


@end
