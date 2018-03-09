//
//  ShoppingCarHeaderView.m
//  ShiShi
//
//  Created by ac on 16/3/28.
//  Copyright © 2016年 fec. All rights reserved.
//

#import "ShoppingCarHeaderView.h"

@interface ShoppingCarHeaderView ()

@property(nonatomic,copy)void (^selectBlock)();
@property(nonatomic,copy)void (^delectBlock)();

@end

@implementation ShoppingCarHeaderView


-(id)initWithHeaderHadGoodsSelect:(void(^)())selectBlock delectAll:(void(^)())delectAllBlock
{
    if (self = [super init]) {
      
        _selectBlock = selectBlock;
        _delectBlock = delectAllBlock;
        self.frame = CGRectMake(0, 0, kScreenWidth, 44);
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat btnW = 33;
        UIButton *allBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, btnW, self.height)];
        [allBtn setImage:[UIImage imageNamed:@"limitbuyBack.png"] forState:UIControlStateNormal];
        [allBtn setImage:[UIImage imageNamed:@"xuanzhe2.png"] forState:UIControlStateSelected];
        [allBtn addTarget:self action:@selector(clickSelectAllGoods) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:allBtn];
        allBtn.contentMode = UIViewContentModeCenter;
       
        _allSelectbtn = allBtn;
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(allBtn.right + 5,0, 40, self.height)];
        lb.text = @"全选";
        lb.textColor = RGB(153, 153, 153);
        lb.font = KY_FONT(12);
        [self addSubview:lb];
        
        
        CGFloat delectBtnW = 20;
        UIButton *delectBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 12 - delectBtnW, (self.height - delectBtnW)/2, delectBtnW-1, delectBtnW)];
        [delectBtn setBackgroundImage:[UIImage imageNamed:@"shanchu.png"] forState:UIControlStateNormal];
        [delectBtn addTarget:self action:@selector(clickDelectAllGoods) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:delectBtn];
        
    }
    return self;
}



-(id)initWithHeaderNotGoods{
    
    if (self = [super init]) {
        //73 68  gouwuchekong@2x  37--34--90
        
        CGFloat imgW = 38,imgH = 34,font = 15;
        self.frame = CGRectMake(0, 0, kScreenWidth, 136);
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
        [self addSubview:topView];
        topView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        
        //img
        NSString *warnStr = @"购物车空空的,赶紧逛逛吧～";
        CGFloat stringWidth = [warnStr boundingRectWithSize:CGSizeMake(250, 22) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.width;
        stringWidth += 5;
        
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - imgW - stringWidth)/2, (topView.height - imgH)/2, imgW, imgH)];
        [topView addSubview:imgView];
        imgView.image = [UIImage imageNamed:@"gouwuchekong.png"];
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(imgView.right, imgView.top, stringWidth,imgH)];
        lb.font = [UIFont systemFontOfSize:font];
        lb.textAlignment = NSTextAlignmentRight;
        lb.text = warnStr;
        lb.textColor = [UIColor lightGrayColor];
        [topView addSubview:lb];
        
        //bottom
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom, kScreenWidth, self.height - topView.height)];
        [self addSubview:bottomView];
        bottomView.backgroundColor = KMAINCOLOR;
        
        UIFont *recommendFont = [UIFont systemFontOfSize:14];
        NSString *recommend = @"为你推荐";
        CGFloat recommenWidth = [recommend boundingRectWithSize:CGSizeMake(250, 22) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:recommendFont} context:nil].size.width;
        recommenWidth += 4;
        UILabel *recommendLb = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - recommenWidth)/2, 0, recommenWidth, bottomView.height)];
        recommendLb.text = recommend;
        recommendLb.textColor = [UIColor grayColor];
        recommendLb.font = recommendFont;
        [bottomView addSubview:recommendLb];
        
        //line
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, bottomView.height/2, (recommendLb.left), 1)];
        line1.backgroundColor = [UIColor lightGrayColor];
        [bottomView addSubview:line1];
        
        UIView *line2= [[UIView alloc]initWithFrame:CGRectMake(recommendLb.right, bottomView.height/2, (recommendLb.left), 1)];
        line2.backgroundColor = [UIColor lightGrayColor];;
        [bottomView addSubview:line2];
        

    }
    return self;
}


#pragma mark - Action

///删除
-(void)clickDelectAllGoods{
    if (_delectBlock) {
        _delectBlock();
    }
}

///选中全部
-(void)clickSelectAllGoods{
   
    if (_selectBlock) {
        _selectBlock();
    }
}
 

@end
