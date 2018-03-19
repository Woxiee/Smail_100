//
//  RighMeumtCell.h
//  Smail_100
//
//  Created by ap on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RighMeumtCell : UITableViewCell
@property(nonatomic,strong) void(^cellAdd)(void);
@property(nonatomic,strong) void(^cellReduce)(void);
@property(nonatomic,strong) void(^cellInputText)(void);
@end
