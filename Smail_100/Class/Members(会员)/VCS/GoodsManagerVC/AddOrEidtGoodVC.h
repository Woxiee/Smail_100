//
//  AddOrEidtGoodVC.h
//  Smail_100
//
//  Created by Faker on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeChantOrderModel.h"
@interface AddOrEidtGoodVC : KX_BaseViewController
@property (nonatomic, assign)  BOOL isEnabled;
@property (nonatomic, assign)  BOOL isAdd;

@property (nonatomic, strong) MeChantOrderModel *model;
@end
