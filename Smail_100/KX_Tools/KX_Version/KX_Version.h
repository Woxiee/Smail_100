//
//  KX_Version.h
//  KX_Service
//
//  Created by mac on 16/11/28.
//
//版本控制类  1新特性  2版本更新

#import <Foundation/Foundation.h>

typedef enum {
    NewVersionTypeNone = 0,
    NewVersionTypeNeedUp,
    NewVersionTypeFeatures,
    
}NewVersionType;

@interface KX_Version : NSObject



+(void)kx_isNewFeaturesSuccess:(void(^)(NewVersionType newVersion))newVersion;

+(void)kx_isNewVersionSuccess:(void(^)(NewVersionType newVersion,NSString *versionStr,NSString *strakUrl ,NSString* releaseNotes))newVersion;

@end
