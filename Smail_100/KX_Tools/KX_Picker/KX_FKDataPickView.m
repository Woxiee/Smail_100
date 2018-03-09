//
//  KX_FKDataPickView.m
//  KX_Service
//
//  Created by kechao wu on 16/9/19.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "KX_FKDataPickView.h"
#import "Masonry.h"

//字体大小
#define kfont 16
@interface KX_FKDataPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIView *bgV;

@property (nonatomic,strong)UIButton *cancelBtn;

@property (nonatomic,strong)UIButton *conpleteBtn;


@property (nonatomic,strong)UIPickerView *pickerV;

@property (nonatomic,strong)NSMutableArray *array;

@property (nonatomic,assign) NSInteger index;

@end

@implementation KX_FKDataPickView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.array = [NSMutableArray array];
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = [UIColor colorWithWhite:.7 alpha:.7];
    self.bgV = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 250*hScale)];
    self.bgV.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgV];
    
    [self showAnimation];
    
    UIView *titleView = [UIView new];
    titleView.backgroundColor = [UIColor colorWithWhite:0.957 alpha:1.000];
    [self.bgV addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_HEIGHT);
        make.height.mas_equalTo(44);
        
    }];
    
    
    
    //取消
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgV addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(44);
        
    }];
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:kfont];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    //完成
    self.conpleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgV addSubview:self.conpleteBtn];
    [self.conpleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(44);
        
    }];
    self.conpleteBtn.titleLabel.font = [UIFont systemFontOfSize:kfont];
    [self.conpleteBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.conpleteBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.conpleteBtn  setTitleColor:BACKGROUND_COLORHL forState:UIControlStateNormal];
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"选择类型";
    titleLabel.center = titleView.center;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:kfont+1];
    [titleView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.bgV.mas_centerX).offset(0);
        make.centerY.mas_equalTo(self.conpleteBtn.mas_centerY).offset(0);
        
    }];
    
    
    //线
    UIView *line = [UIView new];
    [self.bgV addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cancelBtn.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0.5);
    }];
    line.backgroundColor = RGBA(224, 224, 224, 1);
    
    
    //选择器
    self.pickerV = [UIPickerView new];
    //    self.pickerV.backgroundColor = [UIColor redColor];
    [self.bgV addSubview:self.pickerV];
    [self.pickerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    self.pickerV.delegate = self;
    self.pickerV.dataSource = self;
}



//赋值
- (void)setCustomArr:(NSArray *)customArr{
    _customArr = customArr;
    [self.array addObject:customArr];
}




#pragma mark-----UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return self.array.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSArray * arr = (NSArray *)[self.array objectAtIndex:component];
    
    return arr.count;
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label=[[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    label.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSArray *arr = (NSArray *)[self.array objectAtIndex:component];
    return [arr objectAtIndex:row % arr.count];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _index = row;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 60;
}

#pragma mark-----点击方法

- (void)cancelBtnClick{
    
    [self hideAnimation];
    
}

- (void)completeBtnClick{
    
    NSString *fullStr = [NSString string];
    for (int i = 0; i < self.array.count; i++) {
        NSArray *arr = [self.array objectAtIndex:i];
        NSString *str = [arr objectAtIndex:[self.pickerV selectedRowInComponent:i]];
        fullStr = [fullStr stringByAppendingString:str];
    }
  
    
    if (_DidClickPickerCell) {
        _DidClickPickerCell(_index);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didCilckPickerIndex:)]) {
        [self.delegate didCilckPickerIndex:fullStr];

    }
    [self hideAnimation];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hideAnimation];
    
}

//隐藏动画
- (void)hideAnimation{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.bgV.frame;
        frame.origin.y = SCREEN_HEIGHT;
        self.bgV.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [self.bgV removeFromSuperview];
        [self removeFromSuperview];
        
    }];
    
}

//显示动画
- (void)showAnimation{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.bgV.frame;
        frame.origin.y = SCREEN_HEIGHT-250*hScale;
        self.bgV.frame = frame;
    }];
    
}

-(void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}

@end
