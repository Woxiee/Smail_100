//
//  SuccessView.m
//  ShiShi
//
//  Created by mac_KY on 17/2/27.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "SuccessView.h"

#import "AppDelegate.h"

#define marginLeft 20.0f
typedef void(^clickTrue)(NSInteger dex);

@interface SuccessView ()
@property (nonatomic,copy)clickTrue clickTrueBlock;

@end

@implementation SuccessView{
    CGFloat _kWidth,_kHeight;
    UIView *_cover;
    UIImageView *_headerImageV;
    UILabel *_messgaeLb;
    UIButton *_bottomBtn;
}


+(id)success{
    return [[self alloc]init];
}
-(id)initWithTrueCancleTitle:(NSString *)title clickDex:(void(^)(NSInteger clickDex))clickBlock{
    
    if (self = [super init]) {
        _kWidth = SCREEN_WIDTH - 2*marginLeft;
        _kHeight = _kWidth *0.45;
        self.frame = CGRectMake(marginLeft, (SCREEN_HEIGHT - _kHeight)/2, _kWidth, _kHeight);
        self.backgroundColor = [UIColor whiteColor];
        [self setConnerRediu:8];
        [self loadTrueCancleView];
        _headerImageV.hidden = YES;
        _messgaeLb.text = title;
        _clickTrueBlock = clickBlock;
    }
    return self;
}

///是否显示取消按钮
-(id)initWithTrueCancleTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle clickDex:(void(^)(NSInteger clickDex))clickBlock
{
    if (self = [super init]) {
        _kWidth = SCREEN_WIDTH - 2*marginLeft;
        _kHeight = _kWidth *0.45;
        self.frame = CGRectMake(marginLeft, (SCREEN_HEIGHT - _kHeight)/2, _kWidth, _kHeight);
        self.backgroundColor = [UIColor whiteColor];
        [self setConnerRediu:8];
        [self loadIsHiddenCancleView:cancelTitle];
        _headerImageV.hidden = YES;
        _messgaeLb.text = title;
        _clickTrueBlock = clickBlock;
    }
    return self;
}

-(id)initWithStyle:(SuccessStyle)style title:(NSString *)title subTitle:(NSString *)subTitle{
    if (self = [super init]) {
        _kWidth = SCREEN_WIDTH - 2*marginLeft;
        _kHeight = _kWidth *0.6;
        self.frame = CGRectMake(marginLeft, (SCREEN_HEIGHT - _kHeight)/2, _kWidth, _kHeight);
        self.backgroundColor = [UIColor whiteColor];
        [self setConnerRediu:8];
        [self loadSubView];
        //重新设置
        if (style == SuccessStyleBottomWhite) {
            
            _bottomBtn.backgroundColor = [UIColor whiteColor];
          //  [_bottomBtn setTitleColor:MainColor forState:UIControlStateNormal];
            _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            _messgaeLb.font = [UIFont systemFontOfSize:15];
            _bottomBtn.top = _bottomBtn.top +  10;
            // addLine
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _bottomBtn.top - 10, self.width, 2)];
            
            view.backgroundColor = LINECOLOR;
            [self addSubview:view];
        }
    }
    return self;
    
}

-(id)init{
    if (self = [super init]) {
        _kWidth = SCREEN_WIDTH - 2*marginLeft;
        _kHeight = _kWidth *0.6;
        self.frame = CGRectMake(marginLeft, (SCREEN_HEIGHT - _kHeight)/2, _kWidth, _kHeight);
        self.backgroundColor = [UIColor whiteColor];
        [self setConnerRediu:8];
        [self loadSubView];
        
    }
    return self;
}


#pragma mark - SubView

-(void)loadTrueCancleView{

    //中部的提示
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.width, 11.0/34.0 *self.height)];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.numberOfLines = 2;
    lb.font = [UIFont systemFontOfSize:16];
    lb.textColor = TITLETEXTLOWCOLOR;
    [self addSubview:lb];
    _messgaeLb = lb;
    
    //返回按钮
    CGFloat backW = 22;
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - backW - 10, self.height/10, backW, backW)];
    backBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:backBtn];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"shutdown_click.png"] forState:UIControlStateNormal];
    
    //线条1
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 11.0/34.0*self.height, self.width, 1)];
    line1.backgroundColor = LINECOLOR;
    [self addSubview:line1];
    
    //取消按钮
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0 , line1.bottom, self.width/2, self.height - line1.bottom)];
    [self addSubview:cancleBtn];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancleBtn addTarget:self action:@selector(hideSuccess) forControlEvents:UIControlEventTouchUpInside];
    //线条2
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(cancleBtn.right, line1.bottom, 1, cancleBtn.height)];
    [self addSubview:line2];
    line2.backgroundColor = LINECOLOR;
    
    //确定按钮
    UIButton *trueBtn = [[UIButton alloc]initWithFrame:CGRectMake(line2.right, line1.bottom, self.width - line2.right, line2.height)];
    [self addSubview:trueBtn];
    [trueBtn setTitle:@"确认" forState:UIControlStateNormal];
    [trueBtn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateNormal];
    [trueBtn addTarget:self action:@selector(clickTrueBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    //cover
    _cover = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _cover.alpha = 0.6f;
    _cover.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSuccess)];
    [_cover addGestureRecognizer:tap];
    
    [self hideSuccess];
}


///修改取消按钮
-(void)loadIsHiddenCancleView:(NSString *)cancelTitle{
    
    //中部的提示
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.width, 11.0/34.0 *self.height)];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.numberOfLines = 2;
    lb.font = [UIFont systemFontOfSize:16];
    lb.textColor = TITLETEXTLOWCOLOR;
    [self addSubview:lb];
    _messgaeLb = lb;
    
    //返回按钮
    CGFloat backW = 22;
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - backW - 10, self.height/10, backW, backW)];
    backBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:backBtn];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"shutdown_click.png"] forState:UIControlStateNormal];
    //线条1
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 11.0/34.0*self.height, self.width, 1)];
    line1.backgroundColor = LINECOLOR;
    [self addSubview:line1];
    if (KX_NULLString(cancelTitle)) {
        //确定按钮
        UIButton *trueBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, line1.bottom, self.width , self.height - line1.bottom)];
        [self addSubview:trueBtn];
        [trueBtn setTitle:@"确认" forState:UIControlStateNormal];
        [trueBtn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateNormal];
        [trueBtn addTarget:self action:@selector(clickTrueBtn) forControlEvents:UIControlEventTouchUpInside];

    }else{
        //取消按钮
        UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0 , line1.bottom, self.width/2, self.height - line1.bottom)];
        [self addSubview:cancleBtn];
        [cancleBtn setTitle:cancelTitle forState:UIControlStateNormal];
        [cancleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancleBtn addTarget:self action:@selector(hideSuccess) forControlEvents:UIControlEventTouchUpInside];
        //线条2
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(cancleBtn.right, line1.bottom, 1, cancleBtn.height)];
        [self addSubview:line2];
        line2.backgroundColor = LINECOLOR;
        
        //确定按钮
        UIButton *trueBtn = [[UIButton alloc]initWithFrame:CGRectMake(line2.right, line1.bottom, self.width - line2.right, line2.height)];
        [self addSubview:trueBtn];
        [trueBtn setTitle:@"确认" forState:UIControlStateNormal];
        [trueBtn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateNormal];
        [trueBtn addTarget:self action:@selector(clickTrueBtn) forControlEvents:UIControlEventTouchUpInside];
    }

    

    
    
    //cover
    _cover = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _cover.alpha = 0.6f;
    _cover.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSuccess)];
    [_cover addGestureRecognizer:tap];
    
    [self hideSuccess];

}

-(void)loadSubView{
   
    //返回按钮
    CGFloat backW = 22;
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - backW - 10, self.height/10*1.2, backW, backW)];
    backBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:backBtn];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"shutdown_click.png"] forState:UIControlStateNormal];
    
    //头部图片
    CGFloat imgW = _kHeight*0.2;
    UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - imgW)/2, imgW/1.5, imgW, imgW)];
    headerImage.image = [UIImage imageNamed:@"dingdantijiaochenggong.png"];
    headerImage.contentMode = UIViewContentModeScaleAspectFit;
    headerImage.backgroundColor = [UIColor clearColor];
    [self addSubview:headerImage];
    _headerImageV = headerImage;
    
    //中部的提示
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, headerImage.bottom+imgW/2, self.width, imgW/2)];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.text = @"修改密码成功";
    [self addSubview:lb];
    _messgaeLb = lb;
    
    //底部按钮
    CGFloat bottommarginLeft = 30.0;
    UIButton *bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(bottommarginLeft, lb.bottom+self.height/10, self.width - bottommarginLeft*2, self.height* 0.25)];
    [bottomBtn setConnerRediu:3];
    [bottomBtn setBackgroundColor:BACKGROUND_COLORHL];
    [bottomBtn setTitle:@"返回重新登陆" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(clickBottomBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bottomBtn];
    _bottomBtn = bottomBtn;
    
    //cover
    _cover = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _cover.alpha = 0.6f;
    _cover.backgroundColor = [UIColor blackColor];
    
    [self hideSuccess];
}

-(void)clickBottomBtn{
    
    if (_clickTrue) {
        _clickTrue();
    }
    [self hideSuccess];
    [self removeFromSuperview];
    [_cover removeFromSuperview];
}
-(void)clickBack{
    if (_clickCancle) {
        _clickCancle();
    }
    [self hideSuccess];
}


-(void)clickTrueBtn{
    
    if (_clickTrueBlock) {
        _clickTrueBlock(1);
    }
    
    [self hideSuccess];
}
#pragma mark - publick


-(void)showSuccess
{
    self.hidden = NO;
    _cover.hidden = NO;
    AppDelegate *appd = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appd.window addSubview:_cover];
    [appd.window addSubview:self];
    
}
-(void)hideSuccess
{
    self.hidden = YES;
    _cover.hidden = YES;
}


#pragma mark - SET


-(void)setImageStr:(NSString *)imageStr
{
    _imageStr = imageStr;
    _headerImageV.image = [UIImage imageNamed:imageStr];
}

-(void)setMessage:(NSString *)message
{
    _message = message;
    _messgaeLb.text = message;
}

-(void)setBottomStr:(NSString *)bottomStr{
    _bottomStr = bottomStr;
    [_bottomBtn setTitle:bottomStr forState:UIControlStateNormal];
}
 



@end
