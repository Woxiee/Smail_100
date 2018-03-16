//
//  AcctoutWaterLIstVC.h
//  Smail_100
//
//  Created by ap on 2018/3/15.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcctoutWaterLIstVC : KX_BaseViewController
@property(nonatomic,strong) NSString *direction;  ///
@property(nonatomic,strong) NSString *trans_type;  ///

-(void)requestListNetWork;
@end
