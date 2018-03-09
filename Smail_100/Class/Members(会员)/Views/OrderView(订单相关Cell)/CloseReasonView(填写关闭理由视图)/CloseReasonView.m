//
//  CloseReasonView.m
//  MyCityProject
//
//  Created by Faker on 17/6/7.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "CloseReasonView.h"
#import "KYTextView.h"
@interface CloseReasonView ()
@property (nonatomic, strong) NSArray *dataArray;  /// 选择数据源
@property (nonatomic, weak) UIView *darkView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, assign)   KYTextView *textView;

@end

@implementation CloseReasonView

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title andTitle1:(NSString *)title1
{
    if (self = [super initWithFrame:frame]) {
        UIView *darkView                = [[UIView alloc] init];
        darkView.userInteractionEnabled = YES;
        darkView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        darkView.backgroundColor        = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:darkView];
        self.darkView = darkView;
        
        UITapGestureRecognizer  *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheetView)];
        [self.darkView addGestureRecognizer:tapGestureRecognizer];
        
        UIView *bottomView = [[UIView alloc] init];
        bottomView.frame = CGRectMake(0, SCREEN_HEIGHT  - 190, SCREEN_WIDTH, 190);
        bottomView.backgroundColor  = [UIColor whiteColor];
        [self addSubview:bottomView];
        self.bottomView = bottomView;
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, SCREEN_WIDTH -50, 17)];
        titleLB.text = title;
        titleLB.textColor = DETAILTEXTCOLOR;
        titleLB.font = Font15;
        [self.bottomView addSubview:titleLB];
        
        KYTextView *textView = [[KYTextView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(titleLB.frame)+10, SCREEN_WIDTH - 24, 60)];
        textView.KYPlaceholder = @"请输入";
        textView.KYPlaceholderColor = DETAILTEXTCOLOR1;
        [self.bottomView addSubview:textView];
        _textView = textView;
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame)+1, SCREEN_WIDTH, 0.5)];
        lineView1.backgroundColor = LINECOLOR;
        [self.bottomView addSubview:lineView1];
        
        UILabel *titleLB1 = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(lineView1.frame)+12, SCREEN_WIDTH -50, 17)];
        titleLB1.text = title1;
        titleLB1.textColor = DETAILTEXTCOLOR1;
        titleLB1.font = Font15;
        [self.bottomView addSubview:titleLB1];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLB1.frame)+12, SCREEN_WIDTH, 0.5)];
        lineView2.backgroundColor = LINECOLOR;
        [self.bottomView addSubview:lineView2];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0,  CGRectGetMaxY(lineView2.frame), SCREEN_WIDTH/2, 44);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = Font15;
        cancelBtn.tag = 100;
        [cancelBtn addTarget:self action:@selector(didClickReasonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:cancelBtn];
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(SCREEN_WIDTH/2,  CGRectGetMaxY(lineView2.frame), SCREEN_WIDTH/2, 44);
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font = Font15;
        sureBtn.backgroundColor = BACKGROUND_COLORHL;
        sureBtn.tag = 200;
        
        [sureBtn addTarget:self action:@selector(didClickReasonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:sureBtn];
        [self addNoticeForKeyboard];


    }
    return self;
}



/// 出现
- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}


/// 消失
- (void)hiddenSheetView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{

    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
        [[NSNotificationCenter defaultCenter] removeObserver:self];

    }];
}

- (void)didClickReasonAction:(UIButton *)sender
{
    if (sender.tag == 100) {
        [self hiddenSheetView];

    }
    else if (sender.tag == 200){
        if (KX_NULLString(_textView.text) || [_textView.text isEqualToString:@"请输入"]) {
            [self toastShow:@"还未填写理由~"];
            return;
        }else{
            if (self.didClickReasonBlock) {
                self.didClickReasonBlock(_textView.text);
            }
            [self hiddenSheetView];

        }

       
    }
    
}


#pragma mark - 键盘通知
- (void)addNoticeForKeyboard {
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
//    CGFloat offset = (_textView.frame.origin.y+_textView.frame.size.height+ _bottomView.height) - (self.frame.size.height - kbHeight);
    CGFloat offset = self.frame.size.height - kbHeight - _bottomView.height;

    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            _bottomView.frame = CGRectMake(0.0f, offset, self.frame.size.width, _bottomView.height);
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        _bottomView.frame =CGRectMake(0, SCREEN_HEIGHT  - _bottomView.height, SCREEN_WIDTH, _bottomView.height);
    }];
}



@end
