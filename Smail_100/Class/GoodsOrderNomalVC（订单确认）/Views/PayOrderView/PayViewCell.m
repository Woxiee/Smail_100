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
}


- (void)setModel:(PayDetailModel *)model
{
    _model = model;
    titleLB.text = _model.title;
}

@end
