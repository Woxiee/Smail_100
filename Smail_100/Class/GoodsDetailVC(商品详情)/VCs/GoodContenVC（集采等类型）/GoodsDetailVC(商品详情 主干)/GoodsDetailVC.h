//
//  GoodsDetailVC.h
//  MyCityProject
//
//  Created by Faker on 17/5/9.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KX_PageViewController.h"
#import "GoodsScreenListModel.h"
#import "GoodSDetailModel.h"

@interface GoodsDetailVC : UIPageViewController
@property (nonatomic, strong) NSString  *productID;
@property (nonatomic, strong) NSString  *typeStr; ///商品详情类型
@property (nonatomic, strong) NSString  *detailDesc; ///图片详情
@property (nonatomic, strong) GoodsScreenListModel *model;

@end
