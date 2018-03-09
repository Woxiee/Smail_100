//
//  MemberModel.h
//  MyCityProject
//
//  Created by Faker on 17/5/17.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business :NSObject
@property (nonatomic , copy) NSString              * busiCompName;
@property (nonatomic , copy) NSString              * busiCompLogoUrl;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , copy) NSString              * busiCompTax;
@property (nonatomic , copy) NSString              * busiCompLogo;

@end

@interface BusiImgList :NSObject
@property (nonatomic , copy) NSString              * imgName;

@end

@interface CateImgList :NSObject
@property (nonatomic , copy) NSString              * imgName;

@end

@interface BusiCateList :NSObject
@property (nonatomic , copy) NSString              * cateName3;
@property (nonatomic , copy) NSString              * cateName1;
@property (nonatomic , copy) NSString              * cateName2;

@end

@interface MemberModel : NSObject

@property (nonatomic, strong) NSString  *className;

@property (nonatomic, strong) NSString *title;
/** 右边的标题 */
@property(nonatomic,strong)NSString *subTitle;
/** 是否显示右边的尖头 */
@property(nonatomic,assign)BOOL isShowAss;

@property (nonatomic , copy) NSString              * realmobile;
@property (nonatomic , copy) NSString              * dept;
@property (nonatomic , copy) NSString              * position;
@property (nonatomic , copy) NSString              * realemail;
@property (nonatomic , copy) NSString              * faxes;
@property (nonatomic , copy) NSString              * area;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * qq;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * telephone;


/// 供应商数据
@property (nonatomic , strong) Business              * business;
@property (nonatomic , strong) NSArray<BusiImgList *>              * busiImgList;
@property (nonatomic , strong) NSArray<CateImgList *>              * cateImgList;
@property (nonatomic , strong) NSArray<BusiCateList *>              * busiCateList;


@end
