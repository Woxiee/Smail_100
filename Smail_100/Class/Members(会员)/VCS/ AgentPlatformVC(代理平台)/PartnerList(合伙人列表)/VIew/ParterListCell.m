//
//  ParterListCell.m
//  Smail_100
//
//  Created by 家朋 on 2018/5/16.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "ParterListCell.h"

@implementation ParterListCell
{
    UILabel *ckLb ;
    UIImageView *_headImgV;
    UILabel *_nickNameLabel;
    UILabel *_creatIDLabel;
    UILabel *_commentIDLabel;
    UILabel *_reginTimeLabel;
    UILabel *_reLiveLabel;
    UILabel *_reLiveStateLabel;
}

-(void)setup {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    //_headImgV
    _headImgV = [[UIImageView alloc]initWithFrame:CGRectMake(25, 12, 49, 49)];
    _headImgV.KYConnerRediu(_headImgV.width/2);
    [self.contentView addSubview:_headImgV];
    

    
    //Line
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = JColor(lineColor);
    [self.contentView addSubview:lineView];
    lineView.sd_layout
    .leftSpaceToView(_headImgV, 25)
    .topSpaceToView(self.contentView, 5)
    .bottomSpaceToView(self.contentView, 5)
    .widthIs(0.5);
    
    
    //_nickNameLabel
    _nickNameLabel = [[UILabel alloc]initWithTitle:@"" font:Font13 color:COLOR(34, 34, 34, 1)];
    _nickNameLabel.textAlignment = NSTextAlignmentCenter;
    _nickNameLabel.textColor = DETAILTEXTCOLOR;
    [self.contentView addSubview:_nickNameLabel];
    _nickNameLabel.sd_layout
    .topSpaceToView(_headImgV, 5)
    .leftSpaceToView(self.contentView, 5)
    .rightSpaceToView(lineView, 5)
    .heightIs(15);
    
    //5*14 = 75
    CGFloat lbH = 15.f;
    //创客
    ckLb = [[UILabel alloc]initWithTitle:@"合伙人ID:" font:Font14 color:TITLETEXTLOWCOLOR];
    [self.contentView addSubview:ckLb];
    ckLb.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(lineView, 8)
    .heightIs(lbH);
    [ckLb setSingleLineAutoResizeWithMaxWidth:120];
    
    //_creatIDLabel
    _creatIDLabel =  [[UILabel alloc]initWithTitle:@"" font:Font14 color:TITLETEXTLOWCOLOR];
    [self.contentView addSubview:_creatIDLabel];
    _creatIDLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(ckLb, 5)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(lbH);
 
    
    //推荐人
    UILabel *tjrLb = [[UILabel alloc]initWithTitle:@"姓名:" font:Font14 color:TITLETEXTLOWCOLOR];
    [self.contentView addSubview:tjrLb];
    tjrLb.sd_layout
    .topSpaceToView(_creatIDLabel, 5)
    .leftSpaceToView(lineView, 8)
    .heightIs(lbH);
    [tjrLb setSingleLineAutoResizeWithMaxWidth:120];
    
    //_commentIDLabel
    
    _commentIDLabel =  [[UILabel alloc]initWithTitle:@"" font:Font14 color:TITLETEXTLOWCOLOR];
    [self.contentView addSubview:_commentIDLabel];
    _commentIDLabel.sd_layout
    .topEqualToView(tjrLb)
    .leftSpaceToView(tjrLb, 5)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(lbH);
    
    //注册时间
    UILabel *rgLb = [[UILabel alloc]initWithTitle:@"创建时间:" font:Font14 color:TITLETEXTLOWCOLOR];
    [self.contentView addSubview:rgLb];
    rgLb.sd_layout
    .topSpaceToView(tjrLb, 5)
    .leftSpaceToView(lineView, 8)
    .heightIs(lbH);
    [rgLb setSingleLineAutoResizeWithMaxWidth:120];
    
    //_reginTimeLabel
    _reginTimeLabel =  [[UILabel alloc]initWithTitle:@"" font:Font14 color:TITLETEXTLOWCOLOR];
    [self.contentView addSubview:_reginTimeLabel];
    _reginTimeLabel.sd_layout
    .topEqualToView(rgLb)
    .leftSpaceToView(rgLb, 5)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(lbH);
    

    
    //账户状态
    UILabel *zhsLb = [[UILabel alloc]initWithTitle:@"账户状态:" font:Font14 color:TITLETEXTLOWCOLOR];
    [self.contentView addSubview:zhsLb];
    zhsLb.sd_layout
    .topSpaceToView(rgLb, 5)
    .leftSpaceToView(lineView, 8)
    .heightIs(lbH);
    [zhsLb setSingleLineAutoResizeWithMaxWidth:120];
    //_reLiveStateLabel
    _reLiveStateLabel =  [[UILabel alloc]initWithTitle:@"" font:Font14 color:TITLETEXTLOWCOLOR];
    [self.contentView addSubview:_reLiveStateLabel];
    _reLiveStateLabel.sd_layout
    .topEqualToView(zhsLb)
    .leftSpaceToView(zhsLb, 5)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(lbH);

}

-(void)setModel:(MyteamListModel *)model {
    _model = model;
    //test
    [ _headImgV sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:[UIImage imageNamed:@"6@3x.png"]];

   _nickNameLabel.text = [NSString stringWithFormat:@"%@",_model.nickname];
    _creatIDLabel.text = _model.mobile;
    _commentIDLabel.text = _model.realname;
   _reginTimeLabel.text = _model.ctime;
    
    
    
////    "maker_level": 1 激活(代理列表) "status":Enabled 正常,Disabled:冻结 (合伙人列表)
//    if ([KX_UserInfo sharedKX_UserInfo].agent_level.integerValue == 2) {
//        if (_model.maker_level.integerValue == 1) {
//            _reLiveStateLabel.text = @"激活";
//            _reLiveStateLabel.textColor = KMAINCOLOR;
//        }
//        ckLb.text = @"代理人账号: ";
//    }else{
        ckLb.text = @"合伙人账号: ";

        if ([_model.status isEqualToString:@"Enabled"]) {
            _reLiveStateLabel.text = @"正常";

        }
        else{
            _reLiveStateLabel.text = @"冻结";

            _reLiveStateLabel.textColor = KMAINCOLOR;

        }
//
//    }
   
    
    
}
@end
