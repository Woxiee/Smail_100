//
//  SQActionSheetView.h
//  JHTDoctor
//
//  Created by yangsq on 2017/5/23.
//  Copyright © 2017年 yangsq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  NS_ENUM(NSInteger, CellSelectType)
{
    RadioCellSelectType,          /// 单选
    MoreCellSelectType,            /// 多选

};

@interface SQActionSheetView : UIView

@property (nonatomic, copy) void(^buttonClick)(NSInteger buttonIndex,NSString *title);

- (id)initWithTitle:(NSString *)title buttons:(NSArray <NSString *>*)buttons buttonClick:(void(^)(NSInteger buttonIndex,NSString *title))block;

- (void)showView;
/**
 *  oldSelectIndex. 记录上一次选择状态  默认为0
 */
@property (nonatomic, assign) NSInteger  oldSelectIndex;
@property (nonatomic, assign) CellSelectType selectType;
@end
