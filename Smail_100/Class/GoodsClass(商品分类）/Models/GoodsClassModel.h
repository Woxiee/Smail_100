//
//  GoodsClassModel.h
//  MyCityProject
//
//  Created by Faker on 17/6/14.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsScreenmodel.h"
@interface GoodsClassModel : NSObject

@property (nonatomic, copy)  NSString *id;
@property (nonatomic, copy)  NSString *name;
@property (nonatomic, assign) BOOL select;

@property (nonatomic , strong) NSArray<Values *>              * values;
@end
