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
    OtherTeamListType,                 ///其他


};
@interface MyTeamListVC : BaseTableVC

@property (nonatomic, assign) MyTeamListType teamType;
@property (nonatomic, strong) NSString  *group_user_id;

@property (nonatomic, strong) UIViewController *superVC;

- (void)requestListNetWork;

@end
