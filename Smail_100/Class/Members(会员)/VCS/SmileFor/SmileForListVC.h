//
//  SmileForListVC.h
//  Smail_100
//
//  Created by Faker on 2018/4/14.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmileForListVC : KX_BaseViewController
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *shopID; ///

- (void)requestListNetWork;
@end
