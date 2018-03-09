//
//  KYTextView.m
//  KYTextViewDemo1
//
//  Created by mac_KY on 17/1/9.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import "KYTextView.h"

static CGFloat textCountLbWidth = 50;

@interface KYTextView ()<UITextViewDelegate>
//这里先拿出这个label以方便我们后面的使用

@property(nonatomic,strong)UILabel *textCountLb;

@end

@implementation KYTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.textContainerInset = UIEdgeInsetsMake(1, 1, 1, 1);
        self.backgroundColor= [UIColor clearColor];
        self.delegate = self;
        //字数显示
        _textCountLb = [[UILabel alloc]initWithFrame:CGRectMake(self.width - textCountLbWidth, self.height - 17, textCountLbWidth, 15)];
        [self addSubview:_textCountLb];
        _textCountLb.hidden = YES;
        _textCountLb.font  =[UIFont systemFontOfSize:12];
        _textCountLb.textColor  =[UIColor lightGrayColor];
        self.KYPlaceholderColor= [UIColor blackColor];
        
        // 通知:监听文字的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];

    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    
    self=[super initWithFrame:frame];
    
    if(self) {
        self.textContainerInset = UIEdgeInsetsMake(1, 1, 1, 1);
        self.backgroundColor= [UIColor clearColor];
        self.delegate = self;
        //字数显示
        _textCountLb = [[UILabel alloc]initWithFrame:CGRectMake(self.width - textCountLbWidth, self.height - 17, textCountLbWidth, 15)];
        [self addSubview:_textCountLb];
        _textCountLb.hidden = YES;
        _textCountLb.font  =[UIFont systemFontOfSize:12];
        _textCountLb.textColor  =[UIColor lightGrayColor];
        self.KYPlaceholderColor= [UIColor blackColor];
        
        // 通知:监听文字的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}


#pragma mark -监听文字改变
- (void)textDidChange
{
    
    if ([self.text isEqualToString:_KYPlaceholder]) {
        
    }else{
    _textCountLb.text = [NSString stringWithFormat:@"%ld/%ld",self.text.length,_maxTextCount];
     
    }

    if (self.text.length>_maxTextCount) {
        
    }
   
    _textCountLb.textColor =(self.text.length >_maxTextCount-1)? [UIColor redColor]:[UIColor lightGrayColor];
  
}

#pragma mark - UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (_maxTextCount && (range.location >_maxTextCount-1)) {

        return NO;
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.text isEqualToString:_KYPlaceholder]) {
        self.text = @"";
        self.textColor = [UIColor blackColor];
    }

    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (_maxTextCount && textView.markedTextRange == nil && textView.text.length > _maxTextCount) {


        //截取
        textView.text = [textView.text substringToIndex:_maxTextCount];
    }
}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (self.text.length==0) {
        self.text = _KYPlaceholder;
        self.textColor = _KYPlaceholderColor;
    }
    return YES;
}
#pragma mark - SET


-(void)setMaxTextCount:(NSUInteger)maxTextCount
{
    _maxTextCount = maxTextCount;
  _textCountLb.hidden = NO;
   
}
-(void)setKYPlaceholder:(NSString *)KYPlaceholder
{
    _KYPlaceholder = KYPlaceholder;
    self.text = KYPlaceholder;
    self.textColor = _KYPlaceholderColor;

}

-(void)setKYPlaceholderColor:(UIColor *)KYPlaceholderColor
{
    _KYPlaceholderColor = KYPlaceholderColor;
    self.textColor = KYPlaceholderColor;
}

- (void)dealloc
{
     [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.delegate = nil;
}


@end
