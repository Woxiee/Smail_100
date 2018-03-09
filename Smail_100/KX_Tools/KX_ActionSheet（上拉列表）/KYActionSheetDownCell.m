//
//  KYActionSheetDownCell.m
//  CRM
//
//  Created by Faker on 17/1/7.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "KYActionSheetDownCell.h"

@implementation KYActionSheetDownCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
    }
    return self;
}


- (void)setup
{
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;

    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(self.contentView.height);
    
    UIView *lineView  = [[UIView alloc] init];
    lineView.backgroundColor = LINECOLOR;
    lineView.contentMode   = UIViewContentModeBottom;
    lineView.clipsToBounds = YES;
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    
    self.lineView.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(0.5f);
    
     UIImageView *cheakMarkView = [UIImageView new];
    cheakMarkView.image = [UIImage imageNamed:@"24@3x.png"];
    [self.contentView addSubview:cheakMarkView];
    cheakMarkView.hidden = YES;
    _cheakMarkView = cheakMarkView;
    
    _cheakMarkView.sd_layout
    .rightSpaceToView(self.contentView, 10+5)
    .widthIs(14)
    .heightIs(12)
    .centerYEqualToView(self.contentView);

    
}

@end
