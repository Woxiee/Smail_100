//
//  GoodsOrderAuctionCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/27.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsOrderAuctionCell.h"

@implementation GoodsOrderAuctionCell
{
    
    __weak IBOutlet UIImageView *_iconImageView;
    __weak IBOutlet UILabel *titleLB;

    __weak IBOutlet UILabel *priceLB;
    
    __weak IBOutlet UILabel *cjLb;
    
    __weak IBOutlet UILabel *yjLB;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
}

/// 配置基础设置
- (void)setConfiguration
{
    [_iconImageView layerForViewWith:2 AndLineWidth:0.5];
    titleLB.font = Font15;
    titleLB.textColor = TITLETEXTLOWCOLOR;
    
    priceLB.font = Font13;
    priceLB.textColor = DETAILTEXTCOLOR;
    
    cjLb.font = Font12;
    cjLb.textColor = DETAILTEXTCOLOR1;
    
    yjLB.font = Font12;
    yjLB.textColor = DETAILTEXTCOLOR1;
}


-(void)setModel:(GoodsOrderModel *)model
{
    _model = model;
    titleLB.text = _model.productInfo.productName;
    NSString *str1 = [NSString stringWithFormat:@"￥%@",_model.productInfo.dqPrice];
    NSString *str =[NSString stringWithFormat:@"当前价：%@",str1];
    NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:15 weight:UIFontWeightThin]];
    priceLB.attributedText = attributedStr;
    cjLb.text = [NSString stringWithFormat:@"出价 %@ ",_model.productInfo.offerCount];;
    yjLB.text = [NSString stringWithFormat:@"预计%@ 结束",_model.productInfo.endTime];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.productInfo.full_path] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];

}

@end
