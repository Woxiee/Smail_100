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
}

+ (instancetype)membershipHeadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MemberCenterHeaderView" owner:self options:nil] firstObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.headImage.layer.cornerRadius  = 45;
    self.headImage.clipsToBounds = YES;
    _memberCenterBg.backgroundColor = KMAINCOLOR;
  
}

- (void)refreshInfo
{
    if ([KX_UserInfo sharedKX_UserInfo].loginStatus) {
        _nickNeme.text = [KX_UserInfo sharedKX_UserInfo].nickname;
        _phoneLabel.text = [KX_UserInfo sharedKX_UserInfo].mobile;
        _nickNeme.hidden = NO;
        _compangLB.hidden = NO;
        _phoneLabel.hidden = NO;
        rightIconView.hidden = NO;
        infoImageView.hidden = NO;
        self.nickNeme.backgroundColor = [UIColor whiteColor];
        self.nickNeme.textColor = KMAINCOLOR;
        [self.nickNeme layerForViewWith:10 AndLineWidth:0];
        if (KX_NULLString([KX_UserInfo sharedKX_UserInfo].headimage)) {
            _headImage.image = [ UIImage imageNamed:@"6@3x.png"];
        }else{
            [_headImage sd_setImageWithURL:[NSURL URLWithString:[KX_UserInfo sharedKX_UserInfo].avatar_url] placeholderImage:[UIImage imageNamed:@"6@3x.png"]];
        }
        
    }else{
        _nickNeme.text = @"请登录";
        _compangLB.hidden = YES;
        _phoneLabel.hidden = YES;
        _nickNeme.hidden = NO;
        rightIconView.hidden = YES;
        infoImageView.hidden = YES;
      _headImage.image = [ UIImage imageNamed:@"6@3x.png"];

    }
}

- (IBAction)changeInfor:(UIButton *)sender {
    if (self.ChangeHeadImage) {
        self.ChangeHeadImage();
    }
}





@end
