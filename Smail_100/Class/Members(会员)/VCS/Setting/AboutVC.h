//
//  AboutVC.h
//  MyCityProject
//
//  Created by mac_KY on 17/5/26.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutVC : UIViewController

/** 必须参数 */
@property(nonatomic,strong)NSString *webUrl;

-(id)initWithWebUrl:(NSString *)url;

@end
