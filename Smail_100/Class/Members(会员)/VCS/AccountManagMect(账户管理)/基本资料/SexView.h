//
//  SexView.h
//  ShiShi
//
//  Created by ac on 16/4/18.
//  Copyright © 2016年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SexView : UIView

//确定选择
@property(nonatomic,strong) void(^chooseSex)(NSString * sexKind);

//取消选择
@property(nonatomic,strong) void(^cannelChoose)(void);

@end
