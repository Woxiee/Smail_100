//
//  GoodsSupplierViewCell.m
//  MyCityProject
//
//  Created by Faker on 17/6/1.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsSupplierViewCell.h"

@implementation GoodsSupplierViewCell
{
    __weak IBOutlet UILabel *titleLB;
    __weak IBOutlet UILabel *detailLB;
    __weak IBOutlet UIView *lineView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
}


/// 配置基础设置
- (void)setConfiguration
{
    titleLB.textColor = DETAILTEXTCOLOR;
    detailLB.textColor = DETAILTEXTCOLOR1;

    lineView.backgroundColor = LINECOLOR;
}

-(void)setModel:(GoodsSupplierModel *)model
{
    _model = model;
    titleLB.text = _model.productName;
    detailLB.text = _model.mainParam1;
}

@end
