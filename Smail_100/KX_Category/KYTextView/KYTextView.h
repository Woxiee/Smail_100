//
//  KYTextView.h
//  KYTextViewDemo1
//
//  Created by mac_KY on 17/1/9.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "UIViewExt.h"//依赖关系


@interface KYTextView : UITextView

/* 提示文字*/
@property(nonatomic,copy) NSString *KYPlaceholder;
/* 提示文字文字颜色*/
@property(nonatomic,strong) UIColor *KYPlaceholderColor;
/* 最大文字个数*/
@property(nonatomic,assign)NSUInteger maxTextCount;//默认200个







@end
