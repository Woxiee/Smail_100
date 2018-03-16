//
//  KYViewTextCell.m
//  KYBaseCell
//
//  Created by mac_KY on 17/4/21.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import "KYViewTextCell.h"
 

@implementation KYViewTextCell
{
    UILabel *_titleLb;
    UILabel *_subTitleLb;
    NSString *_title;
    NSString *_subTitle;
}

-(id)initWithFrame:(CGRect )frame title:(NSString *)title subTitle:(NSString *)subTitle{
    if (self = [super initWithFrame:frame]) {
        _title = title;
        _subTitle = subTitle;
        [self loadSubView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)loadSubView
{
    CGFloat titleW = [self widthByString:_title];
    CGFloat subW = [self widthByString:_subTitle];
   
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, titleW, self.height)];
    titleLb.font = [UIFont systemFontOfSize:14];
    titleLb.textColor = [UIColor blackColor];
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.text = _title;
    _titleLb = titleLb;
    [self addSubview:titleLb];
    
    UILabel *subTitleLb = [[UILabel alloc]initWithFrame:CGRectMake(titleLb.right+5, 0, subW, self.height)];
    subTitleLb.font = [UIFont systemFontOfSize:14];
    subTitleLb.textColor = [UIColor blackColor];
    subTitleLb.textAlignment = NSTextAlignmentLeft;
    subTitleLb.text = _subTitle;
    _subTitleLb = subTitleLb;
    [self addSubview:subTitleLb];
    
}

-(CGFloat )widthByString:(NSString *)string{
   CGSize size = [string boundingRectWithSize:CGSizeMake(300, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size;
    return size.width;
}

#pragma mark - SET


-(void)setSubColor:(UIColor *)subColor
{
    _subColor = subColor;
    _subTitleLb.textColor = subColor;
}

-(void)setFont:(UIFont *)font
{
    _titleLb.font = font;
    _subTitleLb.font = font;
}
-(void)setTitle:(NSString *)title
{
    _titleLb.text = title;
}
-(void)setSubTitle:(NSString *)subTitle
{
    _subTitleLb.text = subTitle;
}


@end
