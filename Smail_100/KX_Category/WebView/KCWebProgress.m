//
//  KCWebProgress.m
//  KCJSTOOCDemo
//
//  Created by mac_JP on 17/1/6.
//  Copyright © 2017年 mac_JP. All rights reserved.
//

#import "KCWebProgress.h"
static NSTimeInterval const kFastTimeInterval = 0.03;

@interface KCWebProgress ()
@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat plusWidth;  // 线条分为无数个点，线条的增加点的宽度
@property (nonatomic,strong)UIColor *strokeEndColor;

@end
@implementation KCWebProgress


- (instancetype)initWithColor:(UIColor *)color{
    
    if (self = [super init]) {
        if (color) {
            self.strokeEndColor = color?color:[UIColor orangeColor];
        }
     
        [self initialize];
    }
    
    return self;
    
}


- (void)initialize {
    
    // 绘制贝赛尔曲线
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 3)];                // 起点
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH, 3)];  // 终点
    
    self.path = path.CGPath;
    self.strokeEnd = 0;
    _plusWidth = 0.005;
    
    self.lineWidth = 2;
    self.strokeColor = self.strokeEndColor.CGColor;// 设置进度条的颜色
 
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:kFastTimeInterval target:self selector:@selector(pathChanged:) userInfo:nil repeats:YES];
    [self pauseTime:_timer];
    
}

// 设置进度条增加的进度
- (void)pathChanged:(NSTimer *)timer {
    
    self.strokeEnd += _plusWidth;
    
    if (self.strokeEnd > 0.60) {
        _plusWidth = 0.002;
    }
    
    if (self.strokeEnd > 0.85) {
        _plusWidth = 0.0007;
    }
    
    if (self.strokeEnd > 0.93) {
        _plusWidth = 0;
    }
    
}

// 使用的是 WebView 在用KVO计算实际的读取进度时，调用该方法
- (void)KCWebViewPathChanged:(CGFloat)estimatedProgress {
    
    self.strokeEnd = estimatedProgress;
    
}

- (void)startLoad {
    [self webPageTimeWithTimeInterval:kFastTimeInterval timer:_timer];
 
    
}

- (void)finishedLoadWithError:(NSError *)error {
    
    CGFloat timer;
    
    if (error == nil) {
        [self closeTimer];
        timer = 0.5;
        self.strokeEnd = 1.0;
    }else {
        timer = 45.0;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timer * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (timer == 45.0) [self closeTimer];
        self.hidden = YES;
        [self removeFromSuperlayer];
    });
    
}
#pragma mark -
#pragma mark - private
- (void)closeTimer {
    
    [_timer invalidate];
    _timer = nil;
    
}

#pragma mark -
#pragma mark - 时间的处理

- (void)pauseTime:(NSTimer *)timer {
    
    if (!timer.isValid) return;     //  BOOL valid 获取定时器是否有效
    [timer setFireDate:[NSDate distantFuture]];  //停止定时器
    
}

- (void)webPageTime:(NSTimer *)timer {
    
    if (!timer.isValid) return;   // date方法返回的就是当前时间(now)
    [timer setFireDate:[NSDate date]];
    
}

- (void)webPageTimeWithTimeInterval:(NSTimeInterval)time timer:(NSTimer *)timer   {
    
    if (!timer.isValid) return;
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];   //返回当前时间10秒后的时间
    
}



- (void)dealloc {
    
    [self closeTimer];
    
}

@end
