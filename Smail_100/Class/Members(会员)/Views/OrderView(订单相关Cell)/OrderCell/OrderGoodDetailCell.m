//
//  OrderGoodDetailCell.m
//  MyCityProject
//
//  Created by Faker on 17/6/8.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderGoodDetailCell.h"
@interface OrderGoodDetailCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *detailLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;

@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLB;

@end

@implementation OrderGoodDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
    [self setup];
}


/// 初始化视图
- (void)setup
{
    
}


/// 配置基础设置
- (void)setConfiguration
{
    [_iconImageView layerForViewWith:2 AndLineWidth:0.5];
    _titleLB.font = Font15;
    _titleLB.textColor = DETAILTEXTCOLOR;
    
    _detailLB.font = Font12;
    _detailLB.textColor = DETAILTEXTCOLOR1;
    
    _priceLB.font = Font15;
    _priceLB.textColor = BACKGROUND_COLORHL;
    
    _numLB.textColor = DETAILTEXTCOLOR;
  
    
}


- (void)setModel:(OrderDetailModel *)model
{
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.order.productImgPath] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    _titleLB.text = _model.order.productName;
    _detailLB.text = _model.order.property;
    _priceLB.text  = [NSString stringWithFormat:@"￥%@",_model.order.price];
    
    _payTypeLabel.text = _model.payValue;
    
    _numLB.text = [NSString stringWithFormat:@"x%@", _model.order.buyCount];
}

@end
