//
//  CZCountDownView.m
//  countDownDemo
//
//  Created by 孔凡列 on 15/12/9.
//  Copyright © 2015年 czebd. All rights reserved.
//

#import "FLCountDownView.h"
// label数量
#define labelCount 3
#define separateLabelCount 3
#define padding 5
@interface FLCountDownView (){
    // 定时器
    NSTimer *timer;
}
@property (nonatomic,strong)NSMutableArray *timeLabelArrM;
@property (nonatomic,strong)NSMutableArray *separateLabelArrM;
// day
@property (nonatomic,strong)UILabel *dayLabel;
// hour
@property (nonatomic,strong)UILabel *hourLabel;
// minues
@property (nonatomic,strong)UILabel *minuesLabel;
// seconds
@property (nonatomic,strong)UILabel *secondsLabel;

@end

@implementation FLCountDownView
// 创建单例
+ (instancetype)fl_shareCountDown{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FLCountDownView alloc] init];
    });
    return instance;
}

+ (instancetype)fl_countDown{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.dayLabel];
        [self addSubview:self.hourLabel];
        [self addSubview:self.minuesLabel];
        [self addSubview:self.secondsLabel];
        
        for (NSInteger index = 0; index < separateLabelCount; index ++) {
            UILabel *separateLabel = [[UILabel alloc] init];
            separateLabel.text = @"";
            separateLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:separateLabel];
            [self.separateLabelArrM addObject:separateLabel];
        }
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super initWithCoder:aDecoder]) {
//        [self addSubview:self.dayLabel];
        [self addSubview:self.hourLabel];
        [self addSubview:self.minuesLabel];
        [self addSubview:self.secondsLabel];
        
        for (NSInteger index = 0; index < separateLabelCount; index ++) {
            UILabel *separateLabel = [[UILabel alloc] init];
            separateLabel.text = @":";
            separateLabel.backgroundColor = [UIColor clearColor];
            separateLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:separateLabel];
            [self.separateLabelArrM addObject:separateLabel];
        }
    }
    return self;

}
- (void)setBackgroundImageName:(NSString *)backgroundImageName{
    _backgroundImageName = backgroundImageName;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:backgroundImageName]];
    imageView.frame = self.bounds;
    [self addSubview:imageView];
    //    [self bringSubviewToFront:imageView];
}

// 拿到外界传来的时间戳
- (void)setTimestamp:(NSInteger)timestamp{
    _timestamp = timestamp;
    if (_timestamp != 0) {
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        else{
            timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        }
    }
}

-(void)timer:(NSTimer*)timerr{
    _timestamp--;
    [self getDetailTimeWithTimestamp:_timestamp];
    if (_timestamp == 0) {
        [timer invalidate];
        timer = nil;
        // 执行block回调
        self.timerStopBlock();
    }
}

- (void)getDetailTimeWithTimestamp:(NSInteger)timestamp{
    NSInteger ms = timestamp;
    NSInteger ss = 1;
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    // 剩余的
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
//    NSLog(@"%zd日:%zd时:%zd分:%zd秒",day,hour,minute,second);
    
//    self.dayLabel.text = [NSString stringWithFormat:@"%zd天",day];
    self.hourLabel.text = [NSString stringWithFormat:@"%zd",hour];
    self.minuesLabel.text = [NSString stringWithFormat:@"%zd",minute];
    self.secondsLabel.text = [NSString stringWithFormat:@"%zd",second];
    
    
}

- (void)setIsLoast:(BOOL)isLoast
{
    _isLoast = isLoast;
    

}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 获得view的宽、高
    CGFloat viewH = self.frame.size.height - 20;
    // 单个label的宽高
    CGFloat pading = 12;

    CGFloat labelH = viewH;
    if (_isLoast) {
        self.hourLabel.font = KY_FONT(9);
        self.minuesLabel.font = KY_FONT(9);
        self.secondsLabel.font = KY_FONT(9);
        viewH = 25;
        pading = 5;
    }
    
    self.hourLabel.frame = CGRectMake(5, 10 ,labelH, labelH);
    self.minuesLabel.frame = CGRectMake(CGRectGetMaxX(self.hourLabel.frame)+pading , 10, labelH, labelH);
    self.secondsLabel.frame = CGRectMake(CGRectGetMaxX(self.minuesLabel.frame)+pading, 10, labelH, labelH);
    
  
  
    for (NSInteger index = 0; index < self.separateLabelArrM.count ; index ++) {
        UILabel *separateLabel = self.separateLabelArrM[index];
        if (index == 0) {
            separateLabel.frame = CGRectMake(CGRectGetMaxX(self.hourLabel.frame), 10, pading,labelH);
            
        }else if (index == 1){
            separateLabel.frame = CGRectMake(CGRectGetMaxX(self.minuesLabel.frame), 10, pading,labelH);
            
        }
        else{
            separateLabel.frame = CGRectMake(CGRectGetMaxX(self.minuesLabel.frame), 10, 0,0);
            
        }
        
        if (_isLoast) {
            separateLabel.font = KY_FONT(9);;
        }
    }
}


#pragma mark - setter & getter

- (NSMutableArray *)timeLabelArrM{
    if (_timeLabelArrM == nil) {
        _timeLabelArrM = [[NSMutableArray alloc] init];
    }
    return _timeLabelArrM;
}

- (NSMutableArray *)separateLabelArrM{
    if (_separateLabelArrM == nil) {
        _separateLabelArrM = [[NSMutableArray alloc] init];
    }
    return _separateLabelArrM;
}

- (UILabel *)dayLabel{
    if (_dayLabel == nil) {
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        //        _dayLabel.backgroundColor = [UIColor grayColor];
    }
    return _dayLabel;
}

- (UILabel *)hourLabel{
    if (_hourLabel == nil) {
        _hourLabel = [[UILabel alloc] init];
        _hourLabel.textAlignment = NSTextAlignmentCenter;
        _hourLabel.backgroundColor = [UIColor blackColor];
        _hourLabel.textColor = [UIColor whiteColor];
        [_hourLabel layerForViewWith:3 AndLineWidth:0];

    }
    return _hourLabel;
}

- (UILabel *)minuesLabel{
    if (_minuesLabel == nil) {
        _minuesLabel = [[UILabel alloc] init];
        _minuesLabel.textAlignment = NSTextAlignmentCenter;
        _minuesLabel.backgroundColor = [UIColor blackColor];
        _minuesLabel.textColor = [UIColor whiteColor];
        [_minuesLabel layerForViewWith:3 AndLineWidth:0];

    }
    return _minuesLabel;
}

- (UILabel *)secondsLabel{
    if (_secondsLabel == nil) {
        _secondsLabel = [[UILabel alloc] init];
        _secondsLabel.textAlignment = NSTextAlignmentCenter;
        _secondsLabel.textColor = [UIColor whiteColor];
        _secondsLabel.backgroundColor = [UIColor blackColor];
        [_secondsLabel layerForViewWith:3 AndLineWidth:0];

    }
    return _secondsLabel;
}

-(void)stop
{
    [timer invalidate];
    timer = nil;
}

@end
