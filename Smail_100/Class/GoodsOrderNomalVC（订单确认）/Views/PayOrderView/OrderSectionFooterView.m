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
    UITextField *_textField;
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
    UILabel *titleLB  = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 44) title:@"配送方式" textColor:[UIColor blackColor] font:Font15];
    titleLB.textAlignment = NSTextAlignmentLeft;
    titleLB.textColor = TITLETEXTLOWCOLOR;
    [self addSubview:titleLB];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLB.frame), SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = LINECOLOR;
    [self addSubview:lineView];
    
    UIButton *shouYeBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    shouYeBtn.frame = CGRectMake(8, CGRectGetMaxY(lineView.frame),SCREEN_WIDTH/4 , 40);
    [shouYeBtn addTarget:self action:@selector(didClickEmailAction:) forControlEvents:UIControlEventTouchUpInside];
    shouYeBtn.tag = 100;
    shouYeBtn.selected = YES;
    [shouYeBtn setImage:[UIImage imageNamed:@"zhuce2@3x.png"] forState:UIControlStateNormal];
    [shouYeBtn setImage:[UIImage imageNamed:@"23@3x.png"] forState:UIControlStateSelected];
    [shouYeBtn setTitle:@"快递邮寄" forState:UIControlStateNormal];
    [shouYeBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];
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
    
    UIView *commView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(meBtn.frame) +12, SCREEN_WIDTH, 45)];
    [self addSubview:commView];
    UILabel *titleLB1  = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 45) title:@"卖家留言:" textColor:[UIColor blackColor] font:Font15];
    titleLB.textAlignment = NSTextAlignmentLeft;
    titleLB.textColor = TITLETEXTLOWCOLOR;
    [commView addSubview:titleLB];
    
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLB1.frame)+5, 0, SCREEN_WIDTH -CGRectGetMaxY(titleLB1.frame)-5 , 45)];
    textField.placeholder  = @"选填(对本次交易的说明,限50个字以内)";
    textField.textColor = TITLETEXTLOWCOLOR;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.font = Font14;
    textField.delegate = self;
    textField.borderStyle = UITextBorderStyleNone;
    [commView addSubview:textField];
    _textField = textField;

    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(commView.frame), SCREEN_WIDTH, 1)];
    lineView1.backgroundColor = LINECOLOR;
    [self addSubview:lineView1];
    
    
    UILabel *titleLB3 = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 25, 44)];
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
    if (_model.isDetail) {
        _shouYeBtn.userInteractionEnabled = NO;
        _meBtn.userInteractionEnabled = NO;
        _textField.userInteractionEnabled = NO;

    }
}


- (void)didClickEmailAction:(UIButton*)sender
{
    [self endEditing:YES];
    if (sender.tag == 100) {
        _shouYeBtn.selected = YES;
        _meBtn.selected = NO;
    }
    else{
        _shouYeBtn.selected = NO;
        _meBtn.selected = YES;
    }
    
    if (_didChangeEmailTypeBlock) {
        _didChangeEmailTypeBlock(sender.tag - 100);
    }
}


// Will End Editing Action
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"将要结束编辑时执行的方法%@", textField.text);
    _model.message = textField.text;
   
    return YES;
}



@end
