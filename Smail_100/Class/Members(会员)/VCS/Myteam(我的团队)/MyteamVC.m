//
//  MyteamVC.m
//  Smile_100
//
//  Created by Faker on 2018/2/20.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MyteamVC.h"
#import "LXQScrollerView.h"
#import "MyTeamListVC.h"

@interface MyteamVC ()
@property (nonatomic, strong) LXQScrollerView *scrollerView;

@end

@implementation MyteamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI
{
    self.title = @"我的团队";
    MyTeamListVC *vc1 = [MyTeamListVC new];
    MyTeamListVC *vc2 = [MyTeamListVC new];
    MyTeamListVC *vc3 = [MyTeamListVC new]; 
    self.scrollerView = [[LXQScrollerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) titleArray:@[@"66", @"100", @"99"] chaildVCArray:@[vc1,vc2,vc3]];
    
    [self.view addSubview:self.scrollerView];
}






@end
