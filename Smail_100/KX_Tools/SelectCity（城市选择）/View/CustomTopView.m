//
//  CustomTopView.m
//  MySelectCityDemo
//
//  Created by 李阳 on 15/9/1.
//  Copyright (c) 2015年 WXDL. All rights reserved.
//

#import "CustomTopView.h"

@implementation CustomTopView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = BACKGROUND_COLORHL;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 33, 12, 20)];
       // [btn setTitle:@"返回"  forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"18@3x.png" ] forState:0];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self addSubview:btn];
        
        UIButton *bt1n = [[UIButton alloc] initWithFrame:CGRectMake(10, 33, 50, 44)];
        // [btn setTitle:@"返回"  forState:UIControlStateNormal];
        [bt1n setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [bt1n addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bt1n];
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.center = CGPointMake(frame.size.width/2, (frame.size.height/2)+10);
        label.bounds = CGRectMake(0, 0, 100, 30);
        label.text = @"选择城市";
        label.font = [UIFont systemFontOfSize:19];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
    
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        lineView.backgroundColor = LINECOLOR;
        [self addSubview:lineView];
    }
    return self;
}
-(void)click
{
    if([_delegate respondsToSelector:@selector(didSelectBackButton)])
    {
        [_delegate didSelectBackButton];
    }
}
@end
