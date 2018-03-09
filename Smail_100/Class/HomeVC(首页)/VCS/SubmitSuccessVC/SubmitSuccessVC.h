//
//  SubmitSuccessVC.h
//  MyCityProject
//
//  Created by Faker on 17/5/9.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, OrderSuccessType) {
    InsuranceOrderSuccessType,
    FinciaceOrderSuccessType,
};
@interface SubmitSuccessVC : KX_BaseViewController

@property (nonatomic, assign) OrderSuccessType successType;
@property (nonatomic, strong) NSString *typeStr;

@end
