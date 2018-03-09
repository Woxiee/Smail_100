//
//  KYDatePickView.m
//  TestCell
//
//  Created by Frank on 17/1/7.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "KYDatePickView.h"
#import "NSString+Extension.h"

@implementation KYDatePickView
{
    UIView *_dateBgView;   /// 底部栏
    UIView *_topView;      /// 顶部栏 .标题 取消  确定 等
    UILabel *_titleLabel;  /// title
    UIButton *_sureBtn;    /// 确定
    UIButton *_cancelBtn;  /// 取消
    UIDatePicker *_datePicker; /// 时间选择器
    NSDateFormatter* _formater;
    NSString *_dateStr;   /// 当前选择时间
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self configuration];
    }
    return self;
}

-  (instancetype)initWithCoder:(NSCoder *)aDecoder
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
    /// 时间选择器
    _dateBgView = [[UIView alloc] init];
    _dateBgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_dateBgView];

    /// 顶部视图
    _topView = [UIView new];
    [_dateBgView addSubview:_topView];
    
    /// 标题
    _titleLabel = [UILabel new];
    _titleLabel.text = @"选择时间";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    [_topView addSubview:_titleLabel];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.tag = 100;
     _sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
     [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(pressentPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_sureBtn];

    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
      _cancelBtn.tag = 101;
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(pressentPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_cancelBtn];

    _datePicker=[[UIDatePicker alloc] init];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate *currentDate = [NSDate date];
    self.date = currentDate;
    _formater = [[NSDateFormatter alloc] init];
    [_formater setDateFormat:@"yyyy-MM-dd"];
    [_dateBgView addSubview: _datePicker];
    [_datePicker addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
}

/// 默认配置
- (void)configuration
{
    _dateStr = [_formater stringFromDate:self.date];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

}

/// 显示
- (void)showDataPicKView
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}


- (void)layoutSubviews
{
    _dateBgView.frame =  CGRectMake(0, self.frame.size.height - 256, self.frame.size.width, 256);
    _topView.frame = CGRectMake(0, 0, self.frame.size.width, 45);
    _titleLabel.frame = CGRectMake(0, 0, self.frame.size.width -120, 45);
       _titleLabel.center = _topView.center;
    _sureBtn.frame = CGRectMake(_dateBgView.bounds.size.width - 50, 0, 40, 45);
    _cancelBtn.frame = CGRectMake(10, 0, 45, 45);
    _datePicker.frame = CGRectMake(0, 40, self.frame.size.width, 216);
}



#pragma mark - private
///  确定 & 取消
- (void)pressentPickerView:(UIButton *)sender
{
  BOOL isOK  =  [NSString compareOneDay:_dateStr withAnotherDay:[_formater stringFromDate:self.date]];
    if (self.datePickViewType ==  KYDatePickViewTypeNomal) {
        isOK = NO;
    }
    else if(self.datePickViewType == KYDatePickViewTypeAscending)
    {
 
    }
    else if(self.datePickViewType == KYDatePickViewTypeDescending)
    {
         isOK = NO;
    }
    
    
    if (!isOK) {
        if (sender == _sureBtn ) {
            self.completeBlock(_dateStr);
        }
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.frame.size.width, self.frame.size.height);
            weakSelf.alpha = 0.0;
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
        }];

    }else{
        [self toastShow:@"不能选择小于今天的时间~"];
    }
    
    if (sender ==_cancelBtn) {
        self.completeBlock(@"");
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.frame.size.width, self.frame.size.height);
            weakSelf.alpha = 0.0;
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
            
        }];

    }
}


/// 时间选择
-(void)selectDate:(id)sender {
    
    _dateStr =[_formater stringFromDate:_datePicker.date];
    
}

#pragma mark  - getting & setting
/// 最小
- (void)setMinYear:(NSInteger)minYear
{
    _maxYear = minYear;
    NSString *tempStr = [_formater stringFromDate:self.date];
    NSArray *dateArray = [tempStr componentsSeparatedByString:@"-"];
    //设置日期选择器最大可选日期
    if (self.maxYear) {
        NSInteger maxYear = [dateArray[0] integerValue] - self.maxYear;
        NSString *maxStr = [NSString stringWithFormat:@"%ld-%@-%@",maxYear,dateArray[1],dateArray[2]];
        NSDate *maxDate = [_formater dateFromString:maxStr];
        _datePicker.maximumDate = maxDate;
    }

}

/// 最大
- (void)setMaxYear:(NSInteger)maxYear
{
    //设置日期选择器最大可选日期
    if (self.maxYear) {
        NSString *tempStr = [_formater stringFromDate:self.date];
        NSArray *dateArray = [tempStr componentsSeparatedByString:@"-"];
        NSInteger maxYear = [dateArray[0] integerValue] - self.maxYear;
        NSString *maxStr = [NSString stringWithFormat:@"%ld-%@-%@",maxYear,dateArray[1],dateArray[2]];
        NSDate *maxDate = [_formater dateFromString:maxStr];
        _datePicker.maximumDate = maxDate;
    }
}

/// 当前日期
- (void)setDate:(NSDate *)date
{
    _date = date;
    _dateStr = [_formater stringFromDate:self.date];
    _datePicker.date = self.date;
}


/// 时间格式
- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode
{
    _datePickerMode =datePickerMode;
    _datePicker.datePickerMode = _datePickerMode;
    if (_datePickerMode == UIDatePickerModeTime) {
            [_formater setDateFormat:@"HH:ss"];
    }else{
        [_formater setDateFormat:@"yyyy-MM-dd"];
    }
    
}
/** 时间选择类型 */
- (void)setDatePickViewType:(KYDatePickViewType)datePickViewType
{
    _datePickViewType = datePickViewType;
    
}

@end
