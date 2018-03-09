//
//  SZCalendarCell.m
//  SZCalendarPicker
//
//  Created by Stephen Zhuang on 14/12/1.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SZCalendarCell.h"

@implementation SZCalendarCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_dateLabel setTextAlignment:NSTextAlignmentCenter];
    [_dateLabel setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:_dateLabel];

    
}
@end
