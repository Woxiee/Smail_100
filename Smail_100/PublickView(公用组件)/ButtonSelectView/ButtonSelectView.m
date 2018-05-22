//
//  ButtonSelectView.m
//  Smail_100
//
//  Created by 家朋 on 2018/5/17.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "ButtonSelectView.h"

@implementation ButtonSelectView
{
    NSArray *_titles;
    UIButton *_selectButton;
}
- (instancetype)initWithTitles:(NSArray *)titles {
    if (self = [super init]) {
        _titles = titles;
        [self setup];
    }
    return self;
}

- (void)setup {
    
    NSUInteger count = _titles.count;
    if (count == 0 ) {
        return;
    }
    
    UIButton *lastBtn = [UIButton buttonWithType:0];
    for (int i = 0 ;i<count;i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = Font12;
        [btn setImage:[UIImage imageNamed:@"dailipingtai6"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"dailipingtai7"] forState:UIControlStateSelected];
        [self addSubview:btn];
       
        btn.sd_layout
        .leftSpaceToView(lastBtn, 0)
        .topEqualToView(self)
        .bottomEqualToView(self)
        .widthIs(120);
       // .widthRatioToView(self, 1.0/count);
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        lastBtn = btn;
        if (i==0) {
            btn.selected = YES;
            _selectButton = btn;
        }
    }
    
}

- (void)clickButton:(UIButton *)sender {
    
    sender.selected = YES;
    _selectButton.selected = NO;
    _selectButton = sender;
    
}

-(NSString *)selectTitle {
    if (_selectButton == nil) {
        return @"";
    }
    return [_selectButton titleForState:UIControlStateNormal];
}

@end
