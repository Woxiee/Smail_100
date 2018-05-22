//
//  SearchHeadView.m
//  Smail_100
//
//  Created by ap on 2018/5/18.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SearchHeadView.h"

@implementation SearchHeadView

- (instancetype)initWithFrame:(CGRect)frame withType:(NSString *)type;
{
  
    if (self = [super initWithFrame:frame]){
        _type = type;
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = BACKGROUNDNOMAL_COLOR;
    if (_type.integerValue == 1) {
        MySelectTeamView *selectTeamView = [[MySelectTeamView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,80) titleArray:@[@"0",@"0",@"0"] andContenArr:@[@"总推荐人数",@"总激活创客",@"团队总业绩(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                                "]];
        selectTeamView.backgroundColor = [UIColor whiteColor];
        [self addSubview:selectTeamView];
        self.selectTeamView = selectTeamView;

    }
    
    
    else  if (_type.integerValue == 2) {
        MySelectTeamView *selectTeamView = [[MySelectTeamView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,80) titleArray:@[@"0",@"0"] andContenArr:@[@"合伙人人数",@"合伙人总业绩(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                                "]];
        selectTeamView.backgroundColor = [UIColor whiteColor];
        [self addSubview:selectTeamView];
        self.selectTeamView = selectTeamView;
        
    }
    
    else  if (_type.integerValue == 3) {
        MySelectTeamView *selectTeamView = [[MySelectTeamView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,80) titleArray:@[@"0",@"0"] andContenArr:@[@"合伙人数",@"总合伙业绩(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                                "]];
        selectTeamView.backgroundColor = [UIColor whiteColor];
        [self addSubview:selectTeamView];
        self.selectTeamView = selectTeamView;
        
    }
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 83, SCREEN_WIDTH, self.mj_h - 83)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];


    _seachTF = [[UITextField alloc] initWithFrame:CGRectMake(15,15, SCREEN_WIDTH - 30, 40)];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 40)];
    _seachTF.leftView = paddingView;
    _seachTF.leftViewMode = UITextFieldViewModeAlways;
    _seachTF.placeholder = @"账号";
    _seachTF.font = KY_FONT(14);
//    [_seachTF setBorderStyle:UITextBorderStyleLine];
//    _seachTF.layer.borderColor= DETAILTEXTCOLOR.CGColor;
//    _seachTF.layer.borderWidth= 1.0f;
    [_seachTF layerWithRadius:8 lineWidth:1 color:DETAILTEXTCOLOR];
    _seachTF.keyboardType =  UIKeyboardTypePhonePad;
    [_seachTF setValue:DETAILTEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];


//    [_seachTF layerForViewWith:0 AndLineWidth:1];
    [bottomView addSubview:_seachTF];
    
    _seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _seachBtn.frame = CGRectMake(15, CGRectGetMaxY(_seachTF.frame) +15,  SCREEN_WIDTH - 30, 35);
    [_seachBtn setTitle:@"查询" forState:UIControlStateNormal];
    [_seachBtn layerForViewWith:10 AndLineWidth:0];
    _seachBtn.backgroundColor = KMAINCOLOR;
    _seachBtn.titleLabel.font = KY_FONT(16);
    [_seachBtn addTarget:self action:@selector(didClickSeachAction) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:_seachBtn];
    
    
}

- (void)didClickSeachAction
{
    [self endEditing:YES];
    if (_didClickSearchBlock) {
        _didClickSearchBlock(_seachTF.text);
    }
}

@end
