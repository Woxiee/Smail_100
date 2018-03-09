//
//  GoodsCategoryCell.m
//  ShiShi
//
//  Created by mac_KY on 17/3/8.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "GoodsCategoryCell.h"

@implementation GoodsCategoryCell
{
    __weak IBOutlet UILabel *listNameLb;
    
    __weak IBOutlet UIView *lineView;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    listNameLb.text = @"测试";
    
}



-(void)setModel:(GoodsClassModel *)model
{
    _model = model;
    listNameLb.text = model.name;
    listNameLb.textColor = model.select?TITLETEXTLOWCOLOR:DETAILTEXTCOLOR;
    lineView.backgroundColor = model.select?[UIColor clearColor]:LINECOLOR;
    lineView.hidden = YES;
    if (model.select) {
        listNameLb.textColor = [UIColor whiteColor];
        listNameLb.backgroundColor = KMAINCOLOR;
        [listNameLb layerForViewWith:4 AndLineWidth:0];
    }else{
        listNameLb.textColor = TITLETEXTLOWCOLOR;
        [listNameLb layerForViewWith:0 AndLineWidth:0];
        listNameLb.backgroundColor = [UIColor clearColor];
    }
    
}

@end
