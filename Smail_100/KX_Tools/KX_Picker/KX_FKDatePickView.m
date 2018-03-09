//
//  KX_FKDatePickView.m
//  KX_Service
//
//  Created by kechao wu on 16/8/31.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import "KX_FKDatePickView.h"

@interface KX_FKDatePickView()
{
    NSString *_dateStr;
}
@property(strong, nonatomic) UIDatePicker *hmDatePicker;
@end

@implementation KX_FKDatePickView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.227 alpha:0.5];
        //        [self createPickerView];
    }
    return self;
}


#pragma mark -- 选择器
- (void)configuration {
    //时间选择器
    UIView *dateBgView = [[UIView alloc] initWithFrame:self.bounds];
    dateBgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:dateBgView];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor colorWithWhite:0.957 alpha:1.000];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
    [dateBgView addSubview:bgView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH -120, 45);
    titleLabel.text = @"选择时间";
    titleLabel.center = bgView.center;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    [bgView addSubview:titleLabel];
    
    //确定按钮
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(dateBgView.bounds.size.width - 50, 0, 40, 45);
    commitBtn.tag = 1;
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(pressentPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:commitBtn];
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10, 0, 45, 45);
    cancelBtn.tag = 0;
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(pressentPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancelBtn];
    
    
    UIDatePicker *datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 38, [UIScreen mainScreen].bounds.size.width, self.frame.size.height - 38)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate *currentDate = [NSDate date];
    
    if (self.fontColor) {
        [commitBtn setTitleColor:self.fontColor forState:UIControlStateNormal];
        [cancelBtn setTitleColor:self.fontColor forState:UIControlStateNormal];
    }
    
    if (self.title.length >0) {
        titleLabel.text = self.title;
    }
    
    //设置默认日期
    if (!self.date) {
        self.date = currentDate;
    }
    datePicker.date = self.date;
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    _dateStr = [formater stringFromDate:self.date];
    
    NSString *tempStr = [formater stringFromDate:self.date];
    NSArray *dateArray = [tempStr componentsSeparatedByString:@"-"];
    
    //设置日期选择器最大可选日期
    if (self.maxYear) {
        NSInteger maxYear = [dateArray[0] integerValue] - self.maxYear;
        NSString *maxStr = [NSString stringWithFormat:@"%ld-%@-%@",maxYear,dateArray[1],dateArray[2]];
        NSDate *maxDate = [formater dateFromString:maxStr];
        datePicker.maximumDate = maxDate;
    }
    
    //设置日期选择器最小可选日期
    if (self.minYear) {
        
        NSInteger minYear = [dateArray[0] integerValue] - self.minYear;
        NSString *minStr = [NSString stringWithFormat:@"%ld-%@-%@",minYear,dateArray[1],dateArray[2]];
        NSDate* minDate = [formater dateFromString:minStr];
        datePicker.minimumDate = minDate;
    }
    
    [dateBgView addSubview: datePicker];
    self.hmDatePicker = datePicker;
    
    [self.hmDatePicker addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark -- 时间选择器确定/取消
- (void)pressentPickerView:(UIButton *)button {
    //确定
    if (button.tag == 1) {
        //确定
        self.completeBlock(_dateStr);
    }else if (button.tag == 0)
    {
        self.completeBlock(@"");

    }
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.frame = CGRectMake(0, SCREEN_HEIGHT, self.width, self.height);
        weakSelf.alpha = 0.0;
    } completion:^(BOOL finished) {

        [weakSelf removeFromSuperview];
       
    }];

//    [self removeFromSuperview];
}

#pragma mark -- 时间选择器日期改变
-(void)selectDate:(id)sender {
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    _dateStr =[outputFormatter stringFromDate:self.hmDatePicker.date];
    
}


@end
