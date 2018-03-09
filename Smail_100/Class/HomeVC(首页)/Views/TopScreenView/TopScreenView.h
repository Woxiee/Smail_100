//
//  TopScreenView.h
//  MyCityProject
//
//  Created by Faker on 17/5/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsScreenmodel.h"

typedef NS_ENUM(NSInteger, TopScreenenSelectType){
    TopScreenNomalType,           /// 正常显示
    TopScreenOtherType,           /// 其他显示
    
};

typedef void(^SelectTopIndexBlock)(NSInteger index, NSString *key, NSString *title);


@interface TopScreenView :UIView

@property (nonatomic, strong) GoodsScreenmodel *model;
@property (nonatomic, strong) NSString *btnTitle;  /// 用于显示 选择栏目之后 重新赋值

///选择 顶部按钮索引
@property (nonatomic, copy) SelectTopIndexBlock selectTopIndexBlock;

@property (nonatomic, assign) NSInteger selectIndex;    /// 记录当前选择的栏目
@property (nonatomic, assign)  TopScreenenSelectType topScreenType; /// 顶部显示样式

/**
 *  还原设置
 */
- (void)defaultTopSreenView:(NSInteger)index;
@end
