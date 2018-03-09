//
//  PageTableController.m
//  ScrollViewAndTableView
//
//  Created by fantasy on 16/5/14.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "PageTableController.h"

#import "GoodsDetailVC.h"
#import "LineOffGoodsCell.h"

@interface PageTableController ()

@property (strong, nonatomic) NSArray * titleArray;

@end

@implementation PageTableController
static NSString * const llineOffGoodsCell = @"LineOffGoodsCellID";


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;

    [self.tableView registerNib:[UINib nibWithNibName:@"LineOffGoodsCell" bundle:nil] forCellReuseIdentifier:llineOffGoodsCell];

}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    LineOffGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:llineOffGoodsCell];
    if (cell == nil) {
        cell = [[LineOffGoodsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:llineOffGoodsCell];
    }
    return cell;
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                 navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    //    vc.productID = model.mainResult.mainId;
    //    vc.typeStr = model.productType;
    vc.hidesBottomBarWhenPushed = YES;
    [self.superVC.navigationController pushViewController: vc animated:YES];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
  if (scrollView == self.tableView && self.tableViewDidScroll) {
    
    self.tableViewDidScroll(self.tableView.contentOffset.y);
    
  }
  
}

@end
