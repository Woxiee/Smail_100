//
//  changeInfoVC.h
//  ShiShi
//
//  Created by mac_KY on 17/3/3.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface changeInfoVC : KX_BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@property (weak, nonatomic) IBOutlet UITextField *contentTF;

@property (weak, nonatomic) IBOutlet UILabel *warnLb;

@property(nonatomic,copy)void (^clickTrue)(NSString *content);

@property(nonatomic,strong)NSString *inputText;

@property(nonatomic,strong)NSString *aTitle;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property(nonatomic,strong)NSString *warnStr;
@end
