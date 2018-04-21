//
//  AcctouWaterMeunView.m
//  Smail_100
//
//  Created by ap on 2018/3/15.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AcctouWaterMeunView.h"

@interface AcctouWaterMeunView ()
@property (nonatomic, weak) UIView *darkView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic,strong) UIButton *selectedBtn1;
@property (nonatomic,strong) UIButton *selectedBtn2;

@property (nonatomic, strong) NSString *direction;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSMutableArray *btnArr1;
@property (nonatomic, strong) NSMutableArray *btnArr2;

@end


@implementation AcctouWaterMeunView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}


/// 初始化视图
- (void)setup
{
    _btnArr1 = [[NSMutableArray alloc] init];
    _btnArr2 = [[NSMutableArray alloc] init];

    UIView *darkView                = [[UIView alloc] init];
    darkView.userInteractionEnabled = YES;
    darkView.frame = CGRectMake(0,  64 +50 , SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50);
    darkView.backgroundColor        = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:darkView];
    self.darkView = darkView;
    
    UITapGestureRecognizer  *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheetView)];
    [self.darkView addGestureRecognizer:tapGestureRecognizer];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0,darkView.mj_y, SCREEN_WIDTH,195);
    bottomView.backgroundColor  = [UIColor whiteColor];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    
    UIView  *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    lineView.backgroundColor = BACKGROUND_COLOR;
    [bottomView addSubview:lineView];
    
    NSArray *titles1  = @[@"方向",@"全部类型",@"收入",@"支出"];
    NSArray *titles2  = @[@"类型",@"全部类型",@"激励笑脸",@"兑换积分",@"空充笑脸",@"笑脸兑换",@"",@"支付宝",@"微信"];

    int btnW = 55;
    int btnH = 30;
    int pading = 5;
    for (int i = 0; i<titles1.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((btnW+pading)*i, CGRectGetMaxY(lineView.frame)+10, btnW , btnH);
        btn.tag = 100 + i;
        btn.timeInterVal = 0;
        btn.titleLabel.font = Font11;
        [btn setTitle:titles1[i] forState:UIControlStateNormal];
        //设置button正常状态下的标题颜色
        [btn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
        [btn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateSelected];
        [btn layerWithRadius:6 lineWidth:1 color:LINECOLOR];
        if (i ==  0 ) {
            btn.titleLabel.font = Font15;

        }else{
            if (i == 1) {
                btn.selected = YES;
                [btn layerWithRadius:6 lineWidth:1 color:KMAINCOLOR];
            }
            [btn addTarget:self action:@selector(clickIndex:) forControlEvents:UIControlEventTouchUpInside];
            [_btnArr1 addObject:btn];
        }
        [bottomView addSubview:btn];
    }
    UIView  *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 1)];
    lineView1.backgroundColor = BACKGROUND_COLOR;
    [bottomView addSubview:lineView1];
    
 

    for (int i = 0; i<titles2.count; i++) {
        NSInteger index = i % 6;
        NSInteger page = i / 6;
        if (SCREEN_WIDTH == 320) {
           index = i % 5;
        }
                                                                                                                                                                                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((btnW+pading)*index, CGRectGetMaxY(lineView1.frame)+10 +page*(btnH+10), btnW , btnH);
        btn.tag = 100 + i;
        btn.timeInterVal = 0;
        btn.titleLabel.font = Font11;
        [btn setTitle:titles2[i] forState:UIControlStateNormal];
        //设置button正常状态下的标题颜色
        [btn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
        [btn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateSelected];
        [btn layerWithRadius:6 lineWidth:1 color:LINECOLOR];
        if (i ==  0 ||  i == 6) {
            btn.titleLabel.font = Font15;
            [btn layerWithRadius:0 lineWidth:0 color:LINECOLOR];

        }else{
            if (i == 1) {
                btn.selected = YES;
                [btn layerWithRadius:6 lineWidth:1 color:KMAINCOLOR];
            }
            [btn addTarget:self action:@selector(clickIndex1:) forControlEvents:UIControlEventTouchUpInside];
            [_btnArr2 addObject:btn];

        }
        [bottomView addSubview:btn];
    }
//    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,60, 50)];
//    titleLB.text = @"方向"；[
    
    UIView  *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView1.frame)+80+10, SCREEN_WIDTH, 1)];
    lineView2.backgroundColor = BACKGROUND_COLOR;
    [bottomView addSubview:lineView2];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(SCREEN_WIDTH - 70, CGRectGetMaxY(lineView2.frame)+10, btnW , btnH);
    sureBtn.tag = 2000;
    sureBtn.timeInterVal = 0;
    //设置button正常状态下的标题颜色
    sureBtn.backgroundColor = KMAINCOLOR;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn layerForViewWith:3 AndLineWidth:0];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(clickIndex1:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.titleLabel.font = Font15;
    [bottomView addSubview:sureBtn];
    

}


- (void)clickIndex:(UIButton *)sender
{
//    if (_didClickCellBlock) {
//        _didClickCellBlock(sender.titleLabel.text);
//    }
//    [self hiddenSheetView];
//    for (UIButton *btn in _btnArr1) {
//        [btn layerWithRadius:6 lineWidth:1 color:LINECOLOR];
//    }

    for (UIButton *btn in _btnArr1) {
        btn.selected = NO;
        
        [btn layerWithRadius:6 lineWidth:1 color:LINECOLOR];
    }
    sender.selected = YES;
    [sender layerWithRadius:6 lineWidth:1 color:KMAINCOLOR];
//    if (sender!= self.selectedBtn1) {
//        self.selectedBtn1.selected = NO;
//        sender.selected = YES;
//        self.selectedBtn1 = sender;
//        [_selectedBtn1 layerWithRadius:6 lineWidth:1 color:KMAINCOLOR];
//
//    }else{
//        self.selectedBtn1.selected = YES;
//        [_selectedBtn1 layerWithRadius:6 lineWidth:1 color:KMAINCOLOR];
//
//    }
    NSString *str = sender.titleLabel.text;
    if ([str isEqualToString:@"全部类型"]) {
        _direction = @"";
    }
    if ([str isEqualToString:@"收入"]) {
        _direction = @"IN";

    }
    if ([str isEqualToString:@"支出"]) {
        _direction = @"OUT";

    }

    
}

- (void)clickIndex1:(UIButton *)sender
{
 //   NSArray *titles2  = @[@"类型",@"全部类型",@"激励笑脸",@"兑换积分",@"空充笑脸",@"笑脸兑换",@"",@"支付宝",@"微信"];
    for (UIButton *btn in _btnArr2) {
        btn.selected = NO;
        
        [btn layerWithRadius:6 lineWidth:1 color:LINECOLOR];
    }
    sender.selected = YES;
     [sender layerWithRadius:6 lineWidth:1 color:KMAINCOLOR];
//    if (sender!= self.selectedBtn2) {
//        self.selectedBtn2.selected = NO;
//        sender.selected = YES;
//        self.selectedBtn2 = sender;
//        [sender layerWithRadius:6 lineWidth:1 color:LINECOLOR];
//
//    }else{
//        self.selectedBtn2.selected = YES;
//        [_selectedBtn1 layerWithRadius:6 lineWidth:1 color:KMAINCOLOR];
//
//    }
    
    NSString *str = sender.titleLabel.text;
    if ([str isEqualToString:@"全部类型"]) {
        _type = @"";
    }
    if ([str isEqualToString:@"激励笑脸"]) {
        _type = @"coins_money";

    }
    if ([str isEqualToString:@"兑换积分"]) {
        _type = @"point";

    }
    
    if ([str isEqualToString:@"空充笑脸"]) {
        _type = @"coins_air_money";

    }
    
    if ([str isEqualToString:@"笑脸兑换"]) {
        _type = @"Withdraw";

    }
    
    if ([str isEqualToString:@"支付宝"]) {
        _type = @"alipay";
        
    }
    if ([str isEqualToString:@"微信"]) {
        _type = @"wxpay";
        
    }
    [_selectedBtn2 layerWithRadius:6 lineWidth:1 color:KMAINCOLOR];

    
    if ([str isEqualToString:@"确定"]) {
        if (_didClickCellBlock) {
            _didClickCellBlock(_direction,_type);
        }
        [self hiddenSheetView];

    }
    
    
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
        
        //        CGRect bgRect =  weakSelf.darkView.frame;
        //        CGRect chooseMenuRect =  weakSelf.contenView.frame;
        //        bgRect.origin.x= SCREEN_WIDTH;
        //        chooseMenuRect  = CGRectMake(SCREEN_WIDTH +40, 0, SCREEN_WIDTH- 40, SCREEN_HEIGHT);
        //        weakSelf.darkView.frame = bgRect;
        //        weakSelf.contenView.frame = chooseMenuRect;
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
    }];
}

@end
