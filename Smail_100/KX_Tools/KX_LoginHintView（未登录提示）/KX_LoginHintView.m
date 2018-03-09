//
//  KX_LoginHintView.m
//  KX_Service
//
//  Created by Faker on 16/10/13.
//
//

#import "KX_LoginHintView.h"

@interface KX_LoginHintView()
{
    UIImageView *noOlderImage;
    UILabel *noOlderLabel;
   
}
@property (nonatomic, strong) UIButton *noOlderBtn;
@end

@implementation KX_LoginHintView
+ (instancetype) loginHintViewWithImage:(NSString *)image andMsg:(NSString *)msg andBtnTitle:(NSString *)title andFrame:(CGRect)frame
{
    return [[self alloc] initWithImage:image andMsg:msg andBtnTitle:title andFrame:frame];
}

+(instancetype) notDataView
{
    //TODO JP
    
    return [[self alloc] initWithImage:@"6@3x.png" andMsg:@"没有更多数据" andBtnTitle:@"" andFrame:CGRectMake(0, 40, SCREEN_WIDTH,  SCREEN_HEIGHT - 140)];

}

+(void)notDataView:(UIView *)superView
{
    //TODO JP
    //删除相关的
    for (id obj in superView.subviews) {
        if ([obj isKindOfClass:[KX_LoginHintView class]]) {
            return ;
        }
    }
    [superView addSubview:[[self alloc] initWithImage:@"shangchengdingdan2@3x.png" andMsg:@"没有更多数据" andBtnTitle:@"" andFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 140)]];
}

+(void)removeFromSupView:(UIView *)supView
{
    //删除相关的
    for (id obj in supView.subviews) {
        if ([obj isKindOfClass:[KX_LoginHintView class]]) {
            KX_LoginHintView *logV = (KX_LoginHintView *)obj;
            [logV removeFromSuperview];
        }
    }
}
- (instancetype)initWithImage:(NSString *)image andMsg:(NSString *)msg andBtnTitle:(NSString *)title andFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BACKGROUND_COLOR;
        noOlderImage = [[UIImageView alloc] init];
        [self addSubview:noOlderImage];
        
        if (KX_NULLString(image)) {
            image = DEFAULTIMAGE;
        }
        UIImage *img = [UIImage imageNamed:image];
        [noOlderImage setImage:img];
   
        noOlderLabel = [[UILabel alloc] init];
        [self addSubview:noOlderLabel];
        [noOlderLabel setText:msg];
        noOlderLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        noOlderLabel.textColor = RGB(159, 164, 160);
        noOlderLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.noOlderBtn];
        if ([title isEqualToString:@""] || title.length == 0) {
            _noOlderBtn.hidden = YES;
        }else{
            [_noOlderBtn setTitle:title forState:UIControlStateNormal];

        }
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        CGFloat imgW = width * 0.2;
        CGFloat imgH = img.size.height / img.size.width * imgW;
        
        [noOlderImage setFrame:CGRectMake((width - imgW) * 0.5, (height - imgH) * 0.15, imgW, imgH)];
        
        [noOlderLabel setFrame:CGRectMake(0, CGRectGetMaxY(noOlderImage.frame)+10, width, 20)];
        
        [_noOlderBtn setFrame:CGRectMake(15, CGRectGetMaxY(noOlderLabel.frame)+48, width - 30, 40)];

    }
    return self;
    
}




#pragma mark  - 懒加载

- (UIButton *)noOlderBtn
{
    if (_noOlderBtn == nil) {
        _noOlderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _noOlderBtn.backgroundColor = RGB(77, 107, 171);
        [_noOlderBtn layerForViewWith:4 AndLineWidth:0];
        [_noOlderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_noOlderBtn addTarget:self action:@selector(didClickNoDataAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noOlderBtn;
}


#pragma mark - private
/// 点击 无数据按钮
- (void)didClickNoDataAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickNoDataBtnInHintView)]) {
        [_delegate didClickNoDataBtnInHintView];
    }
}



@end
