//
//  StoreBottomView.h
//  ShiShi
//
//  Created by Faker on 17/3/7.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodSDetailModel.h"
typedef NS_ENUM(NSInteger,BuyType){
    NomalBuyType,
    NomalCollectType,  ///集采
    NomalLinkType,  ///租赁
    OtherBuyType
};
typedef void(^DidSelectBottomViewIndexBlock)(NSInteger index);
@interface StoreBottomView : UIView
@property (nonatomic, copy) DidSelectBottomViewIndexBlock selectBlock;
@property (nonatomic, assign) BuyType buyType;

@property (nonatomic, strong) GoodSDetailModel *model;

//底部状态栏
- (void)showBottonWithLogTyoe:(BuyType)buyType withRzLogModel:(GoodSDetailModel *)model;
@end
