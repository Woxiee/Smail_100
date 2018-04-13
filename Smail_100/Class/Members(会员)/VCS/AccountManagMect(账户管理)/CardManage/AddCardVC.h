//
//  AddCardVC.h
//  Smail_100
//
//  Created by ap on 2018/4/12.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardModel.h"

@interface AddCardVC : KX_BaseViewController
@property(nonatomic,assign) BOOL isAdd;
@property (nonatomic, strong) CardModel *model;
@end
