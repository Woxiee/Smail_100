//
//  FindPaypwdVC.m
//  Smail_100
//
//  Created by ap on 2018/4/4.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "FindPaypwdVC.h"
#import "KYCodeBtn.h"

@interface FindPaypwdVC ()
@property (weak, nonatomic) IBOutlet KYCodeBtn *yzmBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *oldPswTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *pswTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation FindPaypwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_loginBtn layerForViewWith:3 AndLineWidth:0.5];
    _loginBtn.backgroundColor = KMAINCOLOR;

}

- (IBAction)didMissActionBtn:(id)sender {
 
}




@end
