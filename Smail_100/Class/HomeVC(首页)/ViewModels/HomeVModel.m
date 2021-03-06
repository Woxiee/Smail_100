//
//  HomeVModel.m
//  MyCityProject
//
//  Created by Faker on 17/5/4.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "HomeVModel.h"

@implementation HomeVModel
/// 轮播图
/// 轮播图
+ (void)getCycScrollParam:(id)pararm  successBlock:(void(^)(NSArray <ColumnModel *>*dataArray,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/o/o_112" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
        NSArray *dataList = [result valueForKey:@"data"][@"obj"][@"data1"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([dataList isKindOfClass:[NSArray class]]) {
            if (state == 0) {
                listArray = [ColumnModel mj_objectArrayWithKeyValuesArray:dataList];
            }
            sBlcok(listArray, YES);
            
        }else{
            sBlcok(listArray, NO);
        }
        
    }];
}

///// 首页标题栏数据
+ (void)getHomeIndexParam:(id)pararm list:(void(^)(NSArray *dataArray,BOOL isSuccess))completeBlock
{
    [BaseHttpRequest postWithUrl:@"/goods/top_category" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        NSArray *dataList = [result valueForKey:@"data"];
        NSMutableArray *listArray  = [[NSMutableArray alloc] init];
        if ([dataList isKindOfClass:[NSArray class]]) {
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                listArray = [ColumnModel mj_objectArrayWithKeyValuesArray:dataList];
            }
            completeBlock(listArray, YES);
            
        }else{
            completeBlock(listArray, NO);
        }
        
    }];
}


/// 标签栏数据
+ (void)getColumnDataList:(void(^)(NSArray <ColumnModel *>*dataArray))completeBlock;
{
    NSArray *titlesArray = @[@"新机",@"配构件",@"整机流转",@"标准节共享",@"二手设备",@"检测吊运",@"集采",@"拍卖",@"保险",@"金融"];
    NSArray *iconsArray = @[@"08@3x.png",@"07@3x.png",@"09@3x.png",@"home01@3x.png",@"02@3x.png",@"03@3x.png",@"04@3x.png",@"06@3x.png",@"00@3x.png",@"05@3x.png"];
    NSArray *tagsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"9",@"10",@"7",@"8"];
    NSMutableArray *listArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < titlesArray.count; i++) {
        ColumnModel *model  = [[ColumnModel alloc] init];
        model.title  = titlesArray[i];
        model.iconName = iconsArray[i];
        model.tag = tagsArray[i];
        [listArray addObject:model];
    }
    completeBlock(listArray);
}


/// 推荐商品
+ (void)getHomeNewsParam:(id)pararm  successBlock:(void(^)( ItemInfoList *listModel,BOOL isSuccess))sBlcok
{
    [BaseHttpRequest postWithUrl:@"/goods/getRecommand" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                NSArray  *imgList = [NSArray yy_modelArrayWithClass:[ItemInfoList class] json:result[@"itemInfoList"]];
                NSMutableArray *arr = [[NSMutableArray alloc] init];

                for (int i = 0; i<imgList.count; i++ ) {
                    ItemInfoList *model = imgList[i];
                    NSArray *listArr= result[@"itemInfoList"];
                    model.itemContent =  [ItemContentList yy_modelWithJSON:listArr[i][@"itemContentList"]];
                    [arr addObject:model.itemContent];
                }
                
                ItemInfoList *listModel = [ItemInfoList new];
                listModel.itemType = @"recommended_ware";
                listModel.itemContentList = arr;
                sBlcok(listModel,YES);

              
            }
                
//                for (ItemInfoList *model in imgList ) {
//                    model.itemContentList = [NSArray yy_modelArrayWithClass:[ItemContentList class] json:model.itemContentList];
            
        }
        
            
        else{
            sBlcok(nil,NO);
        }
        
    }];

}




/// 商品数据
+ (void)getHomGoodsParam:(id)pararm successBlock:(void(^)(NSArray <ItemContentList *>*dataArray,BOOL isSuccess))sBlcok;
{
    [BaseHttpRequest postWithUrl:@"/goods/home_index" andParameters:pararm andRequesultBlock:^(id result, NSError *error) {
        
//        NSInteger state = [[result valueForKey:@"data"][@"state"]integerValue];
//        NSDictionary *dataDic = [result valueForKey:@"data"][@"itemInfoList"];
     
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                
                NSArray  *imgList = [NSArray yy_modelArrayWithClass:[ItemInfoList class] json:result[@"itemInfoList"]];
                    for (ItemInfoList *model in imgList ) {
                        model.itemContentList = [NSArray yy_modelArrayWithClass:[ItemContentList class] json:model.itemContentList];
                    }
                
                sBlcok(imgList,YES);

            }

        }else{
            sBlcok(nil,NO);
        }
        
    }];

}


///获取热门关键搜索词
+ (void)getHotList:(void(^)(NSArray *dataArray,BOOL isSuccess))completeBlock
{
    [BaseHttpRequest postWithUrl:@"/goods/tags_keyword" andParameters:nil andRequesultBlock:^(id result, NSError *error) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                
                NSArray  *imgList = result[@"data"];
//                for (ItemInfoList *model in imgList ) {
//                    model.itemContentList = [NSArray yy_modelArrayWithClass:[ItemContentList class] json:model.itemContentList];
//                }
                
                completeBlock(imgList,YES);
                
            }
            
        }else{
            completeBlock(nil,NO);
        }
        
    }];

}



@end
