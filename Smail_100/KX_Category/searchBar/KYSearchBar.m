//
//  KYSearchBar.m
//  Searchbar
//
//  Created by mac_KY on 17/3/17.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import "KYSearchBar.h"
 
// 为了书写方便,便于管理,定义一个不可变的全局变量;
static NSString * const DXPlaceholderColorKey = @"placeholderLabel.textColor";
@implementation KYSearchBar
+(id)searchBar
{
    return [[self alloc]init];
}

-(id)init{
    
    if (self = [super init]) {
        [self loadSubview];
        self.returnKeyType =  UIReturnKeySearch;
        
    }
    return self;
    
}


-(void)loadSubview{
    
    UIImageView *leftView = [[UIImageView alloc]init];
    leftView.image = [UIImage imageNamed:@"sousuo"];
    leftView.left = 0;
    leftView.frame = CGRectMake(0, 0, 30, 30);
    leftView.contentMode = UIViewContentModeCenter;
    [self setConnerRediu:5];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
    //设置右边的清空
    self.font = [UIFont systemFontOfSize:14];
    
}

#pragma mark - SET

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
 
    _placeholderColor = placeholderColor;
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
 
}

@end
