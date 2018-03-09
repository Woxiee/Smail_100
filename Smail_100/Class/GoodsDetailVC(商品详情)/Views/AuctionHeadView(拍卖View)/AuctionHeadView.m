//
//  AuctionHeadView.m
//  MyCityProject
//
//  Created by Faker on 17/6/29.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "AuctionHeadView.h"
#import "FLCountDownView.h"

@implementation AuctionHeadView
{
    UIView *_bgView;
    UIImageView *_bgImgeView;
    FLCountDownView *_timeView;
    UILabel *_titleLB1;
    UILabel *_titleLB2;

}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self setConfiguration];
    }
    return self;
}


/// 初始化视图
- (void)setup
{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    
    _bgImgeView = [[UIImageView alloc] init];
    _bgImgeView.frame = CGRectMake(0, 0, 84, 40);
    [self addSubview:_bgImgeView];

    _timeView = [FLCountDownView fl_countDown];;
    _timeView.frame = CGRectMake(CGRectGetMaxX(_bgImgeView.frame), 0,160,40);
    _timeView.center = self.center;
    WEAKSELF
    _timeView.timerStopBlock  = ^{
        NSLog(@"时间停止");
        if (weakSelf.didEndTimeBlock) {
            weakSelf.didEndTimeBlock();
        }
    };
    [self addSubview:_timeView];
    
    _titleLB1 = [[UILabel alloc] init];
    _titleLB1.frame = CGRectMake(CGRectGetMaxX(_timeView.frame) + 10, 0, 150, 40);
    _titleLB1.textColor = DETAILTEXTCOLOR;
    [self addSubview:_titleLB1];
    
    _titleLB2 = [[UILabel alloc] init];
    _titleLB2.frame =CGRectMake(CGRectGetMaxX(_bgImgeView.frame), 0,130,40);
    _titleLB2.font =  [UIFont systemFontOfSize:15];
    _titleLB2.textAlignment = NSTextAlignmentLeft;
    _titleLB2.center = self.center;
    [self addSubview:_titleLB2];
    
}


/// 配置基础设置
- (void)setConfiguration
{
    
}



- (void)setModel:(GoodSDetailModel *)model
{
    _model = model;
    ///  1尚未开始  2 正在拍卖  4 已结成交
    if ([_model.status integerValue] == 1) {
        _bgImgeView.image = [UIImage imageNamed:@"59@3x.png"];
        _timeView.hidden = YES;
        _titleLB2.frame =CGRectMake(CGRectGetMaxX(_bgImgeView.frame) +10, 0,SCREEN_WIDTH - CGRectGetMaxX(_bgImgeView.frame) -24,40);

        _titleLB2.text = _model.startTime;
        _titleLB1.text = @"开始";
    }
    else if ([_model.status integerValue] == 2){
        _bgImgeView.image = [UIImage imageNamed:@"52@3x.png"];
        _timeView.timestamp = [_model.timestamp intValue]/1000;
        _titleLB1.text = @"后结束";
    }else{
        _bgImgeView.image = [UIImage imageNamed:@"yijingchengjiao.png"];
        _timeView.hidden = YES;
        _titleLB2.text = [NSString stringWithFormat:@"成交企业：%@",_model.findCompanyName];
        _titleLB2.frame =CGRectMake(CGRectGetMaxX(_bgImgeView.frame) +10, 0,SCREEN_WIDTH - CGRectGetMaxX(_bgImgeView.frame) -24,40);
    }
    
}

- (void)stopTimer
{
    [_timeView stop];
}

@end
