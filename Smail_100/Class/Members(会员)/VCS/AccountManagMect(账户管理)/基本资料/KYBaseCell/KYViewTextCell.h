//
//  KYViewTextCell.h
//  KYBaseCell
//
//  Created by mac_KY on 17/4/21.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYViewTextCell : UIView

@property(nonatomic,strong)UIFont *font;
@property(nonatomic,strong)UIColor *subColor;

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *subTitle;
-(id)initWithFrame:(CGRect )frame title:(NSString *)title subTitle:(NSString *)subTitle;

@end
