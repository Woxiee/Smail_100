//
//  UIScrollView+KYPagingDetail.m
//  MyCityProject
//
//  Created by Faker on 17/5/15.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "UIScrollView+KYPagingDetail.h"
static const float kAnimationDuration = 0.25f;

static const char fk_originContentHeight;
static const char fk_secondScrollView;

@interface  UIScrollView ()
@property (nonatomic, assign) float originContentHeight;

@end

@implementation UIScrollView (KYPagingDetail)



- (void)setOriginContentHeight:(float)originContentHeight {
    objc_setAssociatedObject(self, &fk_originContentHeight, @(originContentHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (float)originContentHeight {
    return [objc_getAssociatedObject(self, &fk_originContentHeight) floatValue];
}


- (void)setFirstScrollView:(UIScrollView *)firstScrollView {
    [self addFirstScrollViewFooter];
}

- (UIScrollView *)secondScrollView {
    return objc_getAssociatedObject(self, &fk_secondScrollView);
}

- (void)setSecondScrollView:(UIScrollView *)secondScrollView {
    objc_setAssociatedObject(self, &fk_secondScrollView, secondScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addFirstScrollViewFooter];
    
    CGRect frame = self.bounds;
    frame.origin.y = self.contentSize.height + self.mj_footer.frame.size.height;
    secondScrollView.frame = frame;
    
    [self addSubview:secondScrollView];
    
    [self addSecondScrollViewHeader];
}

- (void)addFirstScrollViewFooter {
    __weak __typeof(self) weakSelf = self;
    
 
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf endFooterRefreshing];
    }];
    footer.triggerAutomaticallyRefreshPercent = 2;
    [footer setTitle:@"继续拖动,查看图片详情" forState:MJRefreshStateIdle];
    
    self.mj_footer = footer;
}

- (void)addSecondScrollViewHeader {
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf endHeaderRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉,返回宝贝详情" forState:MJRefreshStateIdle];
    [header setTitle:@"释放,返回宝贝详情" forState:MJRefreshStatePulling];
    
    self.secondScrollView.mj_header = header;
}

- (void)endFooterRefreshing {
    [self.mj_footer endRefreshing];
    self.mj_footer.hidden = YES;
    self.scrollEnabled = NO;
    
    self.secondScrollView.mj_header.hidden = NO;
    self.secondScrollView.scrollEnabled = YES;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        LOG(@"%f",self.contentOffset.y);
        
//        if (self.contentOffset.y - SCREEN_HEIGHT > 50) {
            self.contentInset = UIEdgeInsetsMake(-self.contentSize.height - self.mj_footer.frame.size.height, 0, 0, 0);
//        }
    }];
    
    self.originContentHeight = self.contentSize.height;
    self.contentSize = self.secondScrollView.contentSize;
    LOG(@"%f",self.secondScrollView.contentSize.height);
    LOG(@"%f",self.contentOffset.y);

}

- (void)endHeaderRefreshing {
    [self.secondScrollView.mj_header endRefreshing];
    self.secondScrollView.mj_header.hidden = YES;
    self.secondScrollView.scrollEnabled = NO;
    
    self.scrollEnabled = YES;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.contentInset = UIEdgeInsetsMake(0, 0, self.mj_footer.frame.size.height, 0);
    }];
    self.contentSize = CGSizeMake(0, self.originContentHeight);
    
    [self setContentOffset:CGPointZero animated:YES];

    [self addFirstScrollViewFooter];
}


@end
