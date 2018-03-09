//
//  KYEditorTextView.h
//  CRM
//
//  Created by Frank on 17/1/5.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYEditorTextView : UITextView
//文字
@property(nonatomic,copy) NSString *myPlaceholder;

//文字颜色
@property(nonatomic,strong) UIColor *myPlaceholderColor;
@end
