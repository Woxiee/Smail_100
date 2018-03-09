//
//  KX_BaseNavController.m
//  KX_Service
//
//  Created by mac_JP on 16/12/8.
//
//

#import "KX_BaseNavController.h"

@interface KX_BaseNavController ()<UINavigationControllerDelegate>


@end

@implementation KX_BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}




-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
     [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count>1) {
        
        UIButton * leftNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftNaviBtn.frame=CGRectMake(0, 0, 44, 44);
        [leftNaviBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [leftNaviBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
        [leftNaviBtn setTitle:@"返回" forState:UIControlStateNormal];
        leftNaviBtn.titleLabel.font=[UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
        [leftNaviBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        leftNaviBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        leftNaviBtn.backgroundColor=[UIColor clearColor];
        [leftNaviBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:leftNaviBtn];
        viewController.navigationItem.leftBarButtonItem=rightButton;
    }
    
}

-(void)popVC
{
    [self popViewControllerAnimated:YES];
}



@end
