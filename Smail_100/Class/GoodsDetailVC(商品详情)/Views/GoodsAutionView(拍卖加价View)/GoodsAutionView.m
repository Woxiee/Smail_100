//
//  GoodsAutionView.m
//  MyCityProject
//
//  Created by Faker on 17/5/31.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsAutionView.h"
@interface GoodsAutionView ()
@property (nonatomic, weak) UIView *darkView;
@property (nonatomic, strong)  UIView *contenView;
@property (nonatomic, strong)  UITextField *numberTextField;/// 数量TextField

@end

@implementation GoodsAutionView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
        
    }
    return self;
}

/// 视图
- (void)setup
{
    UIView *darkView                = [[UIView alloc] init];
    darkView.userInteractionEnabled = YES;
    darkView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    darkView.backgroundColor        = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:darkView];
    self.darkView = darkView;
    
    UITapGestureRecognizer  *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheetView)];
    [self.darkView addGestureRecognizer:tapGestureRecognizer];
    
    /// 白色背景
    UIView *contenView = [[UIView alloc] init];
    contenView.backgroundColor = [UIColor whiteColor];
    contenView.frame = CGRectMake(0,SCREEN_HEIGHT- 170, SCREEN_WIDTH, 170);
    [self addSubview:contenView];
    self.contenView = contenView;
    
    UIView *changeView = [[UIView alloc] init];
    changeView.frame = CGRectMake(SCREEN_WIDTH*0.4/2, 32, SCREEN_WIDTH*0.6, 44);
//    changeView.backgroundColor = [UIColor redColor];
    [contenView addSubview:changeView];

    
    UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleBtn.frame = CGRectMake( 0 ,0 , changeView.width/5, 44);
    [deleBtn setTitle:@"-1 " forState:UIControlStateNormal];
    [deleBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    [deleBtn layerForViewWith:2 AndLineWidth:0.5];
    deleBtn.tag = 100;
    [deleBtn addTarget:self action:@selector(didClickChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    [changeView  addSubview:deleBtn];
    
    UITextField *numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(deleBtn.frame) + 10, 0 , changeView.width/5 *3 - 20, 44)];
    [changeView addSubview:numberTextField];
    numberTextField.textAlignment = NSTextAlignmentCenter;
    [numberTextField layerWithRadius:3 lineWidth:0.5 color:BACKGROUND_COLORHL];

    numberTextField.userInteractionEnabled =  NO;//jp 暂时不用
    _numberTextField = numberTextField;

    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake((CGRectGetMaxX(numberTextField.frame) + 10),0 , changeView.width/5, 44);
    [addBtn setTitle:@"+1 " forState:UIControlStateNormal];
    [addBtn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateNormal];
    [addBtn layerWithRadius:2 lineWidth:0.5 color:BACKGROUND_COLORHL];
    addBtn.tag = 101;
    [addBtn addTarget:self action:@selector(didClickChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    [changeView  addSubview:addBtn];
    
    
    
    //    GoodGuigeAddCartOrBuyType, ///添加购物车或者购买
    //    GoodGuigeChooseGoodsType      ///购买
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(0 ,self.contenView.height - 49, SCREEN_WIDTH, 49);
    [sureBtn setTitle:@"确认出价" forState:UIControlStateNormal];
    sureBtn.userInteractionEnabled = YES;
    sureBtn.tag = 1000;
    
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(didClickSureAction:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.backgroundColor = BACKGROUND_COLORHL;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [contenView addSubview:sureBtn];

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
    }];
}

/// 增加 减少BTN
- (void)didClickChangeAction:(UIButton *)btn
{
    if (btn.tag == 100) {
        _model.goodSCount --;
        if (_model.goodSCount ==1 ||_model.goodSCount<1) {
            _model.goodSCount =1;
        }
    }
    else if (btn.tag == 101){
        _model.goodSCount ++;
    }
    float priceStr =  [_model.minAddPrice intValue] * _model.goodSCount ;
    NSString *str1 = [NSString stringWithFormat:@"%.2f",priceStr];
    NSString *str =[NSString stringWithFormat:@"￥%@",str1];
    NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:17 weight:UIFontWeightThin]];
    _numberTextField.attributedText = attributedStr;

    
}

/// 确定
- (void)didClickSureAction:(UIButton*)sender
{
    if (self.didClikBlock) {
        self.didClikBlock(_model);
        [self hiddenSheetView];
    }
}


- (void)setModel:(GoodSDetailModel *)model
{
    _model = model;
    NSString *str1 = [NSString stringWithFormat:@"%@",_model.minAddPrice];
    NSString *str =[NSString stringWithFormat:@"￥%@",str1];
    NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:17 weight:UIFontWeightThin]];
   _numberTextField.attributedText = attributedStr;
}

@end
