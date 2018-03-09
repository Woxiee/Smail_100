//
//  KYProgramTimeView.m
//  CRM
//
//  Created by Frank on 17/1/6.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "KYProgramTimeView.h"

@interface  KYProgramTimeView ()
@property(nonatomic, strong)   UIImageView *bgImageView;            /// 背景图片
@property (nonatomic, strong)  UIImageView *timeCountImageView;     /// 进度条背景
@property(nonatomic, strong)   UILabel *presentlab;                 /// 计时栏
@property (nonatomic, weak  ) NSTimer  *countTimer;   /// 计时器
@property (nonatomic, assign)  int timeCout;        /// 次数
@end

@implementation KYProgramTimeView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self configuration];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
        [self configuration];
    }
    return self;
}


/// 初始化视图
- (void)setup
{
    _bgImageView = [[UIImageView alloc] init];
    [self addSubview:_bgImageView];
    _timeCountImageView = [[UIImageView alloc] init];
    [_bgImageView addSubview:_timeCountImageView];
    
    _presentlab = [[UILabel alloc] init];
    _presentlab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_presentlab];
}


/// 初始化 frame
- (void)layoutSubviews
{
    _bgImageView.frame = CGRectMake(0, 0, self.frame.size.width - 50, self.frame.size.height);
    _timeCountImageView.frame = CGRectMake(0, 0, 0, self.frame.size.height);
    _presentlab.frame = CGRectMake(CGRectGetMaxX(_bgImageView.frame) + 10, 0, 50,  self.frame.size.height);
}


#pragma mark - public
/// 开始执行动画
- (void)programTimeStart
{
    if (!_countTimer) {
        _countTimer =[NSTimer scheduledTimerWithTimeInterval:self.timeInterval? self.timeInterval :0.1
                                                      target:self
                                                    selector:@selector(startTimer)
                                                    userInfo:nil
                                                     repeats:YES];
    }
}

// 停止计时执行动画
-(void)programTimerEnd
{
    [_countTimer invalidate];
}


/// 开始计时
- (void)startTimer
{
    _timeCout ++;
    if (_timeCout<= _defuleValue) {
        _presentlab.text = [NSString stringWithFormat:@"%d％",_timeCout];
        _timeCountImageView.frame = CGRectMake(0, 0, (self.frame.size.width-50)/self.maxValue*_timeCout, self.frame.size.height);
    }else
    {
        [_countTimer invalidate];
        _countTimer = nil;
        _timeCout = 0;
    }
}



#pragma mark - private
/// 默认配置
- (void)configuration
{
    _bgImageView.backgroundColor = [UIColor whiteColor];
    _timeCountImageView.backgroundColor = [UIColor grayColor];
    _presentlab.textColor = [UIColor blueColor];
    _presentlab.font = [UIFont systemFontOfSize:15];
    
}



#pragma mark - setting & getting
- (void)setDefuleValue:(float)defuleValue
{
    _defuleValue = defuleValue;
}

- (void)setBgViewColor:(UIColor *)bgViewColor
{
    _bgViewColor = bgViewColor;
    _bgImageView.backgroundColor  = _bgViewColor;
    
}

- (void)setPresentColor:(UIColor *)presentColor
{
    _presentColor = presentColor;
    _presentlab.textColor = _presentColor;
}


-(void)setProgramColor:(UIColor *)programColor
{
    _programColor = programColor;
    
    _timeCountImageView.backgroundColor = _programColor;
    
}

- (void)setPresentLabFont:(CGFloat)presentLabFont
{
    _presentLabFont = presentLabFont;
    _presentlab.font = [UIFont systemFontOfSize:_presentLabFont];
}

-(void)setTimeInterval:(CGFloat)timeInterval
{
    _timeInterval = timeInterval;
}


@end
