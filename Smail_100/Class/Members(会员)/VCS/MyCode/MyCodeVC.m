//
//  MyCodeVC.m
//  Smail_100
//
//  Created by ap on 2018/4/20.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "MyCodeVC.h"

@interface MyCodeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLB;

@property (weak, nonatomic) IBOutlet UILabel *weixinName;
@property (weak, nonatomic) IBOutlet UIImageView *myCodeImageView;
@property (weak, nonatomic) IBOutlet UIButton *activeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myCodeHeighContains;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *icowWight;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *detailLB;

@end

@implementation MyCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的二维码";
    [self setup];
}


#pragma mark - request
- (void)requestListNetWork
{
    [BaseHttpRequest postWithUrl:@"/goods/getPhoneGoods" andParameters:nil andRequesultBlock:^(id result, NSError *error) {
    }];
    
}

#pragma mark - private
- (void)setup
{
    _detailLB.text = @"我的二维码";
    _lineView.backgroundColor = LINECOLOR;
    if ([[KX_UserInfo sharedKX_UserInfo].shop_level intValue] >0) {
        [_userImageView sd_setImageWithURL:[NSURL URLWithString:[KX_UserInfo sharedKX_UserInfo].avatar_url] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
        
        _nameLB.text =  [NSString stringWithFormat:@"昵称:%@",[KX_UserInfo sharedKX_UserInfo].nickname];
        _weixinName.text = [NSString stringWithFormat:@"微信:%@",[KX_UserInfo sharedKX_UserInfo].wxname];
        
        [_myCodeImageView sd_setImageWithURL:[NSURL URLWithString:[KX_UserInfo sharedKX_UserInfo].qrcode] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
        _activeBtn.hidden = YES;
    }else{
        
        _icowWight.constant = -5;
        [_activeBtn layerWithRadius:6 lineWidth:1 color:KMAINCOLOR];
        [_activeBtn setTitleColor:KMAINCOLOR forState:UIControlStateNormal];
        _userImageView.hidden = YES;
        _myCodeHeighContains.constant = 50;
        _myCodeImageView.hidden = YES;

//        _myCodeImageView.image = [UIImage imageNamed:@"wodetuiguang1@3x.png"];
        _nameLB.text = @"我的分享链接";
        _weixinName.text = @"无法分享，快去商城购买商品吧";
        _detailLB.text = @"  我的二维码";

    }
   

}

- (void)setConfiguration
{
    
}


- (IBAction)didClickActioveAction:(id)sender {

    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - publice


#pragma mark - set & get



#pragma mark - delegate


@end
