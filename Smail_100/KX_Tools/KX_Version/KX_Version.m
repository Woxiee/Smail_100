//
//  KX_Version.m
//  KX_Service
//
//  Created by mac on 16/11/28.
//
//

#import "KX_Version.h"

@interface KX_Version ()

@end

@implementation KX_Version



static  NSString * version_Key = @"KX_VersionKey";//const

+(void)kx_isNewFeaturesSuccess:(void(^)(NewVersionType newVersion))newVersion
{
    //1 得到appid
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //2 得到当前版本
    NSString *locationVersion = [infoDic valueForKey:@"CFBundleShortVersionString"];
    //3 处理新特性
    //A 得到本地的版本
    NSString *myAppVersion = [[NSUserDefaults standardUserDefaults] objectForKey:version_Key];
    if (myAppVersion == nil) {
        myAppVersion = @"0";
    }
    //B 用plist版本对比 处理事件
    if ([self comparateVersionGetGreaterCurrentVersion:locationVersion otherVersion:myAppVersion]) {
        //显示新特性的
        //保存版本
        [[NSUserDefaults standardUserDefaults]setValue:locationVersion forKey:version_Key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        newVersion(NewVersionTypeFeatures);
      
    }else{
        newVersion(NewVersionTypeNone);
    }
}


+(void)kx_isNewVersionSuccess:(void(^)(NewVersionType newVersion,NSString *versionStr,NSString *strakUrl ,NSString* releaseNotes))newVersion
{
    //    @"http://itunes.apple.com/cn/lookup?id=1223847098
    //1 得到appid
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//    NSString *appid =@"1245034886";
    NSString *appid =  @"1261714523";

    NSString *url   =  [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",appid];
    
    //2 得到当前版本
    NSString *locationVersion = [infoDic valueForKey:@"CFBundleShortVersionString"];
    
    //3 得到苹果商店的版本
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //具体实现为
        /*    trackCensoredName = "\U7b77\U9500";
         trackContentRating = "17+";
         trackId = 1160735796;
         trackName = "\U7b77\U9500";
         trackViewUrl = "https://itunes.apple.com/cn/app/kuai-xiao/id1160735796?mt=8&uo=4";
         version = "1.1";
         wrapperType = software;*/
        NSArray *arr = [responseObject objectForKey:@"results"];
        NSDictionary *dic = [arr firstObject];
        NSString *versionStr = [dic objectForKey:@"version"];
        NSString *trackViewUrl = [dic objectForKey:@"trackViewUrl"];
        NSString *releaseNotes = [dic objectForKey:@"releaseNotes"];//更新日志
        //4 对比版本处理事件
        if ([self comparateVersionGetGreaterCurrentVersion:versionStr otherVersion:locationVersion] ) {
            //有新版本
            newVersion(NewVersionTypeNeedUp,versionStr,trackViewUrl,releaseNotes);
        }else
        {
            newVersion(NewVersionTypeNone,nil,nil,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        newVersion(NewVersionTypeNone,nil,nil,nil);
    }];
}


/**
 用版本 对比 1.1.1.1 等等 都可以 如果是前者大则返回YES
 
 @return
 */
+(BOOL)comparateVersionGetGreaterCurrentVersion:(NSString *)currentVersion otherVersion:(NSString *)otherVersion
{
    int myAppIntVersion = [[currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""] intValue];
    int netIntVersion = [[otherVersion stringByReplacingOccurrencesOfString:@"." withString:@""] intValue];
    return myAppIntVersion > netIntVersion;
}


@end
