//
//  ChangeThePhoneVC.m
//  Smail_100
//
//  Created by ap on 2018/3/21.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "ChangeThePhoneVC.h"

@interface ChangeThePhoneVC ()
@property (weak, nonatomic) IBOutlet UITextField *accoutTF;
@property (weak, nonatomic) IBOutlet UITextField *balanceTF;
@property (weak, nonatomic) IBOutlet UITextField *isValueTF;
@property (weak, nonatomic) IBOutlet UITextField *inputTf;

@end

@implementation ChangeThePhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
}

#pragma mark - request
- (void)getRequestData
{
    
    
}

#pragma mark - private
- (void)setup
{
    self.title = @"话费兑换";
    _accoutTF.text = [KX_UserInfo sharedKX_UserInfo].mobile;
    
    _balanceTF.text = [KX_UserInfo sharedKX_UserInfo].phone_money;
    _isValueTF.text = [KX_UserInfo sharedKX_UserInfo].mtime;
    
}

- (void)setConfiguration
{
    
}

#pragma mark - publice


#pragma mark - set & get



#pragma mark - delegate




@end
