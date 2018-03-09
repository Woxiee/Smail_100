//
//  PayOtherCell.h
//  JXActionSheet
//
//  Created by ap on 2018/3/9.
//  Copyright © 2018年 JX.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayDetailModel.h"

@interface PayOtherCell : UITableViewCell

@property (nonatomic, strong) PayDetailModel *model;
@property (weak, nonatomic) IBOutlet UITextField *numberTextFied;

@end
