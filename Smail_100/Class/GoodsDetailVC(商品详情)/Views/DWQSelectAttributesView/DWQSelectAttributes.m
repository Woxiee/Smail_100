//
//  DWQSelectAttributes.m
//  DWQSelectAttributes
//
//  Created by 杜文全 on 15/5/21.
//  Copyright © 2015年 com.sdzw.duwenquan. All rights reserved.
//

#import "DWQSelectAttributes.h"

@implementation DWQSelectAttributes

-(instancetype)initWithTitle:(NSString *)title titleArr:(NSArray *)titleArr andFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        self.title = title;
        
        self.attributesArray = (NSArray *)titleArr;
        
        [self rankView];
    }
    return self;
}


-(void)rankView{
    
    self.packView = [[UIView alloc] initWithFrame:self.frame];
    self.packView.dwq_y = 0;
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = LINECOLOR;
    [self.packView addSubview:line];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH, 25)];
    titleLB.text = self.title;
    titleLB.font = CONTENFONT;
    [self.packView addSubview:titleLB];
    
    self.btnView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(titleLB.frame), SCREEN_WIDTH, 40)];
    [self.packView addSubview:self.btnView];
    
    int count = 0;
    float btnWidth = 0;
    float viewHeight = 0;
    for (int i = 0; i < self.attributesArray.count; i++) {
        
        NSString *btnName = self.attributesArray[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:BACKGROUND_COLOR];
        [btn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:btnName forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:Font13 forKey:NSFontAttributeName];
        CGSize btnSize = [btnName sizeWithAttributes:dict];
        
        btn.dwq_width = btnSize.width + 15;
        btn.dwq_height = btnSize.height + 12;
        
        if (i==0)
        {
            btn.dwq_x = 20;
            btnWidth += CGRectGetMaxX(btn.frame);
        }
        else{
            btnWidth += CGRectGetMaxX(btn.frame)+20;
            if (btnWidth > SCREEN_WIDTH) {
                count++;
                btn.dwq_x = 20;
                btnWidth = CGRectGetMaxX(btn.frame);
            }
            else{
                
                btn.dwq_x += btnWidth - btn.dwq_width;
            }
        }
        btn.dwq_y += count * (btn.dwq_height+10)+10;
        
        viewHeight = CGRectGetMaxY(btn.frame)+10;
        
        [self.btnView addSubview:btn];
        
        btn.tag = 10000+i;
        

        
    }
    self.btnView.dwq_height = viewHeight;
    self.packView.dwq_height = self.btnView.dwq_height+CGRectGetMaxY(titleLB.frame);
    
    self.dwq_height = self.packView.dwq_height;
    
    [self addSubview:self.packView];
}


-(void)btnClick:(UIButton *)btn{
    
    
    if (![self.selectBtn isEqual:btn]) {
        
        self.selectBtn.backgroundColor = BACKGROUND_COLOR;
        self.selectBtn.selected = NO;
        
        //        NSLog(@"%@-----%@",btn.titleLabel.text,[self.rankArray[btn.tag-10000] sequence]);
    }
//    else{
//        btn.backgroundColor = SelectColor;
//    }
    btn.backgroundColor = KMAINCOLOR;
    btn.selected = YES;
    
    self.selectBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(selectBtnTitle:andBtn:)]) {
        
        [self.delegate selectBtnTitle:self.title andBtn:self.selectBtn];
    }
}

@end
