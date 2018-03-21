//
//  SelectGoodSClassVC.h
//  Smail_100
//
//  Created by ap on 2018/3/20.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectGoodSClassVC : KX_BaseViewController
@property (nonatomic,copy) void(^didClickCompleBlock)(NSArray *listArr);


@property (nonatomic,assign) BOOL isManage;   ///是否是管理分类
@end
