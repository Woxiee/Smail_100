//
//  SexView.m
//  ShiShi
//
//  Created by ac on 16/4/18.
//  Copyright © 2016年 fec. All rights reserved.
//

#import "SexView.h"

@implementation SexView
{
    
    __weak IBOutlet UIButton *girlBtn;
    __weak IBOutlet UIButton *boyBtn;
}

- (IBAction)boyChoose:(UIButton *)sender {
    
    boyBtn.selected = YES;
    girlBtn.selected = NO;
    
}

- (IBAction)girlChoose:(UIButton *)sender {
    
    boyBtn.selected = NO;
    girlBtn.selected = YES;
    
}


- (IBAction)sureChoose:(UIButton *)sender {
    
    if (self.chooseSex) {
        if (girlBtn.selected) {
            self.chooseSex(@"1");
        }
        if (boyBtn.selected) {
            self.chooseSex(@"2");
        }
    }
}


- (IBAction)canncelChoose:(UIButton *)sender {
    
    if (self.cannelChoose) {
        self.cannelChoose();
    }
}

@end
