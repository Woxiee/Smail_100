//
//  ShopMoreGoodsCell.m
//  ShiShi
//
//  Created by ac on 16/6/6.
//  Copyright © 2016年 fec. All rights reserved.
//

#import "ShopMoreGoodsCell.h"

@implementation ShopMoreGoodsCell{

    __weak IBOutlet UIImageView *iconImageView;
    __weak IBOutlet UILabel *nameLable;
}



- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    nameLable.font = Font13;
    nameLable.textColor = DETAILTEXTCOLOR;
}

//-(void)setGoodsModel:(Values *)goodsModel
//{
//    _goodsModel = goodsModel;
//    nameLable.text = _goodsModel.name;
//
//}

-(void)setGoodsModel:(LeftCategory *)goodsModel
{
    _goodsModel = goodsModel;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_goodsModel.logo] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    nameLable.text = _goodsModel.name;

}



@end
