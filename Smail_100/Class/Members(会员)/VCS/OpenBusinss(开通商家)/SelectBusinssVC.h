//
//  SelectBusinssVC.h
//  Smail_100
//
//  Created by ap on 2018/3/24.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildModel.h"
@interface SelectBusinssVC : KX_BaseViewController
@property (nonatomic,copy) void(^didClickCompleBlock)(ChildModel *model);

@end
