//
//  GoodContenVC.h
//  MyCityProject
//
//  Created by Faker on 17/5/9.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLNavigationTabBar.h"

@interface GoodContenVC : UIViewController
@property (nonatomic, strong) NSString  *productID;
@property (nonatomic, strong) NSString  *typeStr;
@property (nonatomic, strong) UIViewController *superVC;

@property(nonatomic,strong)DLNavigationTabBar *navigationTabBar;

@property(nonatomic,strong) UIButton *backButton;


@end
