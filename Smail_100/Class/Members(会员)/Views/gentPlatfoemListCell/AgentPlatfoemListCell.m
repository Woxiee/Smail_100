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
    
    __weak IBOutlet UIView *lineView1;
    __weak IBOutlet UIView *lineView2;
    __weak IBOutlet UILabel *nameLB;
    
    __weak IBOutlet UILabel *stateLB;
    
    __weak IBOutlet UILabel *shtgLV;
    
    __weak IBOutlet UILabel *dpLV;
    
    __weak IBOutlet UILabel *hyLB;
    __weak IBOutlet UILabel *yyLV;
    
    __weak IBOutlet UILabel *zsLB;
    
    __weak IBOutlet UILabel *tjLB;
    
    
    __weak IBOutlet UILabel *statusMsgLB;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}



- (void)setup
{
    lineView1.backgroundColor = LINECOLOR;
    lineView2.backgroundColor = LINECOLOR;
    stateLB.textColor = KMAINCOLOR;
    statusMsgLB.textColor = KMAINCOLOR;
    nameLB.textColor = DETAILTEXTCOLOR;
}


- (void)setModel:(AgentPlatformModel *)model
{
    _model = model;
    [logoImageView sd_setImageWithURL:[NSURL URLWithString:_model.shop_image] placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW]];
    nameLB.text = _model.shop_name;
//    审核列表状态, Pendding:待审核 , Enabled:审核通过 , Fail:驳回

//    if ([_model.status isEqualToString:@"Pendding"]) {
//        stateLB.text = @"待审核";
//    }else if ([_model.status isEqualToString:@"Enabled"]){
//        stateLB.text = @"已审核";
//    }
//    else{
//        stateLB.text = @"已驳回";
//
//    }
    
     stateLB.text = _model.status_title;
    shtgLV.text = [NSString stringWithFormat:@"开通账号:%@",_model.mobile];
    dpLV.text = [NSString stringWithFormat:@"店铺推荐人:%@",_model.applicant_mobile];
    hyLB.text = [NSString stringWithFormat:@"所属行业:%@",_model.name];
    yyLV.text = [NSString stringWithFormat:@"营业额让利:%@",_model.interest_perc];
    zsLB.text = [NSString stringWithFormat:@"赠送积分比例:%@",_model.present_point_perc];
    tjLB.text = [NSString stringWithFormat:@"提交时间:%@",_model.ctime];

    if (!KX_NULLString(_model.status_msg)) {
        statusMsgLB.text = [NSString stringWithFormat:@"驳回原因:%@",model.status_msg];
    }
}


@end
