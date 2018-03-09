//
//  KX_ShareView.m
//  KX_Service
//
//  Created by ac on 16/8/10.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import "KX_ShareView.h"

@interface KX_ShareView()
@property (nonatomic, strong) UIView *showView;

@end

@implementation KX_ShareView

+(instancetype)shareViewWithImageArray:(NSArray *)imgArr andSelectItemBlock:(SelectItemBlock)block;
{
    return [[self alloc] initShareWithImageArray:imgArr andSelectItemBlcok:block];
}

- (instancetype)initShareWithImageArray:(NSArray *)imgArr andSelectItemBlcok:(SelectItemBlock)block
{
    if (self= [super init]) {
        
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        _showView = [UIView new];
        _showView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_HEIGHT, 200);
        
        
    }
    
    return self;
}

- (void)finish
{

}

@end
