//
//  CategoryVC.m
//  MyCityProject
//
//  Created by Faker on 17/6/13.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "CategoryVC.h"
#import "MemberModel.h"
@interface CategoryVC ()

@end

@implementation CategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfiguration];
}


/// 配置基础设置
- (void)setConfiguration
{
    self.title = @"经营类目";
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BACKGROUND_COLOR;
    self.tableView.rowHeight = 44;
    [self.tableView reloadData];

}


#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.resorceArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BusiCateList *cateModel  = [self.resorceArray objectAtIndex:indexPath.row];
    cell.textLabel.text =  [NSString stringWithFormat:@"%@ %@ %@",cateModel.cateName1,cateModel.cateName2,cateModel.cateName3];
    cell.textLabel.font = Font15;
    cell.textLabel.textColor = TITLE_COLOR;
    return cell;
    
}



@end
