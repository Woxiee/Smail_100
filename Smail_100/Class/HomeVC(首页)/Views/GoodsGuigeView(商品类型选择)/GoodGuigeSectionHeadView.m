//
//  GoodGuigeSectionHeadView.m
//  SXProject
//
//  Created by Faker on 17/4/7.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "GoodGuigeSectionHeadView.h"

@implementation GoodGuigeSectionHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    _titleLabel.textColor = TITLETEXTLOWCOLOR;
    _titleLabel.font = Font15;
}


- (IBAction)didClickHeadBtn:(id)sender {
    if (_didClickHeadViewBtnBlock) {
        _didClickHeadViewBtnBlock(_indexPath.section);
    }
    
}
@end
