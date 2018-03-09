//
//  KX_BlurEffectMenu.m
//  KX_Service
//
//  Created by Frank on 16/10/21.
//
//

#import "KX_BlurEffectMenu.h"

@implementation BlurEffectMenuItem

@end

@implementation KX_BlurEffectMenu
{
    UIButton *_dissMissBtn;
}

- (instancetype)initWithMenus:(NSArray *)menus WithAddMenusType:(AddMenuType)addMenuType{
    self=[super init];
    if (self) {
        self.menuItemArr=menus;
        self.addMenuType = addMenuType;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //手势
    [self gesture];
    
    //布局View
    [self setUpView];
}

- (void)gesture{
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapOnBackground)]];
    
    UISwipeGestureRecognizer *swipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didTapOnBackground)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:swipeGesture];
}

#pragma mark - setUpView
- (void)setUpView{
    //毛玻璃
    //    UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //    UIVisualEffectView *visualEffectView=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
    //    [visualEffectView setFrame:self.view.bounds];
    //    [self.view addSubview:visualEffectView];
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = RGB(184, 184, 187);
    titleLabel.frame = CGRectMake((SCREEN_WIDTH - 100)/2, 16, 100, 48);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    
    _dissMissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (SCREEN_HEIGHT > 375) {
        _dissMissBtn.frame = CGRectMake((SCREEN_WIDTH - 38), 33, 20, 20);
        
    }else{
        _dissMissBtn.frame = CGRectMake((SCREEN_WIDTH - 35), 33, 20, 20);
    }
    [_dissMissBtn setImage:[UIImage imageNamed:@"xj-close"] forState:UIControlStateNormal];
    [_dissMissBtn addTarget:self action:@selector(didTapOnBackground) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_dissMissBtn];
    
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:.9];
    
    float offsetY  = 0;
    
    if (_addMenuType == LogNAddMenuType) {
        titleLabel.text = @"新增日志";
        offsetY = 100;
    }else if (_addMenuType ==  ApprovalMenuType){
        titleLabel.text = @"新增审批";
        offsetY = 50;
    }else if (_addMenuType == AddressNeWGroupChatType){
        offsetY = 100;
        titleLabel.text = @"新增群聊";
        
    }else if (_addMenuType == AddressNewCRM){
        offsetY = 50;
        titleLabel.text = @"新建";
    }
    
    //三列
    NSInteger totalloc=3;
    CGFloat appvieww=80;
    CGFloat appviewh=80;
    CGFloat margin=(self.view.frame.size.width-totalloc*appvieww)/(totalloc+1);
    
    for (NSInteger i=0; i<self.menuItemArr.count; i++) {
        NSInteger row=i/totalloc;//行号
        NSInteger loc=i%totalloc;//列号
        CGFloat appviewx=margin+(margin+appvieww)*loc;
        CGFloat appviewy=offsetY+(50+appviewh)*row;
        
        //button
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(appviewx, -300, appvieww, appviewh)];
        [button setTag:i];
        [button addTarget:self action:@selector(itemBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        //label
        UILabel *label=[[UILabel alloc]init];
        [label setFrame:CGRectMake(appviewx, button.frame.origin.y+button.bounds.size.height+5, appvieww, 25)];
        [label setTextColor:[UIColor grayColor]];
        [label setFont:[UIFont systemFontOfSize:14.0]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTag:i];
        [self.view addSubview:label];
        
        
        BlurEffectMenuItem *item=self.menuItemArr[i];
        [button setImage:item.icon forState:UIControlStateNormal];
        [label setText:item.title];
        
        ///动画开始
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            //UIView animate动画:仿钉钉弹出添加按钮,从顶部弹到指定位置
            [UIView animateWithDuration:1.f delay:(0.2-0.02*i) usingSpringWithDamping:1.0f initialSpringVelocity:15.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                if (self.menuItemArr.count == 1) {
                    button.center = self.view.center;
                    button.frame = CGRectMake(self.view.center.x -appvieww/2 , self.view.center.y - appvieww - 15, appvieww,appviewh);
                    label.center = self.view.center;
                    
                }else{
                    button.frame = CGRectMake(appviewx, appviewy+100, appvieww,appviewh);
                    [label setFrame:CGRectMake(appviewx, button.frame.origin.y+button.bounds.size.height+5, appvieww, 25)];
                }
            } completion:^(BOOL finished) {
            }];
        });
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.5f  animations:^{
            _dissMissBtn.transform=CGAffineTransformMakeRotation(-M_PI/4);
        }];
    });
    
}

#pragma mark - Event
- (void)didTapOnBackground{
    //点击空白处，dismiss
    
    [self customAnimation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        if (_delegate&&[_delegate respondsToSelector:@selector(blurEffectMenuDidTapOnBackground:)]) {
            [_delegate blurEffectMenuDidTapOnBackground:self];
        }
    });
}

- (void)itemBtnClicked:(UIButton *)sender{
    //点击按钮缩放代码
    [UIView animateWithDuration:0.25 animations:^{
        sender.transform=CGAffineTransformMakeScale(1.7,1.7);
    }];
    //button dismiss动画  Spring Animation
    [self customAnimation];
    //    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(blurEffectMenu:didTapOnItem:)]) {
            [_delegate blurEffectMenu:self didTapOnItem:self.menuItemArr[sender.tag]];
        }
    });
}

#pragma mark - UIView animation
//Spring Animation
- (void)customAnimation{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn=(UIButton *)view;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                //UIView animate动画:仿钉钉弹出添加按钮,从顶部弹到指定位置
                [UIView animateWithDuration:1.f delay:0.02*(btn.tag) usingSpringWithDamping:0.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    btn.frame = CGRectMake(btn.frame.origin.x, -300, btn.frame.size.width,btn.frame.size.height);
                } completion:^(BOOL finished) {
                }];
            });
        }
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label=(UILabel *)view;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                //UIView animate动画:仿钉钉弹出添加按钮,从顶部弹到指定位置
                [UIView animateWithDuration:1.f delay:0.02*(label.tag) usingSpringWithDamping:0.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [label setTextColor:[UIColor clearColor]];
                } completion:^(BOOL finished) {
                }];
            });
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
