//
//  CommentsHeadView.m
//  Smail_100
//
//  Created by ap on 2018/4/8.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "CommentsHeadView.h"

@implementation CommentsHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _lineView1.backgroundColor = BACKGROUND_COLOR;
    _titleLB.textColor = DETAILTEXTCOLOR;
    [_moreBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    
}
@end
