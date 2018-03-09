//
//  MerchantHeadView.m
//  Smile_100
//
//  Created by ap on 2018/2/26.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MerchantHeadView.h"
@interface MerchantHeadView()


@end

@implementation MerchantHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}



- (void)setup
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    headView.backgroundColor = KMAINCOLOR;
    [self addSubview:headView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame)- 30, SCREEN_WIDTH, 190)];
    imageView.image = [UIImage imageNamed:@"shangjiazhongxin14@3x.png"];
    [self addSubview:imageView];

    
}


@end
