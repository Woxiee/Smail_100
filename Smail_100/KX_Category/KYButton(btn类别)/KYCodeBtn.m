//
//  KYCodeBtn.m
//  MyCityProject
//
//  Created by Faker on 17/7/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "KYCodeBtn.h"
@interface KYCodeBtn ()<UITextFieldDelegate>
@property (nonatomic,strong)NSTimer  *timer;

@end

@implementation KYCodeBtn

- (void)timeRun:(void(^)(int count))timeBlock
{
    __block int i = 60;//设置最大时间
    __weak typeof(self) b_self = self;
    self.enabled = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        i--;
        [b_self setTitle:[NSString stringWithFormat:@"重新获取(%is)",i] forState:UIControlStateDisabled];
        
        if (i==0) {
            [b_self stopTime];
            timeBlock(i);

        }
        
    }];
}


- (void)stopTime
{
    if (_timer) {
        self.enabled = YES;
        [_timer invalidate];
        _timer = nil;
    }
    
}

@end
