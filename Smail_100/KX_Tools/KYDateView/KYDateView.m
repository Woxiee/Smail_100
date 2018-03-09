//
//  KYDateView.m
//  KYDateView
//
//  Created by mac_KY on 17/3/3.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import "KYDateView.h"
#import "UIViewExt.h"

#define topHeight 50.0f
#define pickerHeight 180.0f
@interface KYDateView ()


@property(nonatomic,strong)UIView *cover;
@property(nonatomic,strong)NSString *selectDate;

@property(nonatomic,weak) UIView *dateBgView;


@property(nonatomic,strong)NSDateFormatter *formater;
@property(nonatomic,copy)void(^selectDateBlock)(NSString *selectDate);
@end

@implementation KYDateView

/*懒加载*/
-(UIDatePicker *)datePicker
{
    if (!_datePicker) {
        //初始化数据
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, topHeight, SCREEN_WIDTH,pickerHeight)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.date = [NSDate dateWithTimeIntervalSinceNow:-3600*24*365*20];
        _datePicker.maximumDate = [NSDate date];
    }
    return _datePicker;
}

+(id)dateViewclickTrue:(void(^)(NSString *dateStr))clickTrueBlcok
{

  return [[self alloc]initWithTrue:^(NSString *dateStr) {
      clickTrueBlcok(dateStr);
  }];

}

-(id)initWithTrue:(void(^)(NSString *dateStr))clickTrueBlcok
{
    if (self = [super init]) {
        _selectDateBlock = clickTrueBlcok;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self loadSubview];
    }
    return self;
}
-(void)loadSubview{
    
    _cover = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _cover.backgroundColor = [UIColor blackColor];
    _cover.alpha = 0.5;
    _cover.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideDateView)];
    [_cover addGestureRecognizer:tap];
    [self addSubview:_cover];
    
    /// 时间选择器
    UIView *dateBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - topHeight - pickerHeight, SCREEN_WIDTH, topHeight + pickerHeight)];
    dateBgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:dateBgView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, topHeight)];
    topView.backgroundColor = LINECOLOR;
    /// 顶部视图
    [dateBgView addSubview:topView];
    self.dateBgView = dateBgView;
    
    /// 标题
   UILabel* titleLabel = [UILabel new];
    titleLabel.text = @"选择时间";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    CGFloat kbtnH =25,kbtnW = 55;
    UIButton* _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame =  CGRectMake(SCREEN_HEIGHT - kbtnW - 12  , (topView.height - kbtnH)/2, kbtnW, kbtnH);
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(clicTrueBtn) forControlEvents:UIControlEventTouchUpInside];
    _sureBtn.backgroundColor = BACKGROUND_COLOR;
    [_sureBtn setConnerRediu:3];
    [topView addSubview:_sureBtn];
    
    UIButton* _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _cancelBtn.frame =  CGRectMake(12, (topView.height - kbtnH)/2, kbtnW, kbtnH);;
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(hideDateView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_cancelBtn];
    
    ///dateView
    [dateBgView addSubview: self.datePicker];
    [_datePicker addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
    _formater = [[NSDateFormatter alloc] init];
    [_formater setDateFormat:@"yyyy-MM-dd"];

    _selectDate =  [_formater stringFromDate:self.datePicker.date];
    _selectDate = [_formater stringFromDate:[NSDate date]];
    
}

-(void)selectDate:(UIDatePicker *)datePicker{
    
    
    _selectDate = [_formater stringFromDate:datePicker.date];
    
}

#pragma mark - 点击事件

-(void)clicTrueBtn{
    
    typeof(self) b_self = self;
    if (_selectDateBlock) {
        _selectDateBlock(b_self.selectDate);
    }
    [self hideDateView];
    
}
-(void)showDateView{
    UIWindow *wid = [UIApplication sharedApplication].keyWindow;
    [wid addSubview:self];
    
    [ self.dateBgView setAnnimationShow:YES annimationOption:KYAnnimationOptionsShowFromBotton duratime:0.25];
    
}
-(void)hideDateView{
   // [_cover removeFromSuperview];
   // typeof(self) b_self = self;
//    [self setAnnimationShow:NO annimationOption:KYAnnimationOptionsShowFromBotton duratime:0.1f];
    
    [self setAnnimationShow:NO annimationOption:KYAnnimationOptionsShowFromBotton duratime:0.25 completion:^(BOOL finish) {
    }];

    
}

@end
