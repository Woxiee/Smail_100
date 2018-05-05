//
//  CustomAlertView.m
//  CustomAlertView
//
//  Created by 丁宗凯 on 16/6/22.
//  Copyright © 2016年 dzk. All rights reserved.
//

#import "CustomAlertView.h"

#define AlertViewJianGe 19.5
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width            // 屏幕宽
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height          // 屏幕高
#define SCREEN_PRESENT [[UIScreen mainScreen] bounds].size.width/375.0  // 屏幕宽高比例
#define DarkGrayColor [UIColor colorWithRGB:0x333333]     // 深灰色
#define WhiteColor  [UIColor whiteColor]                  // 白色
#define LightGrayColor [UIColor colorWithRGB:0x999999]    // 浅灰色

#define cornerRadiusView(View, Radius) \
\
[View.layer setCornerRadius:(Radius)];           \
[View.layer setMasksToBounds:YES]

#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ColorAlphe(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// 随机色
#define RandomColor Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@implementation CustomAlertView

-(instancetype)initWithAlertViewHeight:(CGFloat)height
{
    self=[super init];
    if (self) {
        if (self.bGView==nil) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
            view.backgroundColor = [UIColor blackColor];
            
            view.alpha = 0.5;
         
            [[UIApplication sharedApplication].keyWindow addSubview:view];
            UITapGestureRecognizer *tagGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
            [view addGestureRecognizer:tagGesture];
               self.bGView =view;
        }
        
        self.frame = CGRectMake(25,(SCREEN_HEIGHT - height)/2 ,SCREEN_WIDTH - 100,height);
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        //中间弹框的view
        UIView *popView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH - 50,height)];
        popView.backgroundColor = [UIColor clearColor];
        cornerRadiusView(popView, 5);
        [self addSubview:popView];
        
       
        
        UIImageView *meetImage =[[UIImageView alloc] init];
        meetImage.image = [UIImage imageNamed:@"zhanghuguanli8@2x.png"];
        meetImage.frame = CGRectMake(0,0,SCREEN_WIDTH - 50,height);
        cornerRadiusView(popView, 5);
        meetImage.userInteractionEnabled = YES;
        [self addSubview:meetImage];
        
       
        UIButton *calendarBtn = [UIButton new];
        calendarBtn.tag =100;
        calendarBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 100);
        calendarBtn.backgroundColor = [UIColor clearColor];
        [meetImage addSubview:calendarBtn];
        [calendarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        calendarBtn.layer.shadowOffset =  CGSizeMake(1, 1);
        calendarBtn.layer.shadowOpacity = 0.8;
        calendarBtn.layer.shadowColor =  [UIColor blackColor].CGColor;
        calendarBtn.layer.cornerRadius= 5;
        [calendarBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

//
        UIButton *knowBtn = [UIButton new];
        knowBtn.backgroundColor = [UIColor clearColor];
        knowBtn.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 100);

        [meetImage addSubview:knowBtn];
        
        knowBtn.tag =101;
//        [knowBtn setTitle:@"知道了" forState:UIControlStateNormal];
        [knowBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [knowBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self show:YES];

    }
    return self;
}
-(void)buttonClick:(UIButton*)button
{
    [self hide:YES];
    if (self.ButtonClick) {
        self.ButtonClick(button);
    }
}

- (void)hidden
{
    [self hide:YES];

}
- (void)show:(BOOL)animated
{
    if (animated)
    {
        self.transform = CGAffineTransformScale(self.transform,0,0);
        __weak CustomAlertView *weakSelf = self;
        [UIView animateWithDuration:.3 animations:^{
            weakSelf.transform = CGAffineTransformScale(weakSelf.transform,1.2,1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.3 animations:^{
                weakSelf.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

- (void)hide:(BOOL)animated
{
    [self endEditing:YES];
    if (self.bGView != nil) {
        __weak CustomAlertView *weakSelf = self;
        
        [UIView animateWithDuration:animated ?0.3: 0 animations:^{
            weakSelf.transform = CGAffineTransformScale(weakSelf.transform,1,1);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration: animated ?0.3: 0 animations:^{
                weakSelf.transform = CGAffineTransformScale(weakSelf.transform,0.2,0.2);
            } completion:^(BOOL finished) {
                [weakSelf.bGView removeFromSuperview];
                [weakSelf removeFromSuperview];
                weakSelf.bGView=nil;
            }];
        }];
    }
    
}

@end
