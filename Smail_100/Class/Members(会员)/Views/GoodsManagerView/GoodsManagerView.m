//
//  GoodsManagerView.m
//  Smile_100
//
//  Created by ap on 2018/2/28.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "GoodsManagerView.h"

@implementation GoodsManagerView
{
    __weak IBOutlet UILabel *nameLB;
    
    __weak IBOutlet UIImageView *logoImageView;
    __weak IBOutlet UILabel *priceLB;
    
    __weak IBOutlet UILabel *saleLb;
    
    __weak IBOutlet UILabel *kucLb;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    priceLB.textColor = KMAINCOLOR;
}

- (void)setModel:(MeChantOrderModel *)model
{
    _model = model;
    [ logoImageView sd_setImageWithURL:[NSURL URLWithString:model.pict_url] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    nameLB.text = _model.title;
    priceLB.text = [NSString stringWithFormat:@"%@",_model.price];
    kucLb.text = [NSString stringWithFormat:@"库存:%@",_model.stock];
    saleLb.text = [NSString stringWithFormat:@"已售:%@",_model.volume];
}
@end
