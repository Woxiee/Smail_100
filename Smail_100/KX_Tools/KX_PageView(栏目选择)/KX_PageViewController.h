//
//  ViewController.h
//  NewsDemo
//
//  Created by lizq on 16/8/8.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,IsHaveChooseBtn)
{
    HaveChooseBtnNormal,  //正常的时候的筛选按钮
    HaveChooseBtnNone,  //没有筛选按钮
    HaveChooseBtnCRMState /// CRM展示pageview栏
};

typedef void(^ClickBlock)(NSInteger index);

typedef void (^ChoosePersonBlock)(NSMutableArray* selectArray);

@interface KX_PageViewController : KX_BaseViewController
@property (nonatomic,assign) IsHaveChooseBtn isHaveChooseBtn;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, copy) ClickBlock clickBlock;
@property (nonatomic,copy) ChoosePersonBlock choosePersonBlock;
@property(nonatomic, assign) NSInteger index;
@property (nonatomic,strong)NSMutableArray * selectArray; // 选人的时候需要


//必须实现
- (NSArray <UIViewController*> *)layoutContentControllers;
-(void)handelwithBlock:(ChoosePersonBlock)block;

- (void)selectINdex:(NSInteger )index;

///定制返回
- (void)didClickBackAction;

///定制更多点击
- (void)didClickMoreAction;


@end

