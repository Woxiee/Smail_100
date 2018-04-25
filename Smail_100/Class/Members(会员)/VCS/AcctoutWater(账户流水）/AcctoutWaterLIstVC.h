//
//  AcctoutWaterLIstVC.h
//  Smail_100
//
//  Created by ap on 2018/3/15.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcctoutWaterLIstVC : KX_BaseViewController
@property(nonatomic,strong) NSString *directions;  ///
@property(nonatomic,strong) NSString *type;  ///
@property (nonatomic, strong) NSString *shopID;

@property (nonatomic, strong)NSString * trans_type ;

-(void)requestListNetWork;
@end
