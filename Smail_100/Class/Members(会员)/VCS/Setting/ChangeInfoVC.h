//
//  ChangeInfoVC.h
//  MyCityProject
//
//  Created by mac_KY on 17/5/27.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger ,ChangeInfoType) {
    ChangeInfoTypeContact = 0,
    ChangeInfoTypeTel,
    ChangeInfoTypeEMeil,
    ChangeInfoTypePhone,
    ChangeInfoTypeChuanzhen,
    ChangeInfoTypeBumen,
    ChangeInfoTypeJob,
    ChangeInfoTypeQQ,
    ChangeInfoTypeAddress,
    ChangeInfoTypeCompanyName,
    ChangeInfoTypeConpanyDetal,
    ChangeInfoTypeHTTP,

};

@interface ChangeInfoVC : KX_BaseViewController

/**
 修改资料

 @param type 类型
 @param content 需要改变之前的内容
 @return 返回该对象
 */

- (instancetype) initWithType:(ChangeInfoType)type
                      content:(NSString *)content sBlock:(void(^)(NSString *content))sBlock;

@end
