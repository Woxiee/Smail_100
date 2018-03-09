//
//  StoreMangerVHeadView.m
//  Smile_100
//
//  Created by ap on 2018/2/27.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "StoreMangerVHeadView.h"

@implementation StoreMangerVHeadView
{
  
    
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

}


- (IBAction)didClickAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 100) {
        
    }else{
        
    }
    
    if (_didClickStoreMangerBlock) {
        _didClickStoreMangerBlock(btn.tag - 100);
    }
    
}


@end
