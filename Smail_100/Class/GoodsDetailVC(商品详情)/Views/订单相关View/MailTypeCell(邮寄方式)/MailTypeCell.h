//
//  MailTypeCell.h
//  Smile_100
//
//  Created by ap on 2018/3/7.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailTypeCell : UITableViewCell

@property (nonatomic, copy) void(^didChangeEmailTypeBlock)(NSInteger type);


@end
