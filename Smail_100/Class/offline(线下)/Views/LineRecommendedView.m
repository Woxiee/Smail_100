//
//  LineRecommendedView.m
//  Smile_100
//
//  Created by ap on 2018/3/6.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "LineRecommendedView.h"

@interface LineRecommendedView()
@property (nonatomic, strong)  NSMutableArray *titleArr;
@property (nonatomic, strong)  NSMutableArray *imageArr;

@end


@implementation LineRecommendedView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
//        NSArray *imageArray = @[@"gerenzhongxin3@3x.png",@"gerenzhongxin4@3x.png",@"gerenzhongxin5@3x.png",@"gerenzhongxin6@3x.png",@"gerenzhongxin7@3x.png",@"gerenzhongxin8@3x.png",@"gerenzhongxin9@3x.png",@"gerenzhongxin10@3x.png",];
//        NSArray *titleArray = @[@"商城订单",@"线下订单",@"购物车",@"我的收藏",@"商家中心",@"创客微店",@"代理平台",@"我的团队"];
//        int btnW =  SCREEN_WIDTH/4;
//
//        for (int i = 0; i<imageArray.count; i++) {
//            NSInteger index = i % 4;
//            NSInteger page = i / 4;
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setFrame:CGRectMake(SCREEN_WIDTH/4*index , page*75,
//                                     btnW , 75)];
//
//            btn.tag = 100 +i;
//            [btn addTarget:self action:@selector(didClickItemsAction:) forControlEvents:UIControlEventTouchUpInside];
//            [self addSubview:btn];
//
//            UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake((btnW-25)/2, 10, 25, 25)];
//            imageView.image = [UIImage imageNamed:imageArray[i]];
//            [btn addSubview:imageView];
//
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, btn.width, 20)];
//            label.text = titleArray[i];
//            label.textAlignment = NSTextAlignmentCenter;
//            label.textColor = [UIColor blackColor];
//            label.font = Font12;
//            [btn addSubview:label];
//
//
//        }
        
        _imageArr = [[NSMutableArray alloc] init];
        
        _titleArr = [[NSMutableArray alloc] init];
        
        
    }
    return self;
}


- (void)setCatelist:(NSArray *)catelist
{
    _catelist = catelist;
    if (_imageArr.count == 0) {
        int btnW =  SCREEN_WIDTH/5;
        for (int i = 0; i<_catelist.count; i++) {
            Catelist *model = _catelist[i];
            NSInteger index = i % 5;
            NSInteger page = i / 5;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(SCREEN_WIDTH/5*index , page*btnW,
                                     btnW , btnW)];
            
            btn.tag = 100 +i;
            [btn addTarget:self action:@selector(didClickItemsAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake((btnW-38)/2, 10, 38, 38)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.pict_url] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
            [btn addSubview:imageView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+8, btn.width, 15)];
            label.text = model.title;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = TITLETEXTLOWCOLOR;
            label.font = Font12;
            [btn addSubview:label];
            [_imageArr addObject:btn];
        }
    }
    
   
}

- (void)didClickItemsAction:(UIButton *)sender
{
    Catelist *model = _catelist[sender.tag-100];

    if (_didClickItemBlock) {
        _didClickItemBlock(model);
    }
}

@end
