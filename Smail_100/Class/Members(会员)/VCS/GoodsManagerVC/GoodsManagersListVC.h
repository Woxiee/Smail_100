//
//  GoodsManagersListVC.h
//  Smile_100
//
//  Created by ap on 2018/2/28.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsManagersListVC : KX_BaseViewController
@property (nonatomic, strong) NSString *orderTypeTitle;
-(void)requestListNetWork;
@end
