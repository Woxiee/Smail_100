//
//  GoodsAutionView.h
//  MyCityProject
//
//  Created by Faker on 17/5/31.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodSDetailModel.h"
typedef void(^DidClickAutionSureBtnBlock)(GoodSDetailModel *model);

@interface GoodsAutionView : UIView
/**
 *  显示数据
 */
- (void)show;
@property (nonatomic, strong) GoodSDetailModel *model;
@property (nonatomic, copy) DidClickAutionSureBtnBlock didClikBlock;
@end
