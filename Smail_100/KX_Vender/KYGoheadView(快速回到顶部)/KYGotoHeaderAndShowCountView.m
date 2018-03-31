//
//  KYGotoHeaderAndShowCountView.m
//  ShiShi
//
//  Created by Faker on 17/3/24.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "KYGotoHeaderAndShowCountView.h"
#import "KYShowCountView.h"
@interface KYGotoHeaderAndShowCountView()<ShowCountViewDelegate>

@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,weak) KYShowCountView *countView;
@property (nonatomic,assign) BOOL death;

@property (nonatomic,copy) KYGotoHeaderAndShowCountViewBlock block;

@property (nonatomic,assign) NSInteger currentCount;
@property (nonatomic,assign) NSInteger maxCount;

@end

@implementation KYGotoHeaderAndShowCountView


+ (instancetype)shareFKHeaderAndShowCountViewWithFrame:(CGRect)frame view:(UIView*) view block:(KYGotoHeaderAndShowCountViewBlock)block
{
    return [[self alloc] initWithFrame:frame view:view block:block];
}

- (instancetype) initWithFrame:(CGRect)frame view:(UIView *)superView block:(KYGotoHeaderAndShowCountViewBlock)block
{
    self = [super init];
    if (self)
    {
//        self.backgroundColor = [UIColor redColor];
        self.frame = frame;
        KYShowCountView *countView = [[KYShowCountView alloc] initWithFrame:self.bounds withSuperView:superView];
        [superView bringSubviewToFront:self];
        self.countView = countView;
        [self addSubview:countView];
        [superView addSubview:self];
        
        countView.delegate = self;
        
        self.block = block;
        self.countView.hidden = YES;
    }
    return self;
}

/*
 *
 *    @param cCount  当前数量
 *    @param mCount  当前总数量
 */
- (void)fkGotoHeaderAndShowCountViewWhitCurrentCout:(NSInteger)cCount max:(NSInteger)mCount;
{
    _currentCount = cCount;
    if (_currentCount > mCount) {
        _currentCount = mCount;
    }
    _maxCount = mCount;
    
    if (self.death) {
        return;
    }
    
    if (cCount >5) {
        self.countView.hidden = NO;
    }
    else
    {
        self.countView.hidden = YES;
    }
}


- (void)fkGotoHeaderAndShowCountViewWithScrollView:(UIScrollView *)scrollView
{
    if (self.death) {
        return;
    }
    
    if (scrollView.isDragging) {
        [self.countView showCountViewWithCurrentCount:self.currentCount withMaxCount:self.maxCount show:NO];
    }
    else
    {
        /// 待优化
        [self.countView showCountViewWithCurrentCount:self.currentCount withMaxCount:self.maxCount show:NO];
    }
}



- (void)removeGotoHeaderAndShowCountView
{
    self.death = YES;
    self.countView.hidden = YES;
}

- (void)addGotoHeaderAndShowCountView
{
    self.death = NO;
    if (_currentCount > 20) {
        self.countView.hidden = NO;
    }
}


#pragma mark - ShowCountViewDelegate
- (void)showCountViewDidClick:(KYShowCountView *)view
{
    if (self.block) {
        self.block();
    }
}

@end
