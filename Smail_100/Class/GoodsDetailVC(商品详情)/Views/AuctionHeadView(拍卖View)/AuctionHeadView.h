//
//  AuctionHeadView.h
//  MyCityProject
//
//  Created by Faker on 17/6/29.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodSDetailModel.h"
@interface AuctionHeadView : UIView
@property (nonatomic, strong) GoodSDetailModel *model;
@property (nonatomic, copy) void(^didEndTimeBlock)();
- (void)stopTimer;
@end
