//
//  OrderSectionFooterView.m
//  Smail_100
//
//  Created by ap on 2018/4/10.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "OrderSectionFooterView.h"

@implementation OrderSectionFooterView
{
    UIButton *_shouYeBtn;
    UIButton *_meBtn;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UILabel *titleLB  = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH, 44)];
    titleLB.text = @"配送方式" ;
    titleLB.font = Font15;
    titleLB.textAlignment = NSTextAlignmentLeft;
    titleLB.textColor = TITLETEXTLOWCOLOR;
    [self addSubview:titleLB];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLB.frame), SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = LINECOLOR;
    [self addSubview:lineView];
    
    UIButton *shouYeBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    shouYeBtn.frame = CGRectMake(3, CGRectGetMaxY(lineView.frame),SCREEN_WIDTH/4 , 45);
    [shouYeBtn addTarget:self action:@selector(didClickEmailAction:) forControlEvents:UIControlEventTouchUpInside];
    shouYeBtn.tag = 100;
//    shouYeBtn.selected = YES;
    [shouYeBtn setImage:[UIImage imageNamed:@"zhuce2@3x.png"] forState:UIControlStateNormal];
    [shouYeBtn setImage:[UIImage imageNamed:@"23@3x.png"] forState:UIControlStateSelected];
    [shouYeBtn setTitle:@"快递邮寄" forState:UIControlStateNormal];
    [shouYeBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:0];
    [shouYeBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    shouYeBtn.titleLabel.font =  Font15;
    [self addSubview:shouYeBtn];
    _shouYeBtn = shouYeBtn;
    
    
    
    UIButton *meBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    meBtn.frame = CGRectMake(CGRectGetMaxX(shouYeBtn.frame)  +40, CGRectGetMaxY(lineView.frame), SCREEN_WIDTH/4, 45);
    [meBtn addTarget:self action:@selector(didClickEmailAction:) forControlEvents:UIControlEventTouchUpInside];
    meBtn.tag = 101;
    [meBtn setImage:[UIImage imageNamed:@"zhuce2@3x.png"] forState:UIControlStateNormal];
    [meBtn setImage:[UIImage imageNamed:@"23@3x.png"] forState:UIControlStateSelected];
    [meBtn setTitle:@"门店自提" forState:UIControlStateNormal];
    [meBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    meBtn.titleLabel.font =  Font15;
    [meBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];
    [self addSubview:meBtn];
    _meBtn = meBtn;
    
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_meBtn.frame), SCREEN_WIDTH, 0.5)];
    lineView2.backgroundColor = LINECOLOR;
    [self addSubview:lineView2];
    
    UIView *commView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView2.frame), SCREEN_WIDTH, 60)];
    [self addSubview:commView];
    [commView layerForViewWith:0 AndLineWidth:0.5];
    UILabel *titleLB1  = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 70, 30)];
    titleLB1.text = @"买家留言:";
    titleLB1.font = Font15;
    titleLB1.textAlignment = NSTextAlignmentLeft;
    titleLB1.textColor = TITLETEXTLOWCOLOR;
    [commView addSubview:titleLB1];
    
    
    KYTextView *textField = [[KYTextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLB1.frame)+5, 12, SCREEN_WIDTH -CGRectGetMaxY(titleLB1.frame)-25 , 40)];
    textField.KYPlaceholder  = @"选填(对本次交易的说明,限50个字以内)";
    textField.KYPlaceholderColor = DETAILTEXTCOLOR;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.font = Font14;
    textField.maxTextCount = 50;
//    textField.delegate = self;
//    textField.borderStyle = UITextBorderStyleNone;
    [commView addSubview:textField];
    
    _textField = textField;

//    KX_TextView *textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLB1.frame)+5, 0, SCREEN_WIDTH -CGRectGetMaxY(titleLB1.frame)-5 , 45)];
//
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification" object:_textField];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(commView.frame), SCREEN_WIDTH, 1)];
    lineView1.backgroundColor = LINECOLOR;
    [self addSubview:lineView1];
    
    
    UILabel *titleLB3 = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(lineView1.frame), SCREEN_WIDTH - 25, 44)];
    titleLB3.textColor = TITLETEXTLOWCOLOR;
    titleLB3.font = Font15;
    titleLB3.textAlignment = NSTextAlignmentRight;

    [self addSubview:titleLB3];
    self.titleLB3 = titleLB3;
    
    self.backgroundColor = [UIColor whiteColor];

}

- (void)setModel:(GoodsOrderModel *)model
{
    _model = model;
    if (KX_NULLString(_model.message)) {
      _textField.KYPlaceholder  = @"选填(对本次交易的说明,限50个字以内)";
    }else{
        _textField.text = _model.message;

    }

    if (_model.isDetail) {
        _shouYeBtn.userInteractionEnabled = NO;
        _meBtn.userInteractionEnabled = NO;
        _textField.userInteractionEnabled = NO;
        _textField.text = _model.message;


    }
   // type  1 邮寄  2门店
    if ([_model.express_type isEqualToString:@"1"]) {
        _shouYeBtn.selected = YES;
        _meBtn.selected = NO;
    }
    else  if ([_model.express_type isEqualToString:@"2"]) {
        _shouYeBtn.selected = NO;
        _meBtn.selected = YES;
    }
}


- (void)didClickEmailAction:(UIButton*)sender
{
    [self endEditing:YES];
//    if (sender.tag == 100) {
//        _shouYeBtn.selected = YES;
//        _meBtn.selected = NO;
//    }
//    else{
//        _shouYeBtn.selected = NO;
//        _meBtn.selected = YES;
//    }
    
    if (_didChangeEmailTypeBlock) {
        _didChangeEmailTypeBlock(sender.tag - 100);
    }
}

#pragma mark - Notification Method
-(void)textFieldEditChanged:(NSNotification *)obj
{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > 50)
            {
                textField.text = [toBeString substringToIndex:50];
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > 50)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:50];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:50];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 50)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}









@end
