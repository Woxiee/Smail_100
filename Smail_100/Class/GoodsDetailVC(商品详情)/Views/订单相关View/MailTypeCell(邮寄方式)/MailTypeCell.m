//
//  MailTypeCell.m
//  Smile_100
//
//  Created by ap on 2018/3/7.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MailTypeCell.h"

@implementation MailTypeCell
{
    UIButton *_shouYeBtn;
    UIButton *_meBtn;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
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
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView3.backgroundColor = LINECOLOR;
    [self.contentView addSubview:lineView3];
    
    UILabel *titleLB  = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 44) title:@"配送方式" textColor:[UIColor blackColor] font:Font15];
    titleLB.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLB];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLB.frame), SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = LINECOLOR;
    [self.contentView addSubview:lineView];
    
    UIButton *shouYeBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    shouYeBtn.frame = CGRectMake(10, CGRectGetMaxY(lineView.frame),SCREEN_WIDTH/4 , 40);
    [shouYeBtn addTarget:self action:@selector(didClickEmailAction:) forControlEvents:UIControlEventTouchUpInside];
    shouYeBtn.tag = 100;
    [shouYeBtn setImage:[UIImage imageNamed:@"zhuce2@3x.png"] forState:UIControlStateNormal];
    [shouYeBtn setImage:[UIImage imageNamed:@"23@3x.png"] forState:UIControlStateSelected];
    [shouYeBtn setTitle:@"快递邮寄" forState:UIControlStateNormal];
    [shouYeBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];
    [shouYeBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    shouYeBtn.titleLabel.font =  Font15;
    [self addSubview:shouYeBtn];
    _shouYeBtn = shouYeBtn;
    
    UIButton *meBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    meBtn.frame = CGRectMake(CGRectGetMaxX(shouYeBtn.frame)  +40, CGRectGetMaxY(lineView.frame), SCREEN_WIDTH/4, 45);
    [meBtn addTarget:self action:@selector(didClickEmailAction:) forControlEvents:UIControlEventTouchUpInside];
    meBtn.tag = 101;
    [meBtn setImage:[UIImage imageNamed:@"zhuce2@3x.png"] forState:UIControlStateNormal];
    [meBtn setImage:[UIImage imageNamed:@"23@3x.png"] forState:UIControlStateSelected];
    [meBtn setTitle:@"门店自提" forState:UIControlStateNormal];
    [meBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    meBtn.titleLabel.font =  Font15;
    [meBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];
    [self addSubview:meBtn];
    _meBtn = meBtn;
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(meBtn.frame), SCREEN_WIDTH, 0.5)];
    lineView1.backgroundColor = LINECOLOR;
    [self.contentView addSubview:lineView1];
    
}


- (void)didClickEmailAction:(UIButton*)sender
{
    if (sender.tag == 100) {
        _shouYeBtn.selected = YES;
        _meBtn.selected = NO;
    }
    else{
        _shouYeBtn.selected = NO;
        _meBtn.selected = YES;
    }
    
    if (_didChangeEmailTypeBlock) {
        _didChangeEmailTypeBlock(sender.tag - 100);
    }
}

@end
