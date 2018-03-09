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
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setModel:(PayDetailModel *)model
{
    _model = model;
    _numberTextFied.placeholder  = @"当前可兑换积分42323";
}


- (void)setup
{
    
}


@end
