//
//  SelectGoodSClassVC.m
//  Smail_100
//
//  Created by ap on 2018/3/20.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SelectGoodSClassVC.h"
#import "SelectGoodsClassCell.h"
#import "GoodSDetailModel.h"

@interface SelectGoodSClassVC ()

@end

@implementation SelectGoodSClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
    [self getRequestData];
}

#pragma mark - request
- (void)getRequestData
{
    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/shop/category" andParameters:nil andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单列表 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            NSArray *dataArr = [result valueForKey:@"data"];
            NSArray *listArray  = [[NSArray alloc] init];
            if ([dataArr isKindOfClass:[NSArray class]]) {
                if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                                        listArray = [Value mj_objectArrayWithKeyValuesArray:dataArr];
//                                        if (weakSelf.page == 0) {
//                                            [weakSelf.resorceArray removeAllObjects];
//                                        }
                                        [weakSelf.resorceArray addObjectsFromArray:listArray];
                                        [weakSelf.tableView reloadData];
//                                        [weakSelf setRefreshs];
                }
            }
        }else{
            [weakSelf showHint:msg];
            
        }
        
        
    }];
    
}

#pragma mark - private
- (void)setup
{
    
}

- (void)setConfiguration
{
    
}

#pragma mark - publice


#pragma mark - set & get



#pragma mark - delegate
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resorceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    static NSString* cellID = @"ManagementCellID";
    SelectGoodsClassCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell ) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SelectGoodsClassCell" owner:nil options:nil]lastObject];
    }
   
//    MeChantOrderModel *model = self.resorceArray[indexPath.section];
//    cell.model = model;
    return cell;
    
}


@end
