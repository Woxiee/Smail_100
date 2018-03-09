//
//  SubmitSuccessVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/9.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "SubmitSuccessVC.h"
#import "HomeVC.h"
@interface SubmitSuccessVC ()
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation SubmitSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfiguration];


}

/// 配置基础设置
- (void)setConfiguration
{
   self.title = @"提交成功";
    _sendBtn.backgroundColor = BACKGROUND_COLORHL;
    [_sendBtn layerForViewWith:2 AndLineWidth:0];
}


- (IBAction)didClickSendBtn:(id)sender {

    
}


- (void)popVC
{
    NSArray *ctrlArray = self.navigationController.viewControllers;

    for (UIViewController *ctrl in ctrlArray) {
        if ([ctrl isKindOfClass:[HomeVC class]]) {
            [self.navigationController popToViewController:ctrl animated:YES];
            break;
        }
    }

}


@end
