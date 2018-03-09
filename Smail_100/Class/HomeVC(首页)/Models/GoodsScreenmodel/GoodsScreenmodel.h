//
//  GoodsScreenmodel.h
//  MyCityProject
//
//  Created by Faker on 17/5/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Values :NSObject
@property (nonatomic , strong) NSString              * id;
@property (nonatomic , strong) NSString              * name;
@property (nonatomic, strong)   NSString                  *valueID;
@property (nonatomic, assign) BOOL isSelect;
@end



@interface ItemsTypeDetail :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) NSArray<Values *>              * values;

@end



@interface ItemsScreenModel :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * values;

@end



@interface GoodsScreenmodel :NSObject

@property (nonatomic , copy) NSString              * orderTypeDetailTitle;
@property (nonatomic , copy) NSString              * payTypeDetailTitle;
@property (nonatomic , copy) NSString              * payTypeDetailTitle1;
@property (nonatomic , copy) NSString              * payTypeDetailTitle2;  /// payTypeDetailTitle2	拍卖状态标题名称

@property (nonatomic , copy) NSString              * itemsTypeDetailTitle;
@property (nonatomic , copy) NSString              * dealTypeDetailTitle;

@property (nonatomic , copy) NSString              * dealTypeDetailTitle1;  ///开拍时间标题名称
@property (nonatomic , copy) NSString              * dealTypeDetailTitle2;  ///开拍时间标题名称


@property (nonatomic, strong) NSDictionary  *titleDic; ///为 “采集”模块定制

@property (nonatomic , strong) NSArray<ItemsTypeDetail *>              * itemsTypeDetail;
@property (nonatomic , strong) NSArray<ItemsScreenModel *>              * payTypeDetail;
@property (nonatomic , strong) NSArray<ItemsScreenModel *>              * payTypeDetail1;

@property (nonatomic , strong) NSArray<ItemsScreenModel *>              * payTypeDetail2;

@property (nonatomic , strong) NSArray<ItemsScreenModel *>              * dealTypeDetail;
@property (nonatomic , strong) NSArray<ItemsScreenModel *>              * orderTypeDetail;

@property (nonatomic , strong) NSArray<ItemsScreenModel *>              * dealTypeDetail1;
@property (nonatomic , strong) NSArray<ItemsScreenModel *>              * dealTypeDetail2;
@end


