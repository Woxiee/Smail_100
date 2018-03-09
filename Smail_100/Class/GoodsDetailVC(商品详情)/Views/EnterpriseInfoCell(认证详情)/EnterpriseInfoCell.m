//
//  EnterpriseInfoCell.m
//  MyCityProject
//
//  Created by Faker on 17/6/28.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "EnterpriseInfoCell.h"

@implementation EnterpriseInfoCell
{
    UILabel *_titleLB;
    UIView *bgView;

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
    bgView= [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    [bgView layerForViewWith:1 AndLineWidth:0.5];

    _titleLB = [UILabel new];
    
    _titleLB.textColor = DETAILTEXTCOLOR;
    _titleLB.font = PLACEHOLDERFONT;
    [self.contentView addSubview:_titleLB];

    _titleLB.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView (self.contentView, 12)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);

}



-(void)setModel:(MemberModel *)model
{
    
    _model = model;


    _titleLB.text = _model.business.remark;
    bgView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 12, 0, 12));


    [self setupAutoHeightWithBottomView:_titleLB bottomMargin:12];


    
}
@end
