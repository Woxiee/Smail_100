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
@property (nonatomic, strong) NSMutableArray *coutArr;
@end

@implementation MyteamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestListNetWork];
}

- (void)setUI
{
    self.title = @"我的团队";
    MyTeamListVC *vc1 = [MyTeamListVC new];
    MyTeamListVC *vc2 = [MyTeamListVC new];
    MyTeamListVC *vc3 = [MyTeamListVC new];
    
    self.scrollerView = [[LXQScrollerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) titleArray:@[@"66", @"100", @"99"] chaildVCArray:@[vc1,vc2,vc3]];
    self.scrollerView.didClickItemBlock = ^(NSInteger index) {
        
        
    };
    [self.view addSubview:self.scrollerView];
}

- (void)requestListNetWork
{
    
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"group_user_id"];

    [param setObject:@"1" forKey:@"level"];
    [param setObject:@"1" forKey:@"pageno"];
    [param setObject:@"10" forKey:@"page_size"];

    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/group/groupList" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            
            MyteamModel *model = [MyteamModel yy_modelWithJSON:result[@"data"]];
            
            [self setUI];

            
//            model.banners = [NSArray yy_modelArrayWithClass:[Banners class] json:model.banners];
//            model.count = [Count yy_modelWithJSON:result[@"data"][@"count"]];
//            model.content = [Content yy_modelWithJSON:result[@"data"][@"content"]];
//            weakSelf.model = model;
//            NSMutableArray *imgList = [[NSMutableArray alloc] init];
//            for (Banners *banner in model.banners) {
//                [imgList addObject:banner.pict_url];
//            }
//            _cycleView.imageURLStringsGroup = imgList;
//            NSArray *dataList = @[_model.count.reg,_model.count.pay,_model.count.money];
//            self.selectTeamView.dataList = dataList;
//            [weakSelf.tableView reloadData];
            
        }
    }];
}





@end
