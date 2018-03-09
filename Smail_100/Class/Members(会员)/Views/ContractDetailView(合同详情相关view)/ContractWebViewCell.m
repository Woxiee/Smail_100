//
//  ContractWebViewCell.m
//  MyCityProject
//
//  Created by Faker on 17/7/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "ContractWebViewCell.h"

@implementation ContractWebViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _webView.userInteractionEnabled = NO;
}

- (void)setModel:(ContracDetailModel *)model
{
    _model = model;
}


@end
