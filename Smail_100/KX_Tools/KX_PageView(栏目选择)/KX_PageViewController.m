//
//  ViewController.m
//  NewsDemo
//
//  Created by lizq on 16/8/8.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "KX_PageViewController.h"
#import "UIColor+hex.h"

static float const titleWidth = 80.0;
#define FKSegmentMenuVcDefaultSpace        20
@interface KX_PageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *titlesScrollView;
@property (nonatomic, strong) UIScrollView *contentsScrollView;
@property (nonatomic, strong) NSMutableArray *titlesButtonArray;
@property (nonatomic, strong) UIButton *currentTitleButton;
@property (nonatomic, strong) UILabel *selectedLabel;
@property (nonatomic, assign) BOOL isLayoutVC;


@end

@implementation KX_PageViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //1.标题占位View
    [self setTitlesView];
    //2.内容占位View
    [self setContentsView];
    //3.添加父子VC
    [self addContentControllers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.selectArray.count > 0) {
        [self.selectArray removeAllObjects];
    }

}
-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self updateSelectArray];
    if (self.choosePersonBlock != nil) {
        self.choosePersonBlock( self.selectArray);
    }
}
-(void)updateSelectArray{

}

#pragma mark 标题占位View
- (void)setTitlesView {
//    float titleViewY = self.navigationController.navigationBarHidden? 20 : 64;
    self.titlesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.titlesScrollView.backgroundColor = BACKGROUND_COLORHL;
    self.titlesScrollView.showsHorizontalScrollIndicator = NO;
    self.titlesScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.titlesScrollView];
}

#pragma mark 内容占位View
- (void)setContentsView {
    float contentViewY = CGRectGetMaxY(self.titlesScrollView.frame);
    self.contentsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, contentViewY, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.contentsScrollView.backgroundColor = [UIColor whiteColor];
    self.contentsScrollView.showsHorizontalScrollIndicator = NO;
    self.contentsScrollView.showsVerticalScrollIndicator = NO;
    self.contentsScrollView.pagingEnabled = YES;
    self.contentsScrollView.delegate = self;
    self.contentsScrollView.bounces = NO;
    [self.view addSubview:self.contentsScrollView];
}

#pragma mark 添加父子VC
- (void)addContentControllers {
    NSArray *array = [self layoutContentControllers];
    NSInteger count = array.count;
    for (NSInteger i = 0; i < count; i++) {
        UIViewController *childVC = array[i];
        [self addChildViewController:childVC];
    }
}



#pragma mark 初始化标题栏
- (void)initTitleButton {

    NSInteger count = self.childViewControllers.count;
    CGFloat  buttonWidth = 0;
    CGFloat  selectesLabelW = 0;
    

    if (self.isHaveChooseBtn == HaveChooseBtnNormal) {
        buttonWidth = 56;
        selectesLabelW = 70;
    }else{
        buttonWidth = 0;
        selectesLabelW = 0;
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(10, 20, 44, 44 );
//        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"18@3x.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(didClickBackAction) forControlEvents:UIControlEventTouchUpInside];
        [_titlesScrollView addSubview:backBtn];
        
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 20, 44, 50 );
        [rightBtn setImage:[UIImage imageNamed:@"moreOne"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(didClickMoreAction) forControlEvents:UIControlEventTouchUpInside];
        [_titlesScrollView addSubview:rightBtn];

    }
    
    
    
    float buttonW = (SCREEN_WIDTH - buttonWidth)/count;
    ///顶部 标题的间距
    CGFloat topScrollViewContentWidth = FKSegmentMenuVcDefaultSpace;
    //每个tab偏移量
    CGFloat xOffset = FKSegmentMenuVcDefaultSpace ;
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIViewController *childVC = self.childViewControllers[i];
        CGSize textSize = [childVC.title sizeWithFont:[UIFont systemFontOfSize:16]
                                constrainedToSize:CGSizeMake(SCREEN_WIDTH, CGRectGetHeight(self.titlesScrollView.frame))
                                    lineBreakMode:NSLineBreakByTruncatingTail];
        //累计每个tab文字的长度
        topScrollViewContentWidth += topScrollViewContentWidth+textSize.width+10;
        if (self.isHaveChooseBtn == HaveChooseBtnCRMState) {
            //设置按钮尺寸
            [button setFrame:CGRectMake(xOffset +SCREEN_WIDTH/4 -10,10,
                                     textSize.width+10, CGRectGetHeight(self.titlesScrollView.frame))];
        }else{
            button.frame = CGRectMake(buttonW*i, 0, buttonW, CGRectGetHeight(self.titlesScrollView.frame));

        }
        //计算下一个tab的x偏移量
        xOffset += textSize.width + FKSegmentMenuVcDefaultSpace;
        [button setTitle:childVC.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 100+i;
        [button setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        button.backgroundColor = self.titlesScrollView.backgroundColor;
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesScrollView addSubview:button];
        [self.titlesButtonArray addObject:button];
        if (i == 0) {
            [self titleButtonClick:button];
            [self updateContentViewWithIndex:i];
        }
    }
    
    _selectedLabel = [[UILabel alloc] init];
    _selectedLabel.backgroundColor = [UIColor whiteColor];
    [_titlesScrollView addSubview:_selectedLabel];
    if (self.isHaveChooseBtn == HaveChooseBtnCRMState) {
        UIButton *btn = [self.view viewWithTag:100];
        CGRect TempFrame = btn.frame;
        TempFrame.size.height = 2;
        TempFrame.origin.y = CGRectGetHeight(self.titlesScrollView.frame) -2;
        TempFrame.origin.x = FKSegmentMenuVcDefaultSpace -10 + SCREEN_WIDTH/4 ;
        _selectedLabel.frame = TempFrame;
        self.titlesScrollView.contentSize = CGSizeMake(xOffset   , CGRectGetHeight(self.titlesScrollView.frame));
    }else{
        _selectedLabel.frame = CGRectMake(0, _titlesScrollView.frame.size.height -2, (_titlesScrollView.frame.size.width - selectesLabelW)/count, 2);
        self.titlesScrollView.contentSize = CGSizeMake(xOffset , CGRectGetHeight(self.titlesScrollView.frame));
    }
    self.contentsScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*count, 0);
}


-(void)handelwithBlock:(ChoosePersonBlock)block{
    _choosePersonBlock = block;
}

#pragma mark title点击事件处理
- (void)titleButtonClick:(UIButton *)button {
    //1.改变颜色
    NSUInteger index = [self.titlesButtonArray indexOfObject:button];
    self.currentTitleButton.transform = CGAffineTransformIdentity;
    
    [self.currentTitleButton setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
    self.currentTitleButton.transform = CGAffineTransformMakeScale(1.0, 1.0);

    button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    [button setTitleColor:self.titleSelectedColor forState:UIControlStateNormal];
    [self updateTitleWithIndex:index];
    //2.添加VC
    [self updateContentViewWithIndex:index];
    self.currentTitleButton = button;
    self.index = index;
}

#pragma mark 更新title显示
- (void)updateTitleWithIndex:(NSUInteger)index  {

    UIButton *button = _titlesButtonArray[index];
    [self.currentTitleButton setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
    [button setTitleColor:self.titleSelectedColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _selectedLabel.frame;
        frame.origin.x = button.frame.origin.x;
        frame.size.width = button.frame.size.width ;
        _selectedLabel.frame = frame;
        [self viewFrameAutoWith:_selectedLabel.frame];

        }];

    self.currentTitleButton = button;
}


// titleScrollView frame自适应
- (void)viewFrameAutoWith:(CGRect)frame{
    CGRect tempFrame = frame;
    CGFloat MaxX = CGRectGetMaxX(tempFrame);
    CGFloat conteentOffX = self.titlesScrollView.contentSize.width - self.titlesScrollView.frame.size.width;
    CGFloat MinX = CGRectGetMinX(tempFrame);
    /*
    if (self.isHaveChooseBtn == HaveChooseBtnCRMState) {
        if (MaxX >= SCREEN_WIDTH - FKSegmentMenuVcDefaultSpace * 2) {
            [self.titlesScrollView setContentOffset:CGPointMake(conteentOffX, 0) animated:YES];
        }
        if (MinX - FKSegmentMenuVcDefaultSpace *2 <= conteentOffX) {
            [self.titlesScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
     */
   

    
}

-(NSMutableArray *)selectArray{

    if (_selectArray == nil) {
        _selectArray = [[NSMutableArray alloc]init];
    }
    return _selectArray;

}

#pragma mark 添加子VC
- (void)updateContentViewWithIndex:(NSUInteger)index {

    if (self.childViewControllers.count==0)  return;
    UIViewController *childVC = self.childViewControllers[index];
    
    [self.contentsScrollView setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:NO];
    if (childVC.view.superview) {
        return;
    }
    childVC.view.frame = CGRectMake(SCREEN_WIDTH *index, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentsScrollView.frame));
    [self.contentsScrollView addSubview:childVC.view];
}


///定制返回
- (void)didClickBackAction
{

}

///定制更多点击
- (void)didClickMoreAction
{
    
}


#pragma mark UIScrollView Delegate 方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSInteger leftIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
    NSInteger rightIndex = leftIndex + 1;
    if (rightIndex >= self.childViewControllers.count) {
        return;
    }

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    NSInteger page = scrollView.contentOffset.x/SCREEN_WIDTH;
    [self updateContentViewWithIndex:page];
    [self updateTitleWithIndex:page];
    [self viewFrameAutoWith:_selectedLabel.frame];
    self.index = page;

}

#pragma mark 子类重写 添加子VC
- (NSArray<UIViewController *> *)layoutContentControllers {
    return nil;
}


- (void)selectINdex:(NSInteger )index{
    [self updateContentViewWithIndex:0];
    [self updateTitleWithIndex:0];
    self.index = index;
}

#pragma mark getter or setter 

- (UIColor *)titleNormalColor {
    if (_titleNormalColor == nil) {
        _titleNormalColor = [UIColor whiteColor];
    }
    return _titleNormalColor;
}

- (UIColor *)titleSelectedColor {
    if (_titleSelectedColor == nil) {
        _titleSelectedColor = [UIColor whiteColor];
    }
    return _titleSelectedColor;
}

- (NSMutableArray *)titlesButtonArray {
    if (_titlesButtonArray == nil) {
        _titlesButtonArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _titlesButtonArray;
}

- (void)setIsHaveChooseBtn:(IsHaveChooseBtn)isHaveChooseBtn
{
    _isHaveChooseBtn = isHaveChooseBtn;
    [self initTitleButton];

}


@end
