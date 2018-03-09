//
//  CommitSuccessVC.m
//  MyCityProject
//
//  Created by mac_KY on 17/5/26.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "CommitSuccessVC.h"

@interface CommitSuccessVC ()
@property (weak, nonatomic) IBOutlet UIButton *truebtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation CommitSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadComment];
    [self loadSubView];
    [self loadData];
    
}

#pragma mark - 常数设置
-(void)loadComment
{
    
}


#pragma mark - 初始化子View
-(void)loadSubView
{
    [self loadNavItem];

    [_truebtn layerForViewWith:4 AndLineWidth:0];
    [_backBtn layerWithRadius:4 lineWidth:0.5 color:BACKGROUND_COLORHL];
    
}

-(void)loadNavItem
{
    self.title = @"提交成功";
//    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"返回"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:nil];
    
}


#pragma mark - 网络数据请求
-(void)loadData
{
    
}
#pragma mark - 点击事件
- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)clickTrue:(id)sender {
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}



#pragma mark - private


@end
