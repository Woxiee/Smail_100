//
//  GoodsCommonChooseView.h
//  ShiShi
//
//  Created by Faker on 17/3/13.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidClickChooseSureBtnBlock)(NSString *typeStr);
@interface GoodsCommonChooseView : UIView
/**
 *  显示数据
 */
- (void)show;
@property (nonatomic, copy) DidClickChooseSureBtnBlock chooseSureBlock;
@end
