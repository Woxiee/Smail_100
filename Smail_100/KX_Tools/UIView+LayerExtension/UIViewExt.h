//
//  UIViewExt.h
//  KYAnnmationDemo
//
//  Created by mac_KY on 17/1/14.
//  Copyright © 2017年 mac_KY. All rights reserved.
// < 2017 3 3>

#import <UIKit/UIKit.h>
//全局常量定义
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#import "UILabel+Utils.h"
#import "UIButton+Utils.h"
#import "UIColor+Utils.h"

typedef NS_ENUM(NSUInteger,KYAnnimationOptions) {
   
    KYAnnimationOptionsSHowFomUp, //从上边
    KYAnnimationOptionsShowLeft,//从左边
    KYAnnimationOptionsShowFromBotton,//从下边
    KYAnnimationOptionsShowFromRight//从右边
    
};


typedef NS_ENUM(NSUInteger, KYBezierOptions) {
    //从上边 左边 下边 右边
    KYBezierOptionsUp = 0,
    KYBezierOptionsLeft,
    KYBezierOptionsBottom ,
    KYBezierOptionsUpRight,
};


typedef NS_ENUM(NSUInteger, KYOscillatoryAnimationType) {
    KYOscillatoryAnimationToBigger = 0,//先变大后变小
    KYOscillatoryAnimationToSmaller,//先变小后变大
};

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)
@property CGPoint origin;
@property CGSize size;
@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

-(void)setConnerRediu;

-(void)setConnerRediu:(CGFloat )rediu;
-(void)setBorderWidth:(CGFloat)width;
-(void)setBorderColor:(UIColor *)color;
/**
 设置边框宽度和颜色

 @param color 边框颜色
 @param width 边框宽度
 */
-(void)setBorderByColor:(UIColor*)color width:(CGFloat)width;

/**
 设置动画

 @param show 显示还是隐藏
 @param option 显示方式
 @param duratime 动画时间  默认0.25
 */
-(void)setAnnimationShow:(BOOL)show annimationOption:(KYAnnimationOptions)option duratime:(CGFloat)duratime;


/**
 设置动画
 
 @param show 显示还是隐藏
 @param option 显示方式
 @param duratime 动画时间  默认0.25
 */
-(void)setAnnimationShow:(BOOL)show annimationOption:(KYAnnimationOptions)option duratime:(CGFloat)duratime completion:(void(^)(BOOL finish))completion;

/**
 有阻尼的弹性动画
 @param option 显示好方式
 @param duratime 动画时间
 */
-(void)setSpringAnnimationOption:(KYAnnimationOptions)option duratime:(CGFloat)duratime;


/**
 关键帧动画 连续几个点的直线运动

 @param points 点
 @param duratime 这整个的运动时间
 */
-(void)moveBypoints:(NSArray <NSValue*>*)points duratime:(CGFloat)duratime;



/**
 添加半圈移动动画（！有问题）

 @param point 终点
 @param duratime 动画时间
 @param bezierOptions 动画类型
 */
-(void)moveBezierTopoint:(CGPoint )point duratime:(CGFloat)duratime bezierOptions:(KYBezierOptions)bezierOptions;

/**
 多个item有时间差的进行阻尼动画  出现时间间隔：0.15*i

 @param views 需要动画的View
 @param option 动画方式
 @param duratime 动画时间
 */
+(void)setSpringAnimations:(NSArray <UIView*>*)views annimationOption:(KYAnnimationOptions)option duratime:(CGFloat)duratime;

/**
 大小重复改变动画

 @param layer view的layer
 @param type 先变大还是先变小
 */
+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(KYOscillatoryAnimationType)type;



#pragma mark - prive 注意：内部使用 外部声明 不用调用
-(void)setAnnimationOption:(KYAnnimationOptions)option;








/*####################################################*/
#pragma mark -
#pragma mark - 使用链式思想开发的－优点 快速开发



/**
 设置边框颜色
 */
-(UIView *(^)(UIColor *borderColor))KYBorderColor;

/**
 设置边框宽度
 */
-(UIView *(^)(CGFloat borderWidth))KYBorderWidth;

/**
 快速设置圆角－cell内部禁止使用（避免卡屏） rediu可以不传－> rediu默认是width／2
 */
-(UIView *(^)(CGFloat rediu))KYConnerRediu;
 
#pragma mark - annimation
 
 /*
 设置边框宽度和颜色 color.-> 边框颜色  width.-> 边框宽度
 */
-(UIView *(^)(UIColor *color,CGFloat width))KYBorderColorWidth;






/* 用于学习 可以不用删除
这个属性用以指定时间函数，类似于运动的加速度
 kCAMediaTimingFunctionLinear//线性
 kCAMediaTimingFunctionEaseIn//淡入
 kCAMediaTimingFunctionEaseOut//淡出
 kCAMediaTimingFunctionEaseInEaseOut//淡入淡出
 kCAMediaTimingFunctionDefault//默认
 
 下面来讲各个fillMode的意义
 kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
 kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态
 kCAFillModeBackwards 这个和kCAFillModeForwards是相对的,就是在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态
 kCAFillModeBoth 理解了上面两个,这个就很好理解了,这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状态.
 
 
 在关键帧动画中还有一个非常重要的参数,那便是calculationMode,计算模式.该属性决定了物体在每个子路径下是跳着走还是匀速走，跟timeFunctions属性有点类似
 其主要针对的是每一帧的内容为一个座标点的情况,也就是对anchorPoint 和 position 进行的动画.当在平面座标系中有多个离散的点的时候,可以是离散的,也可以直线相连后进行插值计算,也可以使用圆滑的曲线将他们相连后进行插值计算. calculationMode目前提供如下几种模式
 
 kCAAnimationLinear calculationMode的默认值,表示当关键帧为座标点的时候,关键帧之间直接直线相连进行插值计算;
 kCAAnimationDiscrete 离散的,就是不进行插值计算,所有关键帧直接逐个进行显示;
 kCAAnimationPaced 使得动画均匀进行,而不是按keyTimes设置的或者按关键帧平分时间,此时keyTimes和timingFunctions无效;
 kCAAnimationCubic 对关键帧为座标点的关键帧进行圆滑曲线相连后插值计算,对于曲线的形状还可以通过tensionValues,continuityValues,biasValues来进行调整自定义,这里的数学原理是Kochanek–Bartels spline,这里的主要目的是使得运行的轨迹变得圆滑;
 kCAAnimationCubicPaced 看这个名字就知道和kCAAnimationCubic有一定联系,其实就是在kCAAnimationCubic的基础上使得动画运行变得均匀,就是系统时间内运动的距离相同,此时keyTimes以及timingFunctions也是无效的.

 */


@end
