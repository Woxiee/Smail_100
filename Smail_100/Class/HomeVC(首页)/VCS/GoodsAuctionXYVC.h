//
//  GoodsAuctionXYVC.h
//  MyCityProject
//
//  Created by Faker on 17/5/27.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GoodsAuctionXYVC : KX_BaseViewController
@property (nonatomic, strong) NSString *clickUrl; 

@property (nonatomic, strong) NSString *agreementType; /// 1 注册协议|| @""
///2拍卖协议  ///3估价协议 ///4保证金须知
@property (nonatomic, copy)  void(^didClickComplteBlock)();
@end
