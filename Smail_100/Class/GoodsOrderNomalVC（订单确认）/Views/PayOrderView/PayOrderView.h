//
//  PayOrderView.h
//  JXActionSheet
//
//  Created by ap on 2018/3/9.
//  Copyright © 2018年 JX.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, PayType) {
    PayTypeNoaml,

    PayTypeOther,

};

@interface PayOrderView : UIView
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, assign) PayType payType;
@property (nonatomic, copy) void(^didClickPayTypeBlock)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame withPayType:(PayType)payType;

- (void)show;

@end
