//
//  KYRefreshGifHeader.m
//  KYRefreshDemo
//
//  Created by mac_KY on 17/1/15.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import "KYRefreshGifHeader.h"

@implementation KYRefreshGifHeader

-(void)prepare
{
    
    [super prepare];
    
    //设置动画图片 stringWithFormat:@"dropdown_anim__000%zd",i]];
    
    NSMutableArray *gifImages = [NSMutableArray array];
    
    for (int i=1; i<30; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd",i]];
        if (!image) {
            NSAssert(image != nil, @"刷新图片不能为空！");
            NSLog(@"My name is %@.",image);
        }
        [gifImages addObject:image];
        
    }
    
    [self setImages:gifImages forState:MJRefreshStateIdle];
     
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态） stringWithFormat:@"dropdown_loading_0%zd", i]];
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        if (!image) {
            NSAssert(image != nil, @"刷新图片不能为空！");
            NSLog(@"My name is %@.",image);
        }
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
