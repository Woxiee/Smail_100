//
//  SetLoginPwdVC.m
//  Smail_100
//
//  Created by ap on 2018/4/3.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SetLoginPwdVC.h"

@interface SetLoginPwdVC ()
@property (weak, nonatomic) IBOutlet UIView *oldPwdView;
@property (weak, nonatomic) IBOutlet UIView *surePwdView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oldPwdContensH;
@property (weak, nonatomic) IBOutlet UIView *newsPwdView;

@end

@implementation SetLoginPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _oldPwdContensH.constant = 0;
}



@end
