//
//  LineOffGoodsCell.m
//  Smile_100
//
//  Created by ap on 2018/3/6.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "LineOffGoodsCell.h"

@implementation LineOffGoodsCell
{
    __weak IBOutlet UILabel *titleLB;
    __weak IBOutlet UIImageView *scoreImageView;
    
    __weak IBOutlet UILabel *commone;
    __weak IBOutlet UILabel *storeLb;
    
    __weak IBOutlet UILabel *distanceLB;
    
    __weak IBOutlet UILabel *telLb;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}


- (void)setup
{
    storeLb.textColor = DETAILTEXTCOLOR;
    telLb.textColor = DETAILTEXTCOLOR;
    distanceLB.textColor = DETAILTEXTCOLOR;
}


- (void)setModel:(OffLineModel *)model
{
    _model = model;
//    __weak IBOutlet UILabel *titleLB;
//    __weak IBOutlet UIImageView *scoreImageView;
//
//    __weak IBOutlet UILabel *storeLb;
//
//    __weak IBOutlet UILabel *distanceLB;
//
//    __weak IBOutlet UILabel *telLb;
    [scoreImageView sd_setImageWithURL:[NSURL URLWithString:_model.shop_image] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    titleLB.text = _model.shop_name;
    commone.text = _model.stars;
    storeLb.text = [NSString stringWithFormat:@"%@%@%@%@",_model.province,_model.city,_model.district,_model.address];
    distanceLB.text = [NSString stringWithFormat:@"%@",_model.distance];
    telLb.text = _model.contact_phone;
}


@end
