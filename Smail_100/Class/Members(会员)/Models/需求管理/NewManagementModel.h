//
//  NewManagementModel.h
//  MyCityProject
//
//  Created by mac_KY on 17/6/2.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewManagementModel : NSObject

/** 表题 */
@property(nonatomic,strong)NSString *title;
/** 内容 */
@property(nonatomic,strong)NSString *subTitle;
/** 显示箭头吗 */
@property(nonatomic,assign)BOOL showAssow;
/** 单位啊啊 😄 */
@property(nonatomic,strong)NSString *rightUnit;

/**是不是直接输入文字呢 😄*/
@property(nonatomic,assign)BOOL isInputText;
@end
