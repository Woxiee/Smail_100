//
//  KX_FKDataPickView.h
//  KX_Service
//
//  Created by kechao wu on 16/9/19.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FKPickerDelegate <NSObject>
@optional;
- (void)didCilckPickerIndex:(NSString *)str;
@end



@interface KX_FKDataPickView : UIView
@property (nonatomic, strong) NSArray *customArr;
@property (nonatomic,strong)UILabel *selectLb;
@property (nonatomic,weak)id<FKPickerDelegate>delegate;
@property (nonatomic, copy) void(^DidClickPickerCell)(NSInteger index);
-(void)show;


@end
