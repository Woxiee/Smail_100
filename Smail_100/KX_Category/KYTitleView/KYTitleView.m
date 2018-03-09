//
//  KYTitleView.m
//  CRM
//
//  Created by mac_KY on 17/2/8.
//  Copyright © 2017年 Frank. All rights reserved.
//




#import "KYTitleView.h"
#import "UIButton+EdgeInsets.h"
@implementation KYTitleView

-(void)setRotate:(BOOL)rotate
{
    _rotate = rotate;
    [UIView animateWithDuration:0.25 animations:^{
        if (_rotate) {
            self.imageView.transform = CGAffineTransformRotate(self.transform, 2*M_PI);
        }else{
            self.imageView.transform = CGAffineTransformRotate(self.transform, M_PI);
        }
    }];
}


-(id)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        _title = title;
        [self  setUp];
    
    }
    return self;
}

-(void)setUp
{
    CGFloat width = [_title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 50, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size.width;
    CGFloat imageW = 20;
 
    self.frame = CGRectMake(0, 0, width+imageW , 30);
    self.tag = 100;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self setTitle:_title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"1gongyong"] forState:UIControlStateNormal];
    [self layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];
    //[titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    //    titleBtn.timeInterVal = 1;
    self.imageView.transform = CGAffineTransformRotate(self.transform, M_PI);
    self.titleLabel.font = [UIFont systemFontOfSize:19 weight:UIFontWeightMedium];
 
    
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitle:_title forState:UIControlStateNormal];
    if ([title isEqualToString:@"产品"]) {
        [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
    CGFloat width = [_title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 50, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size.width;
    CGFloat imageW = 20;
    
    self.frame = CGRectMake(0, 0, width+imageW , 30);

    [self layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];

}


@end
