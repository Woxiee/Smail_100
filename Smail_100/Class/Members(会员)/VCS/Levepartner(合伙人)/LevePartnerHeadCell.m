//
//  LevePartnerHeadCell.m
//  Smail_100
//
//  Created by Faker on 2018/4/7.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "LevePartnerHeadCell.h"

@implementation LevePartnerHeadCell
{
    UILabel *contenLB;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    
    contenLB = [UILabel new ];
    contenLB.font = Font14;
    [self.contentView sd_addSubviews:@[contenLB]];
  
    
    contenLB.sd_layout
    .leftSpaceToView(self.contentView, 12)
    .rightSpaceToView(self.contentView, 12)
    .topSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);

}


- (void)setModel:(LevePartnerModel *)model
{
    _model = model;
    contenLB.text = _model.notice;
    
    [self setupAutoHeightWithBottomView:contenLB bottomMargin:10];
}



@end
