//
//  LineOffGoodsCell.m
//  Smile_100
//
//  Created by ap on 2018/3/6.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "LineOffGoodsCell.h"
#import "DQStarView.h"
@implementation LineOffGoodsCell
{
    __weak IBOutlet UILabel *titleLB;
    
    __weak IBOutlet UIImageView *logoImageView;
    __weak IBOutlet UILabel *commone;
    __weak IBOutlet UILabel *storeLb;
    
    __weak IBOutlet UILabel *distanceLB;
    __weak IBOutlet UIView *lineView1;
    
    __weak IBOutlet DQStarView *scoreImageView;
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
    lineView1.backgroundColor = LINECOLOR;
    commone.textColor = DETAILTEXTCOLOR;
    distanceLB.textColor = DETAILTEXTCOLOR;
    telLb.textColor = DETAILTEXTCOLOR;

}


- (void)setModel:(OffLineModel *)model
{
    _model = model;
    [logoImageView sd_setImageWithURL:[NSURL URLWithString:_model.shop_image] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    titleLB.text = _model.shop_name;
    commone.text = [NSString stringWithFormat:@"%@评价",_model.comment_count];
    storeLb.text = [NSString stringWithFormat:@"%@%@%@%@",_model.province,_model.city,_model.district,_model.address];
    distanceLB.text = [NSString stringWithFormat:@"%@m",_model.distance];
    telLb.text = _model.contact_phone;
    
    scoreImageView.userInteractionEnabled = NO;
    scoreImageView.starTotalCount = 5;
    scoreImageView.ShowStyle = DQStarShowStyleSliding;
    [scoreImageView ShowDQStarScoreFunction:[_model.stars intValue]];

}


@end
