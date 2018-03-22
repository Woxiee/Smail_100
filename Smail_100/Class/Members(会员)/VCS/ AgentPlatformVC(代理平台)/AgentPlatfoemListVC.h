//
//  AgentPlatfoemListVC.h
//  Smail_100
//
//  Created by ap on 2018/3/22.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgentPlatfoemListVC : KX_BaseViewController
@property (nonatomic, strong) NSString *orderState;
-(void)requestListNetWork;

@end
