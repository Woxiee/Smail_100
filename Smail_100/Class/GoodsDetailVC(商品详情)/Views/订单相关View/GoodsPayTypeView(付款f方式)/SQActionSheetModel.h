//
//  SQActionSheetModel.h
//  MyCityProject
//
//  Created by Faker on 17/7/26.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQActionSheetModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) NSInteger tag;

@end
