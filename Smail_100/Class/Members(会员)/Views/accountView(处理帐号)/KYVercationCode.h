//
//  KYVercationCode.h
//  KCDateDemo1
//
//  Created by mac_KY on 17/2/21.
//  Copyright © 2017年 mac_kc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYVercationCode : UIView


-(instancetype)initWithFrame:(CGRect )frame hideClickBtn:(BOOL)hide;

-(void)timeRun:(void(^)(int count))timeBlock;


-(void)stopTime;

@property (nonatomic,strong)UILabel *headerLb;

@property (nonatomic,strong)NSString *btnTitle;

@property (nonatomic,strong)UITextField *inputTF;

@property (nonatomic,strong)UIButton *getCodeBtn;

@property (nonatomic,strong)UIButton *nextBtn;

@property(nonatomic,assign)BOOL controlNextBtn;


@property (nonatomic,copy) void(^correctBlock)(BOOL correct);

@property (nonatomic,copy) void(^clickNextBlock)();

//弹出框的属性






 


@end
