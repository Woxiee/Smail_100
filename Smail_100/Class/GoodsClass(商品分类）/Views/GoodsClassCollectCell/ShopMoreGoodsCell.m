//
//  ShopMoreGoodsCell.m
//  ShiShi
//
//  Created by ac on 16/6/6.
//  Copyright © 2016年 fec. All rights reserved.
//

#import "ShopMoreGoodsCell.h"

@implementation ShopMoreGoodsCell{

    __weak IBOutlet UILabel *nameLable;
}



- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    nameLable.font = Font13;
    nameLable.textColor = DETAILTEXTCOLOR;
}

-(void)setGoodsModel:(Values *)goodsModel
{
    _goodsModel = goodsModel;
    nameLable.text = _goodsModel.name;

}




@end
