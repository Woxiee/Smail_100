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
    connetBtn.backgroundColor = KMAINCOLOR;
    [connetBtn layerWithRadius:10 lineWidth:0.5 color:KMAINCOLOR];
    
    clickDeviceView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tagGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickClickAction)];
    
    [clickDeviceView addGestureRecognizer:tagGesture];
//    clickDeviceContenHeight.constant = 0;
}

- (void)setResultDic:(NSDictionary *)resultDic
{
    _resultDic = resultDic;
    acoutTF.text =  _resultDic[@"devid"];
    if ([_resultDic[@"status"] isEqualToString:@"Enabled"]) {
        [connetBtn setTitle:@"取消关联" forState:UIControlStateNormal];
    }else{
        [connetBtn setTitle:@"关联" forState:UIControlStateNormal];

    }
}


- (void)didClickClickAction
{
    if ([_resultDic[@"status"] isEqualToString:@"Enabled"]) {
        if (_didClickLookInfoBlcok ) {
            _didClickLookInfoBlcok();
        }
    }else{
        [self.window makeToast:@"未绑定设备"];
    }
   }


- (IBAction)didClickConnetAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (_didClickConnectionBlcok ) {
        _didClickConnectionBlcok(btn.titleLabel.text);
    }
   
}

@end
