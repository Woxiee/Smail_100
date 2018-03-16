//
//  MemberMoneyCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/17.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "MemberMoneyCell.h"

@implementation MemberMoneyCell
{

    __weak IBOutlet UILabel *smailLB;
    
    __weak IBOutlet UILabel *integralLB;
    __weak IBOutlet UILabel *chargeLB;
    __weak IBOutlet UILabel *changeLB;
}


- (void)awakeFromNib {
    [super awakeFromNib];

    [self setConfiguration];
}

/// 配置基础设置
- (void)setConfiguration
{
    smailLB.textColor = DETAILTEXTCOLOR1;
    integralLB.textColor = DETAILTEXTCOLOR1;
    chargeLB.textColor = DETAILTEXTCOLOR1;
    changeLB.textColor = DETAILTEXTCOLOR1;
    
    smailLB.text = [KX_UserInfo sharedKX_UserInfo].money;
    integralLB.text = [KX_UserInfo sharedKX_UserInfo].point;
    chargeLB.text = [KX_UserInfo sharedKX_UserInfo].air_money;
    changeLB.text = [KX_UserInfo sharedKX_UserInfo].used_point;

//    kyLB.textColor = TITLETEXTLOWCOLOR;
//    sxLb.textColor = TITLETEXTLOWCOLOR;
}





@end
