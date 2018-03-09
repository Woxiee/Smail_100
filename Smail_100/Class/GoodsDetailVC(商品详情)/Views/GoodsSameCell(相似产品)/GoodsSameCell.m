//
//  GoodsSameCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/19.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsSameCell.h"

@implementation GoodsSameCell
{

    __weak IBOutlet UIImageView *iconImageView;
    
    __weak IBOutlet UILabel *contenLB;
    
    __weak IBOutlet UILabel *priceLB;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
}

/// 配置基础设置
- (void)setConfiguration
{
    contenLB.textColor = DETAILTEXTCOLOR;
    contenLB.font = PLACEHOLDERFONT;
    
    priceLB.textColor = BACKGROUND_COLORHL;
    priceLB.font = Font15;
}

-(void)setModel:(GoodsListModel *)model
{
    _model = model;
    if (KX_NULLString(_model.imgList1)) {
        _model.imgList1 = @"";
    }
    
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.imgList1] placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW]];
    contenLB.text = _model.mainProductNameAdv;
    priceLB.text = [NSString stringWithFormat:@"￥ %@",_model.cargoPriceAdv];

}


@end
