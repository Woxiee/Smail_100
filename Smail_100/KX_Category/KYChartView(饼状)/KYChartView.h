//
//  KYChartView.h
//  KYChartView
//
//  Created by mac_KY on 17/2/8.
//  Copyright © 2017年 mac_KY. All rights reserved.
//


/*
 
    *
  *  *
 *    *
*       *
 */
#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, KYChartType) {
    KYChartTypeCircular,//圆
    KYChartTypeArc,//弧形
    KYChartTypeAnnular,//环形
    KYChartTypeAnnularArc,//环形弧
    KYChartTypeTwoArc //需要的中间尖尖的图形
};

@interface KYChartItem :NSObject

@property(nonatomic,assign)KYChartType type;

//尖尖那种 两边颜色不一样
@property(nonatomic,strong)UIColor *leftColor;
@property(nonatomic,strong)UIColor *rightColor;


@end

@class KYChartItem;
@interface KYChartView : UIView

@property(nonatomic,strong,readonly) KYChartItem*chartItem;//属性配置

-(id)initWithFrame:(CGRect)frame chartItem:(KYChartItem *)chartItem;

@end

