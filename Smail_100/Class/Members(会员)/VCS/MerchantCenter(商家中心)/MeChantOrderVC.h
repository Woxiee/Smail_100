//
//  MeChantOrderVC.h
//  Smile_100
//
//  Created by ap on 2018/2/27.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MeChantOrderType){
    MeChantAllOrderType,                   /// 所有
    MeChantwaitOrderType,                   /// 待付款
    MeChantcommodOrderType,                   /// 待评价
    MeChantcompleOrderType,                   /// 已评价
};

@interface MeChantOrderVC : KX_BaseViewController

@property (nonatomic, assign) MeChantOrderType orderTye;

@end
