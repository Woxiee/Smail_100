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
    [self setUI];
    [self requestListNetWork];
}

- (void)setUI
{
    self.title = @"我的团队";
   
}

- (void)requestListNetWork
{
    
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_user_id?_user_id:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"group_user_id"];
    [param setObject:@"1" forKey:@"level"];
    [param setObject:@"1" forKey:@"pageno"];
    [param setObject:@"10" forKey:@"page_size"];

    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/group/groupList" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            
//            MyteamModel *model = [MyteamModel yy_modelWithJSON:result[@"data"]];
            
//            [self setUI];

            if (KX_NULLString(_user_id)) {
                MyTeamListVC *vc1 = [MyTeamListVC new];
                vc1.superVC = self;
                MyTeamListVC *vc2 = [MyTeamListVC new];
                vc2.superVC = self;

                MyTeamListVC *vc3 = [MyTeamListVC new];
                vc3.superVC = self;

                NSArray *childVCArr =@[vc1,vc2,vc3];
                //            NSDictionary *titleDic =
                NSArray *titleArr = result[@"data"][@"count"][@"reg"];
                self.scrollerView = [[LXQScrollerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) titleArray:titleArr chaildVCArray:childVCArr];
                self.scrollerView.didClickItemBlock = ^(NSInteger index) {
                    MyTeamListVC *vc = childVCArr[index];
                    vc.teamType = index;
                    [vc requestListNetWork];
                };
                [self.view addSubview:self.scrollerView];
                [vc1 requestListNetWork];

            }
           

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
