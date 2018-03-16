//
//  AllSet.m
//  Smail_100
//
//  Created by ap on 2018/3/16.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AllSet.h"

@interface AllSet ()
@property (weak, nonatomic) IBOutlet UILabel *versionLB;

@property (weak, nonatomic) IBOutlet UIView *checkView;

@property (weak, nonatomic) IBOutlet UIView *notictionView;
@property (weak, nonatomic) IBOutlet UISwitch *notictionSwift;
@property (weak, nonatomic) IBOutlet UIView *cleanBtn;
@property (weak, nonatomic) IBOutlet UIView *aboutMeVeiw;
@property (weak, nonatomic) IBOutlet UIButton *outBtn;

@end

@implementation AllSet

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}


- (void)setup
{
    self.title = @"系统设置";
    _outBtn.backgroundColor = BACKGROUND_COLORHL;
    [_outBtn addTarget:self action:@selector(didClickOutAction) forControlEvents:UIControlEventTouchUpInside];
}



- (void)didClickOutAction
{
    //清除本地数据 返回登陆页面
    [[KX_UserInfo sharedKX_UserInfo] cleanUserInfoToSanbox];
//    [KX_UserInfo presentToLoginView:self];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
