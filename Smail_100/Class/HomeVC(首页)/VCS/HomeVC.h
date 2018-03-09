//
//  HomeVC.h
//  MyCityProject
//
//  Created by Faker on 17/5/3.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : KX_BaseViewController

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSDictionary *param;
@property (nonatomic, strong) NSString *categoryId;
- (void)getHomeGoodsRequest:(NSString *)categoryId;

@end
