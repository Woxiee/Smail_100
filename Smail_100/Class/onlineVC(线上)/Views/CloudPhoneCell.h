//
//  CloudPhoneCell.h
//  Smail_100
//
//  Created by ap on 2018/3/26.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudPhoneCell : UICollectionViewCell

@property (strong, nonatomic) void(^didClickLookInfoBlcok)();

@property (strong, nonatomic) void(^didClickConnectionBlcok)(NSString *str );


@end
