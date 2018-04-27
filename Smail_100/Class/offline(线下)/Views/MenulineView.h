//
//  MenulineView.h
//  Smail_100
//
//  Created by Faker on 2018/4/26.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenulineView : UIView
@property (nonatomic, copy) void (^didClickSureBlock)(NSString *valueStr);

@property (nonatomic, strong)   UITextField *textField;


@end

