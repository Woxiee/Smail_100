//
//  MemberCenterHeaderView.m
//  ShiShi
//
//  Created by lx on 16/3/15.
//  Copyright © 2016年 fec. All rights reserved.
//

#import "MemberCenterHeaderView.h"

@implementation MemberCenterHeaderView
{
    __weak IBOutlet UIImageView *rightIconView;

    __weak IBOutlet UIImageView *infoImageView;
    
    
    __weak IBOutlet NSLayoutConstraint *nameTopConstain;
    
    __weak IBOutlet UIButton *leveBtn;
    __weak IBOutlet UIButton *myCodeBtn;

}

+ (instancetype)membershipHeadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MemberCenterHeaderView" owner:self options:nil] firstObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.headImage.layer.cornerRadius  = 40;
    self.headImage.clipsToBounds = YES;
    _memberCenterBg.backgroundColor = KMAINCOLOR;
    [myCodeBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:5];
}

- (void)refreshInfo
{
    if ([KX_UserInfo sharedKX_UserInfo].loginStatus) {
        nameTopConstain.constant  = -17;
 ///"1",  0普通,1总代,2代理商,3合伙人  普通用户点击代理平台不能进入
        _nickNeme.text = [NSString stringWithFormat:@" %@(昵称) ",[KX_UserInfo sharedKX_UserInfo].nickname];
        _phoneLabel.text = [KX_UserInfo sharedKX_UserInfo].mobile;
        _nickNeme.hidden = NO;
        _compangLB.hidden = NO;
        _phoneLabel.hidden = NO;
        rightIconView.hidden = NO;
        infoImageView.hidden = NO;
        
        myCodeBtn.hidden = NO;
        leveBtn.hidden = NO;
        
        
        if ([[KX_UserInfo sharedKX_UserInfo].agent_level intValue] >0 ) {
            leveBtn.hidden = YES;
           
            NSArray *leveList = @[@"",@"总代",@"代理商",@"合伙人"];
           
            _compangLB.text  = leveList[[[KX_UserInfo sharedKX_UserInfo].agent_level intValue]];
        }
        self.nickNeme.backgroundColor = [UIColor whiteColor];
        self.nickNeme.textColor = KMAINCOLOR;
        [self.nickNeme layerForViewWith:10 AndLineWidth:0];
        if (KX_NULLString([KX_UserInfo sharedKX_UserInfo].avatar_url)) {
            _headImage.image = [ UIImage imageNamed:@"6@3x.png"];
        }else{
            [_headImage sd_setImageWithURL:[NSURL URLWithString:[KX_UserInfo sharedKX_UserInfo].avatar_url] placeholderImage:[UIImage imageNamed:@"6@3x.png"]];
        }
        
    }else{
        nameTopConstain.constant  = 10;
        _nickNeme.text = @"请登录";
        _compangLB.hidden = YES;
        _phoneLabel.hidden = YES;
        _nickNeme.hidden = NO;
        rightIconView.hidden = YES;
        infoImageView.hidden = YES;
        leveBtn.hidden = YES;
        myCodeBtn.hidden = YES;
        
      _headImage.image = [ UIImage imageNamed:@"6@3x.png"];

    }
}

- (IBAction)changeInfor:(UIButton *)sender {
    if (self.ChangeHeadImage) {
        self.ChangeHeadImage();
    }
}

/// 二维码
- (IBAction)didClickCordAction:(id)sender {
    
    if (_didClickMyCodeBlock) {
        _didClickMyCodeBlock();
    }
}



/// 代理商
- (IBAction)didCikckHHR:(id)sender {
    
    if (self.didClickHHRBlock) {
        self.didClickHHRBlock();
    }

    
}



@end
