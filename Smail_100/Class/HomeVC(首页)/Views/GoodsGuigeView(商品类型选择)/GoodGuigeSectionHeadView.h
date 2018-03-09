//
//  GoodGuigeSectionHeadView.h
//  SXProject
//
//  Created by Faker on 17/4/7.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodGuigeSectionHeadView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, copy) void(^didClickHeadViewBtnBlock)(NSInteger index);
@property (nonatomic, strong) NSIndexPath *indexPath;


@end
