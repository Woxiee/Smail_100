//
//  KX_ApprovalContentCell.m
//  KX_Service
//
//  Created by kechao wu on 16/9/6.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import "KX_ApprovalContentCell.h"

@implementation KX_ApprovalContentCell
{
    __weak IBOutlet UIView *lineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    lineView.backgroundColor = LINECOLOR;
    _titleLabel.textColor = DETAILTEXTCOLOR;

}



@end
