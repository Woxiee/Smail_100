//
//  KYViewCell.m
//  KYBaseCell
//
//  Created by mac_KY on 17/3/7.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import "KYViewCell.h"
 

#define marginLeft 12.0f


@interface KYViewCell ()
@property(nonatomic,copy)void (^clickCell)();
@property(nonatomic,strong)KYBaseCellItem *item;

@end

@implementation KYViewCell

/*使用该方法*/
-(id)initWithFrame:(CGRect)frame Item:(KYBaseCellItem *)item clickBack:(void(^)())handleBack
{
    
    if (self = [super initWithFrame:frame]) {
        _item = item;
        self.backgroundColor = [UIColor whiteColor];
        [self loadSubview];
        _clickCell = handleBack;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCellAction)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)loadSubview
{
    ////标题
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(marginLeft, 0, 200, self.height)];
    [self addSubview:titleLb];
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.font = [UIFont systemFontOfSize:14];
    titleLb.textColor = [UIColor blackColor];
    titleLb.text = _item.title;
    _titleLabel = titleLb;
    
    ///右边图标
    if (_item.rightIcom && _item.rightIcom.length>0) {
        CGFloat imageW = 8.0,imageH = 15.0;
        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_item.rightIcom]];
        imageV.frame = CGRectMake(self.width - marginLeft -imageW, (self.height - imageH)/2, imageW, imageH);
        [self addSubview:imageV];
        
    }
    
    ///子标题 会靠右边的哦
    UILabel*subLb = [[UILabel alloc]initWithFrame:CGRectMake(self.width -( _item.rightIcom?marginLeft+215:marginLeft+200), 0, 200, self.height)];
    subLb.textAlignment = NSTextAlignmentRight;
    subLb.font = [UIFont systemFontOfSize:14];
    subLb.textColor = [UIColor blackColor];
    subLb.text = _item.subTitle;
    [self addSubview:subLb];
    _subTitleLabel = subLb;
    
    ///line
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.height -1, self.width, 1)];
    line.backgroundColor = LINECOLOR;
    _bottonLine = line;
    [self addSubview:line];
    
}


#pragma mark - click

-(void)clickCellAction{
    
    if (_clickCell) {
        _clickCell();
    }
}


@end
