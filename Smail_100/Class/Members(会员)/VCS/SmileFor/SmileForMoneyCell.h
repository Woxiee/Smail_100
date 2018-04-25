//
//  SmileForMoneyCell.h
//  Smail_100
//
//  Created by ap on 2018/4/13.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmileForMoneyCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic, strong)  NSDictionary *dataDic;
@property (nonatomic, strong)  NSString  *showType;

@property (nonatomic, copy)  void(^didClickValueBlock)(NSString *text);
@end
