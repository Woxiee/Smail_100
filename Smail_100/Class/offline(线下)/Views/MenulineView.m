//
//  MenulineView.m
//  Smail_100
//
//  Created by Faker on 2018/4/26.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "MenulineView.h"

@implementation MenulineView
{
  
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
    self.backgroundColor = [UIColor whiteColor];
    [self layerForViewWith:0 AndLineWidth:0.5];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(12, 0, 85, 50);
    [btn setTitle:@" 消费金额:" forState:UIControlStateNormal];
    [btn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"mornyIcon@2x.png"] forState:UIControlStateNormal];
    btn.titleLabel.font = Font15;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    

    [self addSubview:btn];
    
//    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 70, 45)];
//    titleLB.text = @"请输入你要消费的金额";
//    titleLB.font = Font13;
//    titleLB.textAlignment = NSTextAlignmentLeft;
//    [self addSubview:titleLB];
    
    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+30, 0,SCREEN_WIDTH - CGRectGetMaxX(btn.frame) - 40, 48)];
    textF.placeholder = @"请输入您要消费的金额";
    textF.font = Font12;
    textF.keyboardType = UIKeyboardTypeNumberPad;
    textF.textAlignment = NSTextAlignmentLeft;
    [self addSubview:textF];
    _textField = textF;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(textF.mj_x, self.mj_h -8, textF.mj_w, 1)];
    lineView.backgroundColor = DETAILTEXTCOLOR;
    [self addSubview:lineView];

//     UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn1 setTitle:@"确认支付" forState:UIControlStateNormal];
//    btn1.frame = CGRectMake(CGRectGetMaxX(textF.frame), 12.5, 70, 25);
//    [btn1 addTarget:self action:@selector(didClickBottomAction) forControlEvents:UIControlEventTouchUpInside];
//    btn1.backgroundColor = MainColor;
//    btn1.titleLabel.font = Font13;
//    [btn1 layerForViewWith:6 AndLineWidth:0];
//    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self addSubview:btn1];
    
    
}

- (void)didClickBottomAction
{
    [self endEditing:YES];
    if (_textField.text.floatValue <=0) {
        [self.window makeToast:@"请输入金额"];
        return;
    }
    if (_didClickSureBlock ) {
        _didClickSureBlock(_textField.text);
    }
}


@end
