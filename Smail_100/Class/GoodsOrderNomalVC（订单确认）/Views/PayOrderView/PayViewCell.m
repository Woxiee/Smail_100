//
//  PayViewCell.m
//  JXActionSheet
//
//  Created by ap on 2018/3/9.
//  Copyright © 2018年 JX.Wang. All rights reserved.
//

#import "PayViewCell.h"

@implementation PayViewCell
{
    __weak IBOutlet UIImageView *markImgaeView;
    __weak IBOutlet UIImageView *iconImageView;
    __weak IBOutlet UILabel *titleLB;
    
    __weak IBOutlet UIView *lineView;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    lineView.backgroundColor = LINECOLOR;
    titleLB.textColor = DETAILTEXTCOLOR;
}

- (void)setModel:(PayDetailModel *)model
{
    _model = model;
    titleLB.text = _model.title;
    if (!_model.isSelect) {
        markImgaeView.image = [UIImage imageNamed:@"zhuce2@3x.png"];
    }else{
        markImgaeView.image = [UIImage imageNamed:@"23@3x.png"];
    }
    iconImageView.image = [UIImage imageNamed:_model.icon];
}

@end
