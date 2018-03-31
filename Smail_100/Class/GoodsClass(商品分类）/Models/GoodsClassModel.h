//
//  GoodsClassModel.h
//  MyCityProject
//
//  Created by Faker on 17/6/14.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsScreenmodel.h"

@interface Banners :NSObject
@property (nonatomic , copy) NSString              * goods_id;
@property (nonatomic , copy) NSString              * pict_url;
@property (nonatomic , copy) NSString              * click_type;
@property (nonatomic , copy) NSString              * category_id;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * url;

@end

@interface LeftCategory :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * logo;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * type;

@property (nonatomic, assign) BOOL select;

@end

@interface RightCategory :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * logo;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * type;


@end

@interface GoodsClassModel : NSObject

//@property (nonatomic, copy)  NSString *id;
//@property (nonatomic, copy)  NSString *name;
//@property (nonatomic, copy)  NSString *logo;
//
//
//@property (nonatomic, assign) BOOL select;
//
//@property (nonatomic , strong) NSArray<Values *>              * values;
@property (nonatomic , copy) NSArray<Banners *>              * banners;
@property (nonatomic , copy) NSArray<LeftCategory *>              * leftCategory;
@property (nonatomic , copy) NSArray<RightCategory *>              * rightCategory;

@end
