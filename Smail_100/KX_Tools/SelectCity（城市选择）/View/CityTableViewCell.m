//
//  CityTableViewCell.m
//  MySelectCityDemo
//
//  Created by ZJ on 15/10/28.
//  Copyright © 2015年 WXDL. All rights reserved.
//

#import "CityTableViewCell.h"
#define  ScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation CityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cityArray:(NSArray*)array
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _cityArray =array;
        self.backgroundColor = BACKGROUND_COLOR;
        for(int i=0;i<array.count;i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.center = CGPointMake(ScreenWidth/6+(ScreenWidth/3-10)*(i%3), 30+(30+12)*(i/3));
            btn.tag = i;
            btn.bounds = CGRectMake(0, 0, ScreenWidth/3-20, 30);
            [btn setTitleColor:DETAILTEXTCOLOR forState:0];
            [btn setTitle:array[i] forState:0];
            btn.titleLabel.font = Font15;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [self addSubview:btn];
//            btn.layer.borderWidth = 0.5;
//            btn.layer.borderColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1].CGColor;
        }
    }
    return self;
}
-(void)click:(UIButton *)btn
{
    if(_cityArray.count==1&btn.tag==0)
    {
        self.didSelectedBtn(1111);
    }
    else
    {
        self.didSelectedBtn((int)btn.tag);
    }
}
@end
