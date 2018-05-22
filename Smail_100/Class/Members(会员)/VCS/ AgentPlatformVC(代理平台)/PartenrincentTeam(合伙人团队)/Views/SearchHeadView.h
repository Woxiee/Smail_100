//
//  SearchHeadView.h
//  Smail_100
//
//  Created by ap on 2018/5/18.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySelectTeamView.h"

@interface SearchHeadView : UIView
@property (nonatomic, strong) UITextField *seachTF;
@property (nonatomic, strong) UIButton *seachBtn;
@property (nonatomic, strong) MySelectTeamView *selectTeamView;

@property (nonatomic, copy) void(^didClickSearchBlock)(NSString *searhText);
@property (nonatomic, strong) NSString  *type;

- (instancetype)initWithFrame:(CGRect)frame withType:(NSString *)type;
@end
