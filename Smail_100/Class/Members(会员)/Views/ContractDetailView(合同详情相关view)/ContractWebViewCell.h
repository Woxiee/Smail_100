//
//  ContractWebViewCell.h
//  MyCityProject
//
//  Created by Faker on 17/7/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContracDetailModel.h"
#import "OrderDetailModel.h"
@interface ContractWebViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) ContracDetailModel *model;

@end
