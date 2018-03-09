//
//  FK_ActionSheetCell.m
//  KX_SheetView
//
//  Created by Faker on 16/12/1.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import "FK_ActionSheetCell.h"
#import "Masonry.h"
@interface FK_ActionSheetCell ()
@property (nonatomic, weak) UIView *highlightedView;
@end

@implementation FK_ActionSheetCell
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
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    UIView *lineView  = [[UIView alloc] init];
    lineView.backgroundColor = LINECOLOR;
    lineView.contentMode   = UIViewContentModeBottom;
    lineView.clipsToBounds = YES;
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@0.5f);
    }];

}
@end
