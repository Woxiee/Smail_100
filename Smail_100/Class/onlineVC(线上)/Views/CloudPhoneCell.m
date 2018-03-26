//
//  CloudPhoneCell.m
//  Smail_100
//
//  Created by ap on 2018/3/26.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "CloudPhoneCell.h"

@implementation CloudPhoneCell
{
    
    __weak IBOutlet UITextField *acoutTF;
    
    __weak IBOutlet UIButton *connetBtn;
    __weak IBOutlet UIView *clickDeviceView;
    
    __weak IBOutlet NSLayoutConstraint *clickDeviceContenHeight;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}


- (void)setup
{
    [connetBtn layerWithRadius:12 lineWidth:0.5 color:KMAINCOLOR];
    clickDeviceView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tagGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickClickAction)];
    
    [clickDeviceView addGestureRecognizer:tagGesture];
    clickDeviceContenHeight.constant = 0;
}



- (void)didClickClickAction
{
    if (_didClickLookInfoBlcok ) {
        _didClickLookInfoBlcok();
    }
}

@end
