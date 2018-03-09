//
//  KX_ShareView.h
//  KX_Service
//
//  Created by ac on 16/8/10.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectItemBlock)(NSInteger item);
@interface KX_ShareView : UIView

@property (nonatomic, copy) SelectItemBlock selectItemBlck;
+(instancetype)shareViewWithImageArray:(NSArray *)imgArr andSelectItemBlock:(SelectItemBlock)block;

- (void)show;

- (void)dissmiss;


@end
