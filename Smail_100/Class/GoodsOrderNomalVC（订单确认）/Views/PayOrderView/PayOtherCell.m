//
//  PayOtherCell.m
//  JXActionSheet
//
//  Created by ap on 2018/3/9.
//  Copyright © 2018年 JX.Wang. All rights reserved.
//

#import "PayOtherCell.h"

@implementation PayOtherCell
{
    __weak IBOutlet UIImageView *markImgaeView;
    
    __weak IBOutlet UIImageView *iconImageView;
    
    __weak IBOutlet UILabel *commLb;
    __weak IBOutlet UIView *lineview;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setModel:(PayDetailModel *)model
{
    _model = model;
    _numberTextFied.placeholder  = @"当前可兑换积分42323";
    
    if (!_model.isSelect) {
        markImgaeView.image = [UIImage imageNamed:@"zhuce2@3x.png"];
    }else{
        markImgaeView.image = [UIImage imageNamed:@"23@3x.png"];
    }
    iconImageView.image = [UIImage imageNamed:_model.icon];

}

- (void)setUserInfo:(Userinfo *)userInfo
{
    _userInfo = userInfo;
    self.numberTextFied.placeholder = [NSString stringWithFormat:@"您当前可兑换积分为%@",_userInfo.point];
}

- (void)setup
{
    lineview.backgroundColor = LINECOLOR;
    commLb.textColor = KMAINCOLOR;
}


@end
