//
//  AttributeListView.h
//  MyCityProject
//
//  Created by Faker on 17/5/11.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodSDetailModel.h"


@interface AttributeListView : UIView
@property (nonatomic, strong) GoodSDetailModel *model;
@property (nonatomic, strong) NSArray *extAttrbuteArray;
@property (nonatomic, strong) NSArray *dizhiArr;
@property (nonatomic, copy) void (^didClickCellBlock)(NSString *str);
- (void)show;

@end
