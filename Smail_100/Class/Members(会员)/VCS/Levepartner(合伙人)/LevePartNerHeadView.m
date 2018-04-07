//
//  LevePartNerHeadView.m
//  Smail_100
//
//  Created by Faker on 2018/4/7.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "LevePartNerHeadView.h"

@implementation LevePartNerHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 17)];
    _titleLB.textColor = KMAINCOLOR;
    _titleLB.font = Font15;
    _titleLB.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLB];
    
    _detailLB = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLB.frame), SCREEN_WIDTH, 17)];
    _detailLB.textColor = DETAILTEXTCOLOR1;
    _detailLB.font = Font14;
    _detailLB.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_detailLB];
    
//    _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _detailBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
//    _detailBtn.titleLabel.font =  Font15;
//    [_detailBtn setTitleColor:KMAINCOLOR forState:UIControlStateNormal];
//    [self addSubview:_detailBtn];
    
}


@end
