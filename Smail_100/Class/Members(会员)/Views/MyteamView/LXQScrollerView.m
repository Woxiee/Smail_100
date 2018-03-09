//
//  LXQScrollerView.m
//  memuDemo
//
//  Created by Jerry on 2017/7/5.
//  Copyright © 2017年 Jerry. All rights reserved.
//

#import "LXQScrollerView.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface LXQScrollerView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *bigScrollerView;
@property (nonatomic, strong) UIView        *line;
@property (nonatomic, strong) UIView        *topView;
@property (nonatomic, assign) NSInteger     selectIndex;
@property (nonatomic, strong) NSArray       *titleArray;
@property (nonatomic, strong) NSArray       *chaildVCArray;

@property (nonatomic, assign) NSInteger     count;

@end

@implementation LXQScrollerView

- (instancetype)initWithFrame:(CGRect)frame
                   titleArray:(NSArray *)array chaildVCArray:(NSArray *)chaildVCArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectIndex = 0;
        self.titleArray = array;
        self.chaildVCArray = chaildVCArray;
        self.count = array.count;
        [self prepareTopUI];
        [self prepareScrollerViewUI];
    }
    return self;
}

- (void)prepareTopUI
{
    self.line  = [[UIView alloc] initWithFrame:CGRectMake(0, 47.5, kWidth / self.count, 2)];
    self.line.backgroundColor = [UIColor redColor];
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 50)];
    self.topView.backgroundColor = [UIColor whiteColor];
    NSArray *listArr = @[@"I 创客",@"II 创客",@"III 创客"];
    for (NSInteger i = 0; i < self.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kWidth / self.count * i, 0, kWidth / self.count, _topView.frame.size.height);
        //        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.topView addSubview:button];
        
        UILabel *numberLB = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / self.count * i, 8, kWidth / self.count, 20)];
        numberLB.text = _titleArray[i];
        numberLB.font = Font14;
        numberLB.textColor = KMAINCOLOR;
        numberLB.textAlignment = NSTextAlignmentCenter;
        [self.topView addSubview:numberLB];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / self.count * i, CGRectGetMaxY(numberLB.frame), kWidth / self.count, 20)];
        titleLB.text = listArr[i];
        titleLB.font =Font14;
        titleLB.textAlignment = NSTextAlignmentCenter;
        [self.topView addSubview:titleLB];
        
    }
    
    for (int i = 0; i<3; i++) {
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake( kWidth / self.count * i, 5, 1, _topView.frame.size.height -10)];
        lineView2.backgroundColor = LINECOLOR;
        [self.topView  addSubview:lineView2];
        
    }
    [self.topView addSubview:self.line];
    [self addSubview:self.topView];
    [self changeButtonTextColor];
}

- (void)prepareScrollerViewUI
{
    self.bigScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, kWidth, self.frame.size.height - 50)];
    self.bigScrollerView.contentSize = CGSizeMake(kWidth * self.count, self.frame.size.height - 50);
    self.bigScrollerView.scrollEnabled = YES;
    self.bigScrollerView.pagingEnabled = YES;
    self.bigScrollerView.delegate = self;
    [self addSubview:self.bigScrollerView];
    
    for (NSInteger i = 0; i < self.chaildVCArray.count; i++) {
        UIViewController *VC =  self.chaildVCArray[i];
        VC.view.frame = CGRectMake(kWidth * i, 0, kWidth, kHeight - 64 - 50);
        [self.bigScrollerView addSubview:VC.view];
    }
    
}

- (void)buttonAction:(UIButton *)button
{
    self.selectIndex = button.tag;
    [self changeButtonTextColor];
    [self changeLinePlaceWithIndex:button.tag];
    [self changeScrollerViewPlace];
}

//改变滚动视图位置
- (void)changeScrollerViewPlace
{
    [UIView animateWithDuration:0.5 animations:^{
        
        CGPoint offset = self.bigScrollerView.contentOffset;
        offset.x = kWidth * self.selectIndex;
        self.bigScrollerView.contentOffset = offset;
    }];
}

//改变选中字体颜色
- (void)changeButtonTextColor
{
    for (UIView *view in [self.topView subviews]) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)view;
            
            if (button.tag == self.selectIndex) {
                [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            }else{
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
}

//改变line位置
- (void)changeLinePlaceWithIndex:(NSInteger)index
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.line.frame;
        frame.origin.x = kWidth / self.count * index;
        self.line.frame = frame;
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    self.selectIndex = x / kWidth;
    [self changeButtonTextColor];
    [self changeLinePlaceWithIndex:self.selectIndex];
}


@end

