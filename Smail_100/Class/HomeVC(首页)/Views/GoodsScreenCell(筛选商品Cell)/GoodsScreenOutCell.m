//
//  GoodsScreenOutCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsScreenOutCell.h"

@implementation GoodsScreenOutCell
{
    __weak IBOutlet UIImageView *iconImageView;

    
    __weak IBOutlet UIImageView *markImageView;
    
    __weak IBOutlet UILabel *titleLabel;
    
    __weak IBOutlet UILabel *priceLabel;
    
    __weak IBOutlet UILabel *numberLabel;
    
    __weak IBOutlet UILabel *addressLabel;
    
    __weak IBOutlet UIView *lineView;
    
    __weak IBOutlet UILabel *compangLabel;
    
    __weak IBOutlet UILabel *timeLabel;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
    
}

/// 初始化视图
- (void)setup
{

}

/// 配置基础设置
- (void)setConfiguration
{
    titleLabel.font = Font15;
    priceLabel.font = PLACEHOLDERFONT;
    priceLabel.textColor = DETAILTEXTCOLOR;
    
    numberLabel.font = Font13;
    numberLabel.textColor = DETAILTEXTCOLOR;
    
    addressLabel.font = Font13;
    addressLabel.textColor = DETAILTEXTCOLOR;
    
    compangLabel.font = Font13;
    compangLabel.textColor = TITLETEXTLOWCOLOR;
    
    timeLabel.font = Font13;
    timeLabel.textColor = TITLETEXTLOWCOLOR;
    
    lineView.backgroundColor = LINECOLOR;
}


-(void)setModel:(GoodsScreenListModel *)model
{
    _model = model;
    if (!_isCollect ) {
        markImageView.hidden = YES;
    }
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.full_path] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];

    markImageView.image = [UIImage imageNamed:@"63@3x.png"];
    titleLabel.text = _model.needBuyName;
    NSString *str1 = [NSString stringWithFormat:@"￥%@/月",_model.hopePrice];
    NSString *str =[NSString stringWithFormat:@"期望价: %@",str1];
    NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:14 weight:UIFontWeightThin]];
    priceLabel.attributedText = attributedStr;
    numberLabel.text = [NSString stringWithFormat:@"求租数量: %@",_model.needCount];
    addressLabel.text = [NSString stringWithFormat:@"交货地址: %@%@%@",_model.prov,_model.city,_model.area];
    compangLabel.text = _model.companyName;
    timeLabel.text = [NSString stringWithFormat:@"%@",_model.distanceTime];
}


-(void)setHistoryModel:(HistoryModel *)historyModel
{
    _historyModel = historyModel;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.full_path] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];

    titleLabel.text = _historyModel.param2;
    NSString *str1 = [NSString stringWithFormat:@"￥%@/月",_historyModel.param3];
    NSString *str =[NSString stringWithFormat:@"期望价: %@",str1];
    NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:14 weight:UIFontWeightThin]];
    priceLabel.attributedText = attributedStr;
    numberLabel.text = [NSString stringWithFormat:@"求租数: %@",_historyModel.param4];
    addressLabel.text = _historyModel.param5;
    compangLabel.text = _historyModel.param6;
    timeLabel.text =[NSString stringWithFormat:@"%@",_historyModel.param7]; ;

}

@end
