//
//  StoreMangerVHeadView.h
//  Smile_100
//
//  Created by ap on 2018/2/27.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreMangerVHeadView : UIView
@property (nonatomic, copy) void(^didClickStoreMangerBlock)(NSInteger index);
@end
