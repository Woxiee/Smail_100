//
//  SendCommentsVC.h
//  MyCityProject
//
//  Created by Faker on 17/6/10.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
typedef NS_ENUM(NSInteger, SendCommenType){
    EdieTypeType,                   /// edieType
    ShowTypeType,                   /// edieType
    
};
@interface SendCommentsVC : UIViewController
@property (nonatomic, strong) OrderModel *model;
@property (nonatomic, assign) SendCommenType commeType;
@end
