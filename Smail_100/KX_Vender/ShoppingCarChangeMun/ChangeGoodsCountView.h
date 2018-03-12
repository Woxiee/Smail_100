//
//  ChangeGoodsCountView.h
//  ShowView
//
//  Created by mac_KY on 17/4/18.
//  Copyright © 2017年 mac_KY. All rights reserved.
//修改购物车或物品购买数量  轻量级别内部实现代理－即用即毁

#import <UIKit/UIKit.h>
 

@interface ChangeGoodsCountView : UIView

+(id)changeCountViewWith:(NSString *)count getChangeValue:(void(^)(NSString *changeValue))chageValueBlock;


-(void)show;
-(void)hide;

@end
