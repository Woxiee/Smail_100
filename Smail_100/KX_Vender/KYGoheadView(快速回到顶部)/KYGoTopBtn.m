//
//  KYGoTopBtn.m
//  ShiShi
//
//  Created by Faker on 17/3/24.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "KYGoTopBtn.h"

@implementation KYGoTopBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /// gotop.png  最好写在内部
        [self setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    return self;
}

@end
