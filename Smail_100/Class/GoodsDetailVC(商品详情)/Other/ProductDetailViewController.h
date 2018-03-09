//
//  ProductDetailViewController.h
//  TestGoodsDetailVC
//
//  Created by Faker on 17/5/14.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailViewController : KX_BaseViewController
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString  *typeStr;
@property (nonatomic, strong) NSString  *productID;
@end
