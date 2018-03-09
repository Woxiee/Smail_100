//
//  KYChartView.m
//  KYChartView
//
//  Created by mac_KY on 17/2/8.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import "KYChartView.h"


@implementation KYChartItem

@end

@implementation KYChartView
-(id)initWithFrame:(CGRect)frame chartItem:(KYChartItem *)chartItem
{
    if (self = [super initWithFrame:frame]) {
       
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        _chartItem = chartItem;
    }
    return self;
    
}


-(void)drawRect:(CGRect)rect
{
    switch (_chartItem.type) {
        case KYChartTypeCircular:{
            [self drawCircular];
        }break;
        case KYChartTypeArc:{
            [self drawArc];
        }break;
        case KYChartTypeAnnular:{
            [self drawAnnular];
        }break;
        case KYChartTypeAnnularArc:{
            [self drawAnnularArc];
        }break;
        case KYChartTypeTwoArc:{
            [self drawTwoArc];
        }break;
        default:
            break;
    }

 
    
}

///圆
-(void)drawCircular
{

}

///弧度
-(void)drawArc
{

}
///环形
-(void)drawAnnular
{
    
}
///环形弧
-(void)drawAnnularArc
{
    
}
///需要的中间尖尖的图形
-(void)drawTwoArc
{
    UIColor *redColor =_chartItem.leftColor;
    [redColor set];
    UIColor *bleuColor = _chartItem.rightColor;
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(0, self.height)];
    
    CGFloat a,b,agl,xb,radiu;
    a = self.height;
    b = self.width/2;
    //斜边
    xb = sqrt(a*a +b*b);
    if (b >= a) {
        
        agl = atan(a/b);
        radiu = (xb/2)/sin(agl);
        path.lineWidth = 2.0f;
        //分成两笔
        [path addArcWithCenter:CGPointMake(0, a - radiu) radius:radiu startAngle:M_PI_2 endAngle:M_PI_2 - 2*agl clockwise:NO];
        [path addLineToPoint:CGPointMake(b, a)];
        [path addLineToPoint:CGPointMake(0, a)];
        [path fill];
        [path stroke];
        
        UIBezierPath *path1 = [[UIBezierPath alloc]init];
        [path1 moveToPoint:CGPointMake(b, 0)];
        [bleuColor set];
        [path1 addArcWithCenter:CGPointMake(b*2, a - radiu) radius:radiu startAngle:M_PI_2+2*agl endAngle:M_PI_2 clockwise:NO];
        [path1 addLineToPoint:CGPointMake(b, a)];
        [path1 addLineToPoint:CGPointMake(b, 0)];
        [path1 fill];
        [path1 stroke];
        
        
    }else{
        agl = atan(b/a);
        radiu = (xb/2)/sin(agl);
        //分成两笔
        
        [path addArcWithCenter:CGPointMake(b - radiu, 0) radius:radiu startAngle:2*agl endAngle:0 clockwise:NO];
        [path addLineToPoint:CGPointMake(b, a)];
        [path addLineToPoint:CGPointMake(0, a)];
        [path fill];
        [path stroke];
        
        
        UIBezierPath *path1 = [[UIBezierPath alloc]init];
        [bleuColor set];
        [path1 addArcWithCenter:CGPointMake(b + radiu, 0) radius:radiu startAngle:M_PI endAngle:M_PI - 2*agl clockwise:NO];
        [path1 addLineToPoint:CGPointMake(b, a)];
        [path1 addLineToPoint:CGPointMake(b, 0)];
        [path1 fill];
        [path1 stroke];
        
    }
}
@end
