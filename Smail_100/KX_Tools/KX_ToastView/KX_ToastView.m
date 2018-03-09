//
//  KX_ToastView.m
//  KX_Service
//
//  Created by ac on 16/8/3.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import "KX_ToastView.h"
#import "NSString+Extension.h"

@interface KX_ToastView()
@property (weak, nonatomic, readwrite) UILabel *title;
@end

@implementation KX_ToastView

+(instancetype)toastWithString:(NSString *)textStr
{
    return [[self alloc] initToastWithString:textStr];
}

- (instancetype)initToastWithString:(NSString *)textStr
{
    self = [super init];
    if (self) {
        CGFloat width = SCREEN_WIDTH;
        CGFloat height = SCREEN_HEIGHT;
        
        // MAXFLOAT  自动计算最高高度
        CGSize textMaxSize= CGSizeMake(width - 60, MAXFLOAT);
        
        CGSize stringSize =  [textStr sizeWithFont:[UIFont boldSystemFontOfSize:16] maxSize:textMaxSize];
        
        CGFloat finalY = (height - 10 - stringSize.height) * 0.8;
        CGRect fra = CGRectMake((width - stringSize.width - 40) * 0.5, finalY, stringSize.width + 40, 20 + stringSize.height);
        
        [self setFrame:CGRectMake((width - stringSize.width - 40) * 0.5, finalY+30, stringSize.width + 40, 20 + stringSize.height)];
        
        //添加文字说明
        UILabel *title = [[UILabel alloc] init];
        [self addSubview:title];
        [title setText:textStr];
        title.numberOfLines = 0;
        [title setTextColor:RGB(220, 220, 220)];
        [title setFont:[UIFont systemFontOfSize:14]];
        title.textAlignment = NSTextAlignmentCenter;
        self.title = title;
        self.backgroundColor = [UIColor blackColor];
        
        CGRect titleFrame = self.bounds;
        titleFrame.origin.x += 10;
        titleFrame.origin.y += 5;
        titleFrame.size.width -= 20;
        titleFrame.size.height -= 10;
        [self.title setFrame:titleFrame];
        
        [self layerForViewWith:10 AndLineWidth:1.0];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        self.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];

        //上移动画
        CGRect finalRect = fra;
        finalRect.origin.y += 5;
        [UIView animateWithDuration:0.2 animations:^{
            [self setFrame:fra];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                [self setFrame:finalRect];
            }];
        }];
        
    }
    
    return self;
}


+(CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y //纵向移动
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.toValue=y;
    animation.duration=time;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}


- (void)finish
{
    [self removeFromSuperview];
    [self.window  removeFromSuperview];
}

@end
