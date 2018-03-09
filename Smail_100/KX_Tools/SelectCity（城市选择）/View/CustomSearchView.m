//
//  CustomSearchView.m
//  MySelectCityDemo
//
//  Created by 李阳 on 15/9/2.
//  Copyright (c) 2015年 WXDL. All rights reserved.
//

#import "CustomSearchView.h"

@implementation CustomSearchView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.frame =CGRectMake(0, 7, frame.size.width, 30);
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.showsCancelButton = NO;
        _searchBar.tintColor = [UIColor orangeColor];
        _searchBar.placeholder = @"请输入城市名或拼音查询";
        
        for (UIView *subView in _searchBar.subviews) {
            if ([subView isKindOfClass:[UIView  class]]) {
                [[subView.subviews objectAtIndex:0] removeFromSuperview];
                if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                    UITextField *textField = [subView.subviews objectAtIndex:0];
                    textField.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                    
                    //设置输入框边框的颜色
                    //                    textField.layer.borderColor = [UIColor blackColor].CGColor;
                    //                    textField.layer.borderWidth = 1;
                    
                    //设置输入字体颜色
                    //                    textField.textColor = [UIColor lightGrayColor];
                    
                    //设置默认文字颜色
                    UIColor *color = [UIColor grayColor];
                    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"请输入城市名或拼音查询"
                                                                                        attributes:@{NSForegroundColorAttributeName:color}]];
//                    //修改默认的放大镜图片
//                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
//                    imageView.backgroundColor = [UIColor clearColor];
//                    imageView.image = [UIImage imageNamed:@"48@3x.png"];
//                    textField.leftView = imageView;
                    _searchBar.delegate = self;
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
                    lineView.backgroundColor = LINECOLOR;
                    [self addSubview:lineView];

                }
            }
        }
        
        [self addSubview:_searchBar];
        
    }
    return self;
}
// UISearchBar得到焦点并开始编辑时，执行该方法
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];

    if(searchBar.text.length==0||[searchBar.text isEqualToString:@""]||[searchBar.text isKindOfClass:[NSNull class]])
    {
        if([_delegate respondsToSelector:@selector(searchBeginEditing)])
        {
            [_delegate searchBeginEditing];
        }
    }
    else
    {
        if([_delegate respondsToSelector:@selector(searchString:)])
        {
            [_delegate searchString:searchBar.text];
        }
    }
    
   // return YES;
}
// 取消按钮被按下时，执行的方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = nil;
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    if([_delegate respondsToSelector:@selector(didSelectCancelBtn)])
    {
        [_delegate didSelectCancelBtn];
    }
}
// 键盘中，搜索按钮被按下，执行的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
   // NSLog(@"searchBarSearchButtonClicked");
}
// 当搜索内容变化时，执行该方法。很有用，可以实现时实搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   if([_delegate respondsToSelector:@selector(searchString:)])
   {
       [_delegate searchString:searchText];
   }
}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
