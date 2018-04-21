//
//  GoodsManageView.m
//  Smile_100
//
//  Created by ap on 2018/2/28.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "GoodsManageView.h"

@implementation GoodsManageView
{
    
    __weak IBOutlet UIView *lineView;
    
    __weak IBOutlet UIButton *upBtn;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    lineView.backgroundColor = LINECOLOR;
}



- (IBAction)didClickChangeBtn:(UIButton *)sender {
    /// 100上架 101 编辑  102 删除
    if (self.didClickChangBtnBlock) {
        _didClickChangBtnBlock(sender.tag - 100);
    }
    
}



- (void)setModel:(MeChantOrderModel *)model
{
    _model = model;
    if ([_model.status isEqualToString:@"Enabled"]) {
        [upBtn setTitle:@" 下架" forState:UIControlStateNormal];
    }else{
        [upBtn setTitle:@" 上架" forState:UIControlStateNormal];
    }
}

@end
