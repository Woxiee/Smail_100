//
//  AssetModel.h
//  MyCityProject
//
//  Created by Faker on 17/6/15.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetModel : NSObject
@property (nonatomic , copy) NSString              * instrumentState;
@property (nonatomic , copy) NSString              * estimatedLeasePrice;
@property (nonatomic , copy) NSString              * manufacturer;
@property (nonatomic , copy) NSString              * className;
@property (nonatomic , copy) NSString              * icpNo;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * model;
@property (nonatomic , copy) NSString              * param1;
@property (nonatomic , copy) NSString              * creditEvaluationPrice;
@property (nonatomic , copy) NSString              * applyState;
@property (nonatomic , copy) NSString              * estimatedPrice;
@property (nonatomic, assign) BOOL isWhole;


@property (nonatomic , copy) NSString              * num;
@property (nonatomic , copy) NSString              * partsName;
@property (nonatomic , copy) NSString              * structures;


@property (nonatomic , copy) NSString              * mainId;
@property (nonatomic , copy) NSString              * subId;
@property (nonatomic , copy) NSString              * mainParam2;
@property (nonatomic , copy) NSString              * mainParam1;
@property (nonatomic , copy) NSString              * productName;
@property (nonatomic , copy) NSString              * parentClassId;
@property (nonatomic , copy) NSString              * classId;
@end
