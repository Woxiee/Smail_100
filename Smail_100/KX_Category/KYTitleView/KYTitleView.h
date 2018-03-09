//
//  KYTitleView.h
//  CRM
//
//  Created by mac_KY on 17/2/8.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYTitleView : UIButton


@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)BOOL editing;
@property(nonatomic,assign)BOOL rotate;

-(id)initWithTitle:(NSString *)title;//每次点击小三角形按钮自动转动180度  按钮每次也会改变select属性

@end
