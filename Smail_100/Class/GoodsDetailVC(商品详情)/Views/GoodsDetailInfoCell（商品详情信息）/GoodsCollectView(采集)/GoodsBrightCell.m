//
//  GoodsBrightCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/16.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsBrightCell.h"

@implementation GoodsBrightCell
{
    UILabel *_titleLB;
    
    UILabel *_detailLB;
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
    _titleLB = [UILabel new];
    _titleLB.textColor = DETAILTEXTCOLOR;
    _titleLB.font = PLACEHOLDERFONT;
    
    _detailLB = [UILabel new];
    _detailLB.textColor = DETAILTEXTCOLOR;
    _detailLB.font = Font13;
    
    [self.contentView sd_addSubviews:@[_titleLB,_detailLB]];
    
    _titleLB.sd_layout
    .leftSpaceToView(self.contentView, 12)
    .topSpaceToView(self.contentView, 10)
    .widthIs(80)
    .heightIs(20);
    
    _detailLB.sd_layout
    .leftSpaceToView(_titleLB, 6)
    .topSpaceToView(self.contentView, 12)
    .rightSpaceToView(self.contentView, 12)
    .autoHeightRatio(0);
}



- (void)setModel:(GroupBuyResult *)model
{
    _model = model;
    _titleLB.text = @"集采亮点";
    _detailLB.text = _model.introduce;
    [self setupAutoHeightWithBottomView:_detailLB bottomMargin:10];

}




@end
