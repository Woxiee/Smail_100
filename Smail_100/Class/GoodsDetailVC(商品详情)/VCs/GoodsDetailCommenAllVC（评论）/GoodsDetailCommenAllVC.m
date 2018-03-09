//
//  GoodsDetailCommenAllVC.m
//  ShiShi
//
//  Created by Faker on 17/3/10.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "GoodsDetailCommenAllVC.h"
#import "CommentModel.h"
#import "GoodsDetailCommonCell.h"
#import "GoodsCommonChooseView.h"

@interface GoodsDetailCommenAllVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) KX_LoginHintView  *loginHintView;
@end

@implementation GoodsDetailCommenAllVC
{
    __weak IBOutlet UIButton *chooseBtn;
    
    __weak IBOutlet UILabel *goodCommentLaabel;
    
}
static NSString *const goodsDetailCommonCellID = @"goodsDetailCommonCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品评价";
    self.pageIndex = 0;
    [self setRefreshTableView];
    [self.tableView  headerFirstRefresh];
    [self setConfiguration];

}


/// 获取商品评价列表
- (void)getGoodsCommonList:(NSInteger )page withcommonType:(NSString *)type
{

     WEAKSELF;
    // 1:新机、配构件、二手设备、整机流转的出租、标准节共享的出租
    //  3: 检测吊运
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
  if ( [_typeStr isEqualToString:@"6"] )
    {
        [param setObject:@"2" forKey:@"commentType"];
//        [param setObject:_VC.model.mainId?_VC.model.mainId:@"" forKey:@"mainId"];
    }else{
        [param setObject:@"1" forKey:@"commentType"];
        if ([_typeStr isEqualToString:@"9"]) {
//            [param setObject:_VC.model.mainId?_VC.model.mainId:@"" forKey:@"mainId"];
        }else{
            [param setObject:_productID?_productID:@"" forKey:@"mainId"];
        }
    }
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)page];
    [param setObject:type forKey:@"param1"];
    [param setObject:@"10" forKey:@"pageSize"];
    [param setObject:pageStr forKey:@"pageIndex"];
    
    [BaseHttpRequest postWithUrl:@"/o/o_060" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if (error) {
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }else{
            LOG(@"获取商品评价 == %@",result);
            NSInteger state = [[result valueForKey:@"state"] integerValue];
            NSString *msg = [result valueForKey:@"msg"];
            NSArray *dataArray = [result valueForKey:@"data"][@"obj"][@"commentListMap"];
            if ([dataArray isKindOfClass:[NSArray class]]) {
                if (state == 0) {
                    if (weakSelf.pageIndex == 0) {
                        [weakSelf.resorceArray removeAllObjects];
                    }
                    NSArray *listArray = [CommentModel mj_objectArrayWithKeyValuesArray:dataArray];
                    [self.resorceArray addObjectsFromArray:listArray];
        
                    [self.tableView reloadData];
                }
            }else{
                [weakSelf.view makeToast:msg];
            }

        }
        [weakSelf stopRefresh];

    }];
}



/// 设置刷新
- (void)setRefreshTableView
{
    WEAKSELF;
    [self.tableView headerWithRefreshingBlock:^{
       weakSelf.pageIndex = 0;
        [weakSelf getGoodsCommonList:weakSelf.pageIndex withcommonType:@"0"];
    }];
    
    [self.tableView footerWithRefreshingBlock:^{
        weakSelf.pageIndex++;
        [weakSelf getGoodsCommonList:weakSelf.pageIndex withcommonType:@"0"];

    }];
}

-(void)stopRefresh
{

    
}

/// 配置基础设置
- (void)setConfiguration
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[GoodsDetailCommonCell class] forCellReuseIdentifier:goodsDetailCommonCellID];
}

#pragma mark - UITaleViewDelegate and UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.resorceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GoodsDetailCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsDetailCommonCellID];
    if (!cell) {
        cell = [[GoodsDetailCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsDetailCommonCellID];
    }
    CommentModel *model  = self.resorceArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentModel  *model = self.resorceArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[GoodsDetailCommonCell class] contentViewWidth:SCREEN_WIDTH];
}

#pragma mark - private
///筛选
- (IBAction)didClickChooseBtn:(id)sender {
    WEAKSELF
    GoodsCommonChooseView *chooseView =  [[GoodsCommonChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    chooseView.chooseSureBlock = ^(NSString *typeStr){
        LOG(@"选择之后回调");
        [weakSelf getGoodsCommonList:0 withcommonType:typeStr];
    };
    [chooseView show];
}


@end
