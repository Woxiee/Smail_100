//
//  LoadingTableFootView.m
//  MyCityProject
//
//  Created by Faker on 17/5/16.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "LoadingTableFootView.h"

@implementation LoadingTableFootView

- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/// 初始化视图
- (void)setup
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    bgView.backgroundColor = BACKGROUND_COLOR;
    [self addSubview:bgView];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    moreBtn.frame = CGRectMake(0, 10, SCREEN_WIDTH, 45);
    [moreBtn setTitle:@"上拉查看详情" forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"44@3x.png"] forState:UIControlStateNormal];
    [moreBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:3];
    [moreBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    moreBtn.titleLabel.font = PLACEHOLDERFONT;
    moreBtn.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:moreBtn];
    
}


@end
