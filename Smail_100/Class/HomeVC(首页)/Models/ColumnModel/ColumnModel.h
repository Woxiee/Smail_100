//
//  ColumnModel.h
//  MyCityProject
//
//  Created by Faker on 17/5/4.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColumnModel : NSObject
@property (nonatomic, strong) NSString  *iconName;
@property (nonatomic, strong) NSString  *tag;
@property (nonatomic, strong) NSString  *title;

@property (nonatomic, copy) NSString  *adShortTitle;
@property (nonatomic, copy) NSString  *adImgUrl;
@property (nonatomic, copy) NSString  *adLink; /// 第三方跳转地址

@property (nonatomic , strong) NSArray<NSString *>              * keyWordList;

@property (nonatomic, copy) NSString  *seoTitle; /// 公告标题
@property (nonatomic, copy) NSString  *articleDesc; /// 公告标题


@property (nonatomic, copy) NSString  *imgList1; ///商品图片
@property (nonatomic, copy) NSString  *cargoPriceAdv; /// 商品价格
@property (nonatomic, copy) NSString  *mainProductIdAdv; /// 商品主商品id
@property (nonatomic, copy) NSString  *mainProductNameAdv; /// 商品名称
@property (nonatomic, copy) NSString  *shortDesc; ///  商品明细标题
@property (nonatomic, copy) NSString  *salesType; /// 商品类型

@property (nonatomic, copy) NSString  *category_id; ///
@property (nonatomic, copy) NSString  *name; /// 商品类型

@end
