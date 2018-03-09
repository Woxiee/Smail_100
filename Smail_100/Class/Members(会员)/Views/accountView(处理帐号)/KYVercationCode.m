//
//  KYVercationCode.m
//  KCDateDemo1
//
//  Created by mac_KY on 17/2/21.
//  Copyright © 2017年 mac_kc. All rights reserved.
//

#import "KYVercationCode.h"

@interface KYVercationCode ()<UITextFieldDelegate>
@property (nonatomic,strong)NSTimer  *timer;
@end

@implementation KYVercationCode
{
    BOOL _hideBtn;
    
}


- (instancetype)initWithFrame:(CGRect )frame hideClickBtn:(BOOL)hide
{
    if (self = [super initWithFrame:frame]) {
        _hideBtn = hide;
        [self loadSubView];
       
    }
    return self;
}


- (void)timeRun:(void(^)(int count))timeBlock
{
    __block int i = 60;//设置最大时间
    __weak typeof(self) b_self = self;
    self.getCodeBtn.enabled = NO;
    self.nextBtn.enabled = YES;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        i--;
        [b_self.getCodeBtn setTitle:[NSString stringWithFormat:@"重新获取(%is)",i] forState:UIControlStateDisabled];

        if (i==0) {
            timeBlock(i);

            [b_self stopTime];
        }
     
    }];
    
    
    
}


- (void)stopTime
{
    if (_timer) {
        self.getCodeBtn.enabled = YES;
        self.nextBtn.enabled = NO;
        [_timer invalidate];
        _timer = nil;
    }
   
}


- (void)loadSubView{
    //100
    self.backgroundColor = [UIColor whiteColor];
    //bottom
    CGFloat btnW = 110;
    CGFloat edge = 0;
    CGFloat textFW  =  _hideBtn?self.width - 2*edge: self.width - btnW - edge +9;
    UITextField *inputTF = [[UITextField alloc]initWithFrame:CGRectMake(12, 0, textFW-12, self.height)];
    inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:inputTF];
    inputTF.borderStyle = UITextBorderStyleNone;
    inputTF.delegate = self;
    inputTF.font = Font15;
    self.inputTF = inputTF;
    inputTF.returnKeyType = UIReturnKeyDone;
    inputTF.placeholder = _hideBtn? @"请输入手机号码":@"请输入验证码";
    inputTF.backgroundColor = [UIColor whiteColor];
    if (!_hideBtn) {
        CGFloat topEdge = 10.0f;
        
        UIView *ErectLine = [[UIView alloc]initWithFrame:CGRectMake(inputTF.right,inputTF.top + topEdge, 1, inputTF.height - 2*topEdge)];
        [self addSubview:ErectLine];
        ErectLine.backgroundColor = COLOR(242, 242, 242, 242);;
        
        /// 获取验证码的按钮
        UIButton *codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(ErectLine.right, inputTF.top, self.width - ErectLine.right, inputTF.height)];
        [self addSubview:codeBtn];
        [codeBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
        [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        codeBtn.titleLabel.font = PLACEHOLDERFONT;
        codeBtn.backgroundColor = [UIColor whiteColor];
        self.getCodeBtn  = codeBtn;
    }
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(edge, 0, self.width - 2*edge, 1.0f)];
    [self addSubview:lineV];
    lineV.backgroundColor = LINECOLOR
    

    self.height = 44;
    
}


- (void)clickNext
{
    
    if (_clickNextBlock) {
        _clickNextBlock();
    }
}
#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //验证手机是不是可用
    NSString *vatString = textField.text;
    if (string.length == 0 && vatString.length != 0) {
        vatString = [textField.text substringWithRange:NSMakeRange(0, vatString.length -1)];
    }else{
        vatString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    
    if (_hideBtn) {
        if (self.controlNextBtn && vatString.length == 11) {
            return YES;
        }
    }else{
       
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
     
    self.getCodeBtn.enabled = NO;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}




- (void)clickPopCorrect:(BOOL)correct
{
    if (_correctBlock) {
        _correctBlock(correct);
    }
    
}



@end
