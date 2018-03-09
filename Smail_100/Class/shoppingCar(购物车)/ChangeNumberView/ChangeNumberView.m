//
//  ChangeNumberView.m
//  ShiShi
//
//  Created by Faker on 17/4/13.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "ChangeNumberView.h"
@interface ChangeNumberView()
@property (nonatomic, weak) UIView *darkView;
@property (nonatomic, strong) UIView *bottomView;

@end


@implementation ChangeNumberView


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
    UIView *darkView                = [[UIView alloc] init];
    darkView.userInteractionEnabled = YES;
    darkView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    darkView.backgroundColor        = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:darkView];
    self.darkView = darkView;
    
    UITapGestureRecognizer  *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheetView)];
    [self.darkView addGestureRecognizer:tapGestureRecognizer];
    
    
    UIView *bottomView = [[UIView alloc] init];

    bottomView.frame = CGRectMake(0,0, SCREEN_WIDTH *0.8,SCREEN_WIDTH *0.8);
    bottomView.center = darkView.center;
    bottomView.backgroundColor  = [UIColor whiteColor];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
}

/// 出现
- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}


/// 消失
- (void)hiddenSheetView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        //        CGRect bgRect =  weakSelf.darkView.frame;
        //        CGRect chooseMenuRect =  weakSelf.contenView.frame;
        //        bgRect.origin.x= SCREEN_WIDTH;
        //        chooseMenuRect  = CGRectMake(SCREEN_WIDTH +40, 0, SCREEN_WIDTH- 40, SCREEN_HEIGHT);
        //        weakSelf.darkView.frame = bgRect;
        //        weakSelf.contenView.frame = chooseMenuRect;
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
    }];
}

@end
