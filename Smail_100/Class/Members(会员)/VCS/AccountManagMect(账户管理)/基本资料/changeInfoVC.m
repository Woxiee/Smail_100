//
//  changeInfoVC.m
//  ShiShi
//
//  Created by mac_KY on 17/3/3.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "changeInfoVC.h"

@interface changeInfoVC ()

@end

@implementation changeInfoVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadComment];
    [self loadSubView];
    
    
}

#pragma mark - 常数设置
-(void)loadComment
{
    [_contentTF layerForViewWith:3 AndLineWidth:1];
    _sureBtn.backgroundColor = KMAINCOLOR;
}


#pragma mark - 初始化子View
-(void)loadSubView
{
    self.title = _aTitle;
    _contentTF.text = _inputText;
    _warnLb.text = _warnStr;
    _warnLb.textColor = DETAILTEXTCOLOR;
    if ([_aTitle isEqualToString:@""]) {
      _contentTF.placeholder = @"请输入姓名";
    }else{
        _contentTF.placeholder = @"请输入姓名";
    }
    
}

#pragma mark - 点击事件

- (IBAction)clickTrue:(id)sender {
    
    if (_clickTrue) {
        _clickTrue(_contentTF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)clickBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private




@end
