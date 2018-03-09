//
//  MyTeamListVC.h
//  Smile_100
//
//  Created by Faker on 2018/2/21.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MyTeamListType){
    FirstTeamListType,                  /// 一级
    SecondTeamListType,                 ///二级
    ThreeTeamListType,                 ///三级

};
@interface MyTeamListVC : KX_BaseTableViewController

@property (nonatomic, assign) MyTeamListType *teamType;
@end
