//
//  AgentPlatfoemListCell.m
//  Smail_100
//
//  Created by ap on 2018/3/22.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AgentPlatfoemListCell.h"

@implementation AgentPlatfoemListCell
{
    __weak IBOutlet UIImageView *logoImageView;
    
    __weak IBOutlet UILabel *nameLB;
    
    __weak IBOutlet UILabel *stateLB;
    
    __weak IBOutlet UILabel *shtgLV;
    
    __weak IBOutlet UILabel *dpLV;
    
    __weak IBOutlet UILabel *hyLB;
    __weak IBOutlet UILabel *yyLV;
    
    __weak IBOutlet UILabel *zsLB;
    
    __weak IBOutlet UILabel *tjLB;
    
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}



- (void)setup
{
    
}


- (void)setModel:(AgentPlatformModel *)model
{
    _model = model;
    [logoImageView sd_setImageWithURL:[NSURL URLWithString:_model.shop_image] placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW]];
    nameLB.text = _model.shop_name;
    if ([_model.status isEqualToString:@"Enabled"]) {
        stateLB.text = @"审核通过";
    }else{
        stateLB.text = @"驳回申请";
    }
    shtgLV.text = [NSString stringWithFormat:@"开通账号:%@",_model.mobile];
    dpLV.text = [NSString stringWithFormat:@"店铺推荐人:%@",_model.pmobile];
    hyLB.text = [NSString stringWithFormat:@"所属行业:%@",_model.pmobile];
    hyLB.text = [NSString stringWithFormat:@"所属行业:%@",_model.category_name];
    yyLV.text = [NSString stringWithFormat:@"营业额让利:%@",_model.interest_perc];
    zsLB.text = [NSString stringWithFormat:@"赠送积分比例:%@",_model.present_point_perc];
    tjLB.text = [NSString stringWithFormat:@"提交时间:%@",@""];

}


@end
