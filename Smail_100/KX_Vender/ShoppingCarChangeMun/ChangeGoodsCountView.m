//
//  ChangeGoodsCountView.m
//  ShowView
//
//  Created by mac_KY on 17/4/18.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import "ChangeGoodsCountView.h"

static CGFloat  const CountViewWidth = 210;
static CGFloat  const CountViewHeight = 170;

@interface ChangeGoodsCountView ()<UITextFieldDelegate>
@property(nonatomic,copy)void (^changeValueBlock)(NSString *value);
@property(nonatomic,strong)UIView *darkView;
@property(nonatomic,strong)UIView *alertView;
@property(nonatomic,strong)NSString *count;

@property(nonatomic,strong)UITextField *inputTF;
@end

@implementation ChangeGoodsCountView
+(id)changeCountViewWith:(NSString *)count getChangeValue:(void(^)(NSString *changeValue))chageValueBlock
{
    return [[self alloc]initWithCount:count getChangeValue:^(NSString *changeValue) {
        chageValueBlock(changeValue);
    }];
}

-(id)initWithCount:(NSString *)count getChangeValue:(void(^)(NSString *changeValue))chageValueBlock
{
    if (self = [super init]) {
        _count = count;
        _changeValueBlock = chageValueBlock;//地址传旨
        [self loadSubviews];
    }
    return self;
}


#pragma mark - UI

-(void)loadSubviews
{
    [self loadbackView];
    //初始化弹出框
    [self loadAlertView];
    
}
-(void)loadbackView{
    [self setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _darkView = [UIView new];
    [_darkView setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _darkView.backgroundColor = [UIColor blackColor];
    _darkView.alpha = 0.55;
    [self addSubview:_darkView];
}
///初始化弹出框
-(void)loadAlertView{
    _alertView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-CountViewWidth)/2, (kScreenHeight - CountViewHeight)/2-50, CountViewWidth, CountViewHeight)];
    [self addSubview:_alertView];
    _alertView.backgroundColor = [UIColor whiteColor];
    [_alertView setConnerRediu:5];

    CGFloat midViewWdth = 140;
    CGFloat titleH = 30;
    CGFloat midH = 40;
    CGFloat bottomH = 40;
    CGFloat marginTop = 20;
    
    //title
    UILabel*titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, marginTop, _alertView.width, titleH)];
    titleLb.text = @"修改购买数量";
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.font = [UIFont systemFontOfSize:16];
    titleLb.textColor = [UIColor blackColor];
    
    [_alertView addSubview:titleLb];
    
    //MID
    UIView *midView = [[UIView alloc]initWithFrame:CGRectMake((CountViewWidth - midViewWdth)/2, titleLb.bottom+15, midViewWdth, midH)];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"goodsAd.png"]];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(0, 0, midViewWdth, midH);
    [midView addSubview:imageView];
    [_alertView addSubview:midView];
    //due
    UIButton *reduce = [[UIButton alloc]initWithFrame:CGRectMake(1, 1, midH-2, midH-2)];
    [midView addSubview:reduce];
    //reduce.backgroundColor = [UIColor grayColor];
    [reduce addTarget:self action:@selector(clickReduce) forControlEvents:UIControlEventTouchUpInside];
    //tf
    UITextField *tf  = [[UITextField alloc]initWithFrame:CGRectMake(reduce.right+1, 1, midViewWdth -(midH-2)*2 , (midH-2))];
    tf.text =_count;
    tf.textAlignment = NSTextAlignmentCenter;
    tf.borderStyle = UITextBorderStyleNone;
    tf.keyboardType = UIKeyboardTypePhonePad;
    tf.delegate = self;
    [tf becomeFirstResponder];
    _inputTF= tf;
    [midView addSubview:tf];
    //add
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(tf.right+1, 1, midH-2, midH-2)];
   // addBtn.backgroundColor = [UIColor grayColor];
    [midView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(clickadd) forControlEvents:UIControlEventTouchUpInside];
    
    //bottom
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _alertView.height-bottomH, CountViewWidth/2, bottomH)];
    cancleBtn.backgroundColor = RGB(238, 238, 238);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:cancleBtn];
    
    
    UIButton *trueBtn = [[UIButton alloc]initWithFrame:CGRectMake(cancleBtn.right, _alertView.height-bottomH, CountViewWidth/2, bottomH)];
    trueBtn.backgroundColor = MainColor;
    [trueBtn setTitle:@"确定" forState:UIControlStateNormal];
    [trueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [trueBtn addTarget:self action:@selector(clickTrue) forControlEvents:UIControlEventTouchUpInside];
    
    [_alertView addSubview:trueBtn];
    
    
}

#pragma mark - click

-(void)clickReduce{
    NSString *value = _inputTF.text;
    if (value.integerValue <= 1) {
        
        return;
    }
    _inputTF.text = [NSString stringWithFormat:@"%ld",value.integerValue-1];
}

-(void)clickadd{
    NSString *value = _inputTF.text;
    _inputTF.text = [NSString stringWithFormat:@"%ld",value.integerValue+1];
    
}
-(void)clickTrue{
    if (_inputTF.text.length == 0) {
         [self  makeToast:@"请输入购买数量!" position:@"center"];
        return;
    }
    _changeValueBlock(_inputTF.text);
    [self hide];
    
}

-(void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)hide
{
    [_darkView removeFromSuperview];
    [self removeFromSuperview];
    _darkView = nil;

}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length ==0) {
        return YES;
    }
    if (![Common isPureInt:string]) {
        [self makeToast:@"输入不合法!" position:@"center"];//
        return NO;
    }
    return YES;
}

-(void)dealloc
{
    NSLog(@"dealloc==dealloc");
}
@end
