//
//  ActivityView.m
//  Smile_100
//
//  Created by Faker on 2018/2/20.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "ActivityView.h"
@interface ActivityView()
@property (nonatomic, weak) UIView *darkView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ActivityView


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
    
//    UIView *bottomView = [[UIView alloc] init];
//    bottomView.frame = CGRectMake(0, SCREEN_HEIGHT  - 200, SCREEN_WIDTH,200);
//    bottomView.backgroundColor  = [UIColor whiteColor];
//    [self addSubview:bottomView];
//    self.bottomView = bottomView;
    
     UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH *0.7, SCREEN_WIDTH *0.7)];
    [self addSubview:imageView];
    
    self.imageView = imageView;


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
