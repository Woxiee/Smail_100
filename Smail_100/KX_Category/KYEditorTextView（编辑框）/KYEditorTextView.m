//
//  KYEditorTextView.m
//  CRM
//
//  Created by Frank on 17/1/5.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "KYEditorTextView.h"

@interface KYEditorTextView ()
@property (nonatomic,strong) UILabel *placeholderLabel;
@end

@implementation KYEditorTextView
-(instancetype)initWithFrame:(CGRect)frame
{
    
    self=[super initWithFrame:frame];
    
    if(self) {
        
        self.backgroundColor= [UIColor clearColor];
        
        // 添加一个占位label
        UILabel *placeholderLabel=[[UILabel alloc]init];
        placeholderLabel.backgroundColor=[UIColor clearColor];
        // 设置可以输入多行文字时可以自动换行
        placeholderLabel.numberOfLines=0;
        [self addSubview:placeholderLabel];
        
        // 赋值保存
        self.placeholderLabel= placeholderLabel;
        // 设置占位文字默认颜色
        self.myPlaceholderColor= LINECOLOR;
        
        // 设置默认的字体
        self.font = [UIFont systemFontOfSize:14];
        
        // 通知:监听文字的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor= [UIColor clearColor];
        // 添加一个占位label
        UILabel *placeholderLabel=[[UILabel alloc]init];
        placeholderLabel.backgroundColor=[UIColor clearColor];
        // 设置可以输入多行文字时可以自动换行
        placeholderLabel.numberOfLines=0;
        [self addSubview:placeholderLabel];
        
        // 赋值保存
        self.placeholderLabel= placeholderLabel;
        self.placeholderLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        // 设置占位文字默认颜色
        self.myPlaceholderColor= [UIColor colorWithRed:0.737 green:0.733 blue:0.737 alpha:1.000];
        // 设置默认的字体
        self.font= [UIFont systemFontOfSize:14];
        // 通知:监听文字的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

#pragma mark -监听文字改变
- (void)textDidChange
{
    self.placeholderLabel.hidden=self.hasText;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    // 根据文字计算高度
    CGSize maxSize =CGSizeMake(SCREEN_WIDTH,MAXFLOAT);
    float h = [self.myPlaceholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    
    // 设置 UILabel 的 x
    self.placeholderLabel.frame  =CGRectMake(5, 8, SCREEN_WIDTH-10, h);

}


- (void)setMyPlaceholder:(NSString*)myPlaceholder
{
    _myPlaceholder= [myPlaceholder copy];
    
    // 设置文字
    self.placeholderLabel.text= myPlaceholder;
    
    //重新计算子控件frame
    [self setNeedsLayout];
    
}
- (void)setMyPlaceholderColor:(UIColor*)myPlaceholderColor
{
    _myPlaceholderColor= myPlaceholderColor;
    
    //设置颜色
    self.placeholderLabel.textColor= myPlaceholderColor;
}

// 重写这个set方法保持font一致
- (void)setFont:(UIFont*)font
{
    [super setFont:font];
    self.placeholderLabel.font= font;
    
    //重新计算子控件frame
    [self setNeedsLayout];
}

- (void)setText:(NSString*)text
{
    [super setText:text];
    
    // 这里调用的就是 UITextViewTextDidChangeNotification 通知的回调
    [self textDidChange];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)setAttributedText:(NSAttributedString*)attributedText
{
    [super setAttributedText:attributedText];
    // 这里调用的就是UITextViewTextDidChangeNotification 通知的回调
    [self textDidChange];
}

@end
