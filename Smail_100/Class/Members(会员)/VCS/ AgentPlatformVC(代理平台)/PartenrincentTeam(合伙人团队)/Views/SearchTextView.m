//
//  SearchTextView.m
//  Smail_100
//
//  Created by ap on 2018/5/18.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SearchTextView.h"


@implementation SearchTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}



- (void)setup
{
    _seachTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 40)];
    _seachTF.placeholder = @"合伙人账号";
    [_seachTF layerForViewWith:10 AndLineWidth:1];
    [self addSubview:_seachTF];
    
    _seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _seachBtn.frame = CGRectMake(15, CGRectGetMaxY(_seachTF.frame) +18,  SCREEN_WIDTH - 30, 35);
    [_seachBtn setTitle:@"快递查询" forState:UIControlStateNormal];
    [_seachBtn layerForViewWith:10 AndLineWidth:0];
    _seachBtn.backgroundColor = KMAINCOLOR;
    _seachBtn.titleLabel.font = KY_FONT(16);
    [_seachBtn addTarget:self action:@selector(didClickSeachAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_seachBtn];
   
    
}

- (void)didClickSeachAction
{
    [self endEditing:YES];
    if (_didClickSearchBlock) {
        _didClickSearchBlock(_seachTF.text);
    }
}
@end
