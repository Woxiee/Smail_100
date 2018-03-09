//
//  LoginFindAndRegirsVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/18.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "LoginFindAndRegirsVC.h"

@interface LoginFindAndRegirsVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginFindAndRegirsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfiguration];
}

/// 配置基础设置
- (void)setConfiguration
{
    if (_isFindPwd) {
        _titleLB.text = @"恭喜您, 您已成功找回密码!";
        self.title = @"找回密码";
    }else{
        _titleLB.text = @"恭喜您, 您已注册成功!";
        self.title = @"注册";
    }
    
    self.view.backgroundColor = [UIColor whiteColor];

    _titleLB.textColor = DETAILTEXTCOLOR;
    _titleLB.font = Font15;
    
    [_loginBtn layerForViewWith:3 AndLineWidth:0];
}

- (IBAction)didClickLoginClicj:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
