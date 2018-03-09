//
//  GoodsScreenListModel.h
//  MyCityProject
//
//  Created by Faker on 17/5/8.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BusinessResult;
@class MainResult;
@interface GoodsScreenListModel : NSObject
///Obj(限定：新机、配构件、二手、出租整机、出租标准节共享)
@property (nonatomic , copy) NSString              * area; //area	区
@property (nonatomic , copy) NSString              * city; //市
@property (nonatomic , copy) NSString              * prov; //市


@property (nonatomic , copy) NSString              * id;   /// 商品id
@property (nonatomic , copy) NSString              * formatDouble;     /// formatDouble	商品价格
@property (nonatomic , copy) NSString              * productName;  ///商品名称
@property (nonatomic , copy) NSString              * full_path;     ///图片地址
@property (nonatomic , copy) NSString              * companyName;   /// 公司名称
@property (nonatomic , copy) NSString              * province;  /// 省份

///Obj(限定：求租整机、求租标准节共享)
@property (nonatomic , copy) NSString              * needBuyName;  //商品名称
@property (nonatomic , copy) NSString              * hopePrice;  //期望价格
@property (nonatomic , copy) NSString              * needCount;  //求租数量
@property (nonatomic , copy) NSString              * distanceTime;  //distanceTime	多久前发布(时间)


/// Obj(限定：检测吊运)
@property (nonatomic , copy) NSString              * price;  //price	服务价格
@property (nonatomic , copy) NSString              * unitName;  //  单位
@property (nonatomic , copy) NSString              * unit;  //  单位
@property (nonatomic , copy) NSString              * mainId;  //


/// Obj(限定：集采)
@property (nonatomic , copy) NSString              * buyCount;  //  已参与人数
@property (nonatomic , copy) NSString              * endTime;  //有效时间***之前
@property (nonatomic , copy) NSString              * groupBuyName;  //商品名称

///  	Obj(限定：拍卖)
@property (nonatomic , copy) NSString              * startTime;  //startTime	开拍时间
@property (nonatomic , copy) NSString              * qpPrice;  //起拍价格
@property (nonatomic , copy) NSString              * dqPrice;  //当前价格
@property (nonatomic , copy) NSString              * status;  //拍卖状态
@property (nonatomic , copy) NSString              * offerCount;  //拍卖状态



/// 收藏所用
@property (nonatomic , strong) BusinessResult              * businessResult;
@property (nonatomic , strong) MainResult              * mainResult;
@property (nonatomic , copy) NSString              * productType; /// 商品类型=1:新机。2:配构件。3:整机流转。
@property (nonatomic , copy) NSString              * busiCompName; 

@property (nonatomic , copy) NSString              * joinCount;


//// 热搜所用专属字段
@property (nonatomic , copy) NSString              * configDesc;
@property (nonatomic , copy) NSString              * configValue;


@end
