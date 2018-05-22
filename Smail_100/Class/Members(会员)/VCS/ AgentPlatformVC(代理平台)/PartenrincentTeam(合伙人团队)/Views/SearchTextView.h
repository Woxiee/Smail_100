//
//  SearchTextView.h
//  Smail_100
//
//  Created by ap on 2018/5/18.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTextView : UIView
@property (nonatomic, strong) UITextField *seachTF;
@property (nonatomic, strong) UIButton *seachBtn;

@property (nonatomic, copy) void(^didClickSearchBlock)(NSString *searhText);
@end
