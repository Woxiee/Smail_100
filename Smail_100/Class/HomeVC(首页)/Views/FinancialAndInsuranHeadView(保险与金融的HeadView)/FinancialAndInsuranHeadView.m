//
//  FinancialAndInsuranHeadView.m
//  MyCityProject
//
//  Created by Faker on 17/5/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "FinancialAndInsuranHeadView.h"

@interface FinancialAndInsuranHeadView ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation FinancialAndInsuranHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}


/// 初始化视图
- (void)setup
{
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT *0.4)];
    [self addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconImageView.frame), SCREEN_WIDTH, 40)];
    _titleLabel.text = @"30秒快速免费申请";
    _titleLabel.backgroundColor = BACKGROUND_COLOR;
    _titleLabel.font = Font15;
    [self addSubview:_titleLabel];
    
    
    
                   
}

@end
