//
//  PopupViewCell.m
//  PopupView
//
//  Created by Zhao Fei on 2016/10/12.
//  Copyright © 2016年 ZhaoFei. All rights reserved.
//

#import "PopupViewCell.h"

static CGFloat padding = 35.f;
static CGFloat iconSize = 15;

@interface PopupViewCell()

@property (nonatomic, strong) UIImageView *separatorLineView;

@end

@implementation PopupViewCell

+ (instancetype)popupViewCellWithTableView:(UITableView *)tableView {
    
    static NSString *cellID = @"PopupViewCell";
    
    PopupViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[PopupViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconView];
        
        self.titleLable = [[UILabel alloc] init];
        self.titleLable.textColor = [UIColor whiteColor];
        self.titleLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleLable];
        
        //添加分割线
        self.separatorLineView = [[UIImageView alloc] init];
        self.separatorLineView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.separatorLineView];
        self.separatorLineView.hidden = YES;
        
        [self.contentView addSubview:self.separatorLineView];
    
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    float setOffw = self.contentView.frame.size.width;
    float setOffh = self.contentView.frame.size.height;

    
    self.iconView.frame = CGRectMake(padding, (self.contentView.frame.size.height -iconSize )/2+2, iconSize, iconSize);
    
    self.titleLable.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) +5, 2,setOffw - padding, 40);
    self.separatorLineView.frame = CGRectMake(0, setOffh , setOffw , 1 / ([UIScreen mainScreen].scale));

}

-(void)setHaveSeparatorLine:(BOOL)haveSeparatorLine{
    _haveSeparatorLine = haveSeparatorLine;
    self.separatorLineView.hidden = haveSeparatorLine;
}
@end
