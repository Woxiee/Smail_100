//
//  AgentPaltLoactionCell.m
//  Smail_100
//
//  Created by ap on 2018/5/17.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AgentPaltLoactionCell.h"

@implementation AgentPaltLoactionCell
{
    UIButton *_accoutBtn;
    UIButton *_areaBtn;
    UILabel *_accoutLB;
    UILabel *_areaLB;

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        
    }
    
    return self;
}

/// 初始化视图
- (void)setup
{
//    [KX_UserInfo sharedKX_UserInfo].agent_level = @"3";
//    red_ju@3x.png
    _accoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_accoutBtn setImage:[UIImage imageNamed:@"bule_jus@2x.png"] forState:UIControlStateNormal];
    [_accoutBtn setTitle:@" 合伙人账号: " forState:UIControlStateNormal];
    _accoutBtn.titleLabel.font = Font14;
    [_accoutBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    [self.contentView addSubview:_accoutBtn];
    
    _accoutLB = [UILabel new];
    _accoutLB.textColor = TITLETEXTLOWCOLOR;
    _accoutLB.font = Font14;
    _accoutLB.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_accoutLB];
    
    



    _accoutBtn.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 10)
    .widthIs(90)
    .heightIs(17);
    
    _accoutLB.sd_layout
    .leftSpaceToView(_accoutBtn, 5)
    .topEqualToView(_accoutBtn)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(17);
    
    if ([KX_UserInfo sharedKX_UserInfo].agent_level.integerValue == 2) {
        [_accoutBtn setTitle:@" 代理人账号: " forState:UIControlStateNormal];

        _areaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_areaBtn setImage:[UIImage imageNamed:@"red_jus@2x.png"] forState:UIControlStateNormal];
        
        [_areaBtn setTitle:@" 代理人区域: " forState:UIControlStateNormal];
        _areaBtn.titleLabel.font = Font14;
        [_areaBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
        [self.contentView addSubview:_areaBtn];
        
        _areaLB = [UILabel new];
        _areaLB.textColor = KMAINCOLOR;
        _areaLB.font = Font12;
        _areaLB.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_areaLB];
        
        
        _areaBtn.sd_layout
        .leftEqualToView(_accoutBtn)
        .topSpaceToView(_accoutBtn, 12)
        .widthIs(90)
        .heightIs(17);
        
        _areaLB.sd_layout
        .leftSpaceToView(_areaBtn, 5)
        .topEqualToView(_areaBtn)
        .rightSpaceToView(self.contentView, 10)
        .autoHeightRatio(0);
    }
    
    
    
}

- (void)setModel:(MyteamModel *)model
{
    _model = model;
    _accoutLB.text = _model.content.username;
    

    NSMutableArray *locationArr = [[NSMutableArray alloc] init];
    for (Agent_location *loction in _model.content.agent_location) {
        NSString *loactionStr = [NSString stringWithFormat:@"%@%@%@%@",loction.province,loction.city,loction.district, loction.street];
        [locationArr addObject:loactionStr];
//        [locationArr addObject:loactionStr];
//
//        [locationArr addObject:loactionStr];
//
//        [locationArr addObject:loactionStr];
//
//        [locationArr addObject:loactionStr];

    }
    _areaLB.text = [locationArr componentsJoinedByString:@"      "];

    if ([KX_UserInfo sharedKX_UserInfo].agent_level.integerValue == 2) {
        [self setupAutoHeightWithBottomView:_areaLB bottomMargin:5];

    }else{
        [self setupAutoHeightWithBottomView:_accoutLB bottomMargin:12];

    }
    
}




@end
