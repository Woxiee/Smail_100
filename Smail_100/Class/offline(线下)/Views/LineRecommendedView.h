//
//  LineRecommendedView.h
//  Smile_100
//
//  Created by ap on 2018/3/6.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OffLineModel.h"
@interface LineRecommendedView : UIView
@property (nonatomic, strong) NSArray *catelist;

@property (nonatomic, copy) void(^didClickItemBlock)(Catelist *item);
@end
