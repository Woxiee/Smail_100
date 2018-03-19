//
//  OfflineDetailCell.m
//  Smail_100
//
//  Created by ap on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "OfflineDetailCell.h"

@implementation OfflineDetailCell
{
    UILabel *_shopName;
    UIImageView *_starImageView;
    UILabel *_commNumberLB;
    UIView *_lineView;
    UIButton *_addressBtn;
    UILabel *_distanceLB;
    UIButton *_findBtn;
    UIView *_lineView1;
    UIButton *_tellBtn;
    UIView *_lineView2;
    UIButton *_businessBtn;
    UIView *_lineView3;
    UIButton *_lookBnt;
    UIView *_lineView4;
    UIButton *_mainBtn;
    UILabel *_mianLB;


}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
    
}


- (void)setup
{
    _shopName = [UILabel new];
    _shopName.font = Font15;
    _shopName.textColor = TITLETEXTLOWCOLOR;
    
    _starImageView = [UIImageView new];
    
    _commNumberLB = [UILabel new];
    _commNumberLB.font = Font13;
    _commNumberLB.textColor = DETAILTEXTCOLOR;
    
    _lineView = [UIView new];
    _lineView.backgroundColor = LINECOLOR;
    
    _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addressBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    _addressBtn.titleLabel.font = Font14;
    
    _distanceLB = [UILabel new];
    _distanceLB.font = Font13;
    _distanceLB.textColor = TITLETEXTLOWCOLOR;
    
    
//    _distanceLB = [UILabel new];
//    _distanceLB.font = Font13;
//    _distanceLB.textColor = TITLETEXTLOWCOLOR;
    
    _findBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_findBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    _findBtn.titleLabel.font = Font14;
    
    _lineView1 = [UIView new];
    _lineView1.backgroundColor = LINECOLOR;
    
   _tellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tellBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    _tellBtn.titleLabel.font = Font14;
    
    _lineView2 = [UIView new];
    _lineView2.backgroundColor = LINECOLOR;
    
    _businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_businessBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    _businessBtn.titleLabel.font = Font14;
    
    _lineView3 = [UIView new];
    _lineView3.backgroundColor = LINECOLOR;
    
    _lookBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lookBnt setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    _lookBnt.titleLabel.font = Font14;
    
    _lineView4 = [UIView new];
    _lineView4.backgroundColor = LINECOLOR;
    
    _mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mainBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    _mainBtn.titleLabel.font = Font14;

    _mianLB= [UILabel new];
    _mianLB.font = Font13;
    _mianLB.textColor = TITLETEXTLOWCOLOR;
    
    [self.contentView sd_addSubviews:@[_shopName,_starImageView,_commNumberLB,_lineView,_addressBtn,_distanceLB,_findBtn,_lineView1,_tellBtn,_lineView2,_businessBtn,_lineView3,_lookBnt,_lineView4,_mainBtn,_lineView4,_mainBtn,_mianLB]];
    
    CGFloat pading = 10;
    UIView *contenview = self.contentView;
    
    _shopName.sd_layout
    .leftSpaceToView(contenview, pading)
    .topSpaceToView(contenview, 3)
    .widthIs(100)
    .heightIs(17);
    
    _starImageView.sd_layout
    .leftEqualToView(_shopName)
    .topSpaceToView(_shopName, 3)
    .widthIs(100)
    .heightIs(17);
    
    _commNumberLB.sd_layout
    .leftSpaceToView(_starImageView, 0)
    .topEqualToView(_starImageView)
    .heightIs(17)
    .widthIs(100);
    
    _lineView.sd_layout
    .topSpaceToView(_commNumberLB, pading)
    .leftSpaceToView(contenview, 5)
    .rightSpaceToView(contenview, 5)
    .heightIs(0.5);
    
    _findBtn.sd_layout
    .rightSpaceToView(contenview, pading)
    .topSpaceToView(_lineView, pading/2)
    .heightIs(40)
    .widthIs(50);
    
    _distanceLB.sd_layout
    .rightSpaceToView(_findBtn, pading)
    .topSpaceToView(_lineView, pading/2)
    .heightIs(40)
    .widthIs(50);

    _addressBtn.sd_layout
    .leftSpaceToView(contenview, pading)
    .topSpaceToView(_lineView, pading/2)
    .heightIs(40)
    .rightSpaceToView(_distanceLB, 2*pading);
    
    
    _lineView1.sd_layout
    .topSpaceToView(_commNumberLB, pading)
    .leftSpaceToView(contenview, 5)
    .rightSpaceToView(contenview, 5)
    .heightIs(0.5);
    

}


@end
