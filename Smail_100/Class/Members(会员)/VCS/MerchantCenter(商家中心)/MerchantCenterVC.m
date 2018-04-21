//
//  MerchantCenterVC.m
//  Smile_100
//
//  Created by ap on 2018/2/26.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MerchantCenterVC.h"
#import "MerchantHeadView.h"
#import "MeChantMainVC.h"
#import "StoreMangerVC.h"
#import "GoodsManagerVC.h"
#import "GoodManageVC.h"
#import "SmileForVC.h"

@interface MerchantCenterVC ()
@property (nonatomic, strong) NSDictionary *resultDic;

@property (nonatomic, strong) NSMutableArray  *titleArr;
@property (nonatomic, strong) NSMutableArray  *detailArr;
@property (nonatomic, strong)   UILabel *nameLB;


@end

@implementation MerchantCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self getInfoRequest];
}

- (void)getInfoRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [BaseHttpRequest postWithUrl:@"/shop/myshop" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            NSArray *monenyList = @[result[@"data"][@"today_money"],result[@"data"][@"month_money"],result[@"data"][@"money"]];
            for (int i = 0; i<monenyList.count; i++) {
                UILabel *label = _titleArr[i];
                label.text = monenyList[i];
            }
            _nameLB.text = result[@"data"][@"shop_name"];
            
            weakSelf.resultDic = result[@"data"];

        }
    }];
}


- (void)setup
{

    _titleArr = [[NSMutableArray alloc] init];
    _detailArr = [[NSMutableArray alloc] init];


    self.title  = @"商家中心";
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    headView.backgroundColor = KMAINCOLOR;
    [self.view addSubview:headView];
    
    NSArray *listArr = @[@"今日营业额(元)",@"本月营业额(元) ",@"总营业额(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "];
    NSArray *numberArr = @[@"8888",@"18888",@"888888                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "];

    for (NSInteger i = 0; i < 3; i++) {
        UILabel *numberLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, 30, SCREEN_WIDTH / 3, 20)];
        numberLB.text = numberArr[i];
        numberLB.font = [UIFont systemFontOfSize:22];
        numberLB.textColor = [UIColor whiteColor];
        numberLB.textAlignment = NSTextAlignmentCenter;
        [headView addSubview:numberLB];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, CGRectGetMaxY(numberLB.frame), SCREEN_WIDTH / 3, 20)];
        titleLB.text = listArr[i];
        titleLB.font = Font15;
        titleLB.textColor = [UIColor whiteColor];;
        titleLB.textAlignment = NSTextAlignmentCenter;
        [headView addSubview:titleLB];
        
        [_titleArr addObject:numberLB];

    }
    
    UILabel *nameLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 20)];
    nameLB.text = @"重庆老火锅点";
    nameLB.font =  KY_FONT(18);
    nameLB.textColor = [UIColor whiteColor];
    nameLB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:nameLB];
    _nameLB = nameLB;

    
    UIButton *reflectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reflectBtn.frame = CGRectMake(SCREEN_WIDTH - 80, 90, 45, 20);
    [reflectBtn setTitle:@"提现" forState:UIControlStateNormal];
    reflectBtn.titleLabel.font = Font14;
    [reflectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reflectBtn layerWithRadius:6 lineWidth:0.5 color:[UIColor whiteColor]];
    [reflectBtn addTarget:self action:@selector(didClilkAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:reflectBtn];
    
    
    
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame)- 25, SCREEN_WIDTH, 190)];
    bottomView.image = [UIImage imageNamed:@"shangjiazhongxin14@3x.png"];
    bottomView.userInteractionEnabled  = YES;
    [self.view addSubview:bottomView];
   
    
    
    NSArray *imageArray = @[@"shangjiazhongxin15@3x.png",@"shangjiazhongxin16@3x.png",@"shangjiazhongxin17@3x.png",@"shangjiazhongxin18@3x.png",@"shangjiazhongxin19@3x.png",@"shangjiazhongxin20@3x.png",@"shangjiazhongxin21@3x.png",@"shangjiazhongxin22@3x.png",];
    NSArray *titleArray = @[@"订单管理",@"商品管理",@"数据分析",@"门店管理",@"商家流水",@"附近的人",@"分享店铺",@"使用帮助"];
    int btnW =  SCREEN_WIDTH/4;
    
    for (int i = 0; i<imageArray.count; i++) {
        NSInteger index = i % 4;
        NSInteger page = i / 4;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(SCREEN_WIDTH/4*index , page*75+ 25,
                                 btnW , 75)];
        
        btn.tag = 100 +i;
        [btn addTarget:self action:@selector(didClickItemsAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:btn];
        
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake((btnW-25)/2, 10, 25, 25)];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        [btn addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, btn.width, 20)];
        label.text = titleArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = Font14;
        [btn addSubview:label];
        
    }
    
    
}


- (void)didClickItemsAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
        {
            MeChantMainVC *vc = [[MeChantMainVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 101:
        {
            GoodManageVC *vc = [[GoodManageVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 102:
        {
            
        }
            break;
        case 103:
        {
            StoreMangerVC *vc = [[StoreMangerVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 104:
        {
            
        }
            break;
            
            
        default:
            break;
    }
}


- (void)didClilkAction
{
    SmileForVC *vc = [[SmileForVC alloc] init];
    vc.title = @"商家体现";
    vc.showType = @"1";
    [self.navigationController pushViewController:vc animated:YES];
}





@end
