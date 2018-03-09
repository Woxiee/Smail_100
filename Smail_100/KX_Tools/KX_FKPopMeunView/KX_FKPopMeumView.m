//
//  KX_FKPopMeumView.m
//  KX_Service
//
//  Created by Faker on 16/11/10.
//
//

#import "KX_FKPopMeumView.h"

@interface FKPopup : UIView

+ (instancetype)popupWithContentView:(UIView *)contentView;

- (void)showAtCenter:(CGPoint)center startPoint:(CGPoint)startPoin inView:(UIView *)inView animation:(BOOL)animation;

- (void)dismiss:(BOOL)animation;

@end

@interface FKPopup ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) CGPoint containerStartPoint;
@property (nonatomic, assign) BOOL dismissing;

@end

@implementation FKPopup

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor clearColor];
        
        _containerView.userInteractionEnabled = YES;
        [self addSubview:_containerView];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView* hitView = [super hitTest:point withEvent:event];
    
    if (hitView == self) {
        [self dismiss:YES];
    }
    return hitView;
}

+ (instancetype)popupWithContentView:(UIView *)contentView {
    FKPopup *popup = [[[self class] alloc] init];
    popup.contentView = contentView;
    return popup;
}

- (void)showAtCenter:(CGPoint)center startPoint:(CGPoint)startPoint inView:(UIView *)inView animation:(BOOL)animation{
    if(!self.superview){
        NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
        
        for (UIWindow *window in frontToBackWindows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                [window addSubview:self];
                break;
            }
        }
    }
    self.frame = self.window.bounds;
    
    if (self.contentView.superview) {
        [self.contentView removeFromSuperview];
    }
    [self.containerView addSubview:self.contentView];
    
    CGFloat width = CGRectGetWidth(self.contentView.frame);
    CGFloat height = CGRectGetHeight(self.contentView.frame);
    self.contentView.frame = CGRectMake(0, 0, width, height);
    
    CGPoint containerCenter = [self convertPoint:center fromView:inView];
    CGPoint containerStartPoint = [self convertPoint:startPoint fromView:inView];
    self.containerStartPoint = containerStartPoint;
    
    self.containerView.frame = CGRectMake(containerCenter.x - width / 2, containerCenter.y - height / 2, width, height);
    
    if (animation) {
        self.containerView.alpha = 0.0;
        CGRect finalContainerFrame = self.containerView.frame;
        self.containerView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.containerView.center = containerStartPoint;
        [UIView animateWithDuration:0.6
                              delay:0.0
             usingSpringWithDamping:0.8
              initialSpringVelocity:15.0
                            options:0
                         animations:^{
                             self.containerView.alpha = 1.0;
                             self.containerView.transform = CGAffineTransformIdentity;
                             self.containerView.frame = finalContainerFrame;
                         }
                         completion:nil];
    }
}

- (void)dismiss:(BOOL)animation {
    if (self.dismissing) {
        return;
    }
    self.dismissing = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        void (^completionBlock)(BOOL) = ^(BOOL finished) {
            if (finished) {
                self.dismissing = NO;
                [self removeFromSuperview];
            }
        };
        
        CGPoint finalContainerCenter = self.containerStartPoint;
        if (animation) {
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^(void){
                                 self.containerView.alpha = 0.0;
                                 self.containerView.transform = CGAffineTransformMakeScale(0.01, 0.01);
                                 self.containerView.center = finalContainerCenter;
                             }
                             completion:completionBlock];
        } else {
            self.containerView.alpha = 0.0;
            completionBlock(YES);
        }
    });
}

@end

@interface UIView (FKPopup)

- (void)dismissPresentingICDPopup;

@end

@implementation UIView (FKPopup)

- (void)dismissPresentingICDPopup {
    // Iterate over superviews until you find a ICDPopup and dismiss it, then gtfo
    UIView* view = self;
    while (view != nil) {
        if ([view isKindOfClass:[FKPopup class]]) {
            [(FKPopup*)view dismiss:NO];
            break;
        }
        view = [view superview];
    }
}

@end

@interface UIImage (ICDColor)

+ (instancetype)imageWithColor:(UIColor *)color;
+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size;

@end

@implementation UIImage (ICDColor)

+ (instancetype)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(0.5, 0.5)];
}

+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end


static const CGFloat kArrowWidth = 12;
static const CGFloat kArrowHeight = 8;
static const CGFloat kArrowTrailingSuperSpacing = 12;
static const NSUInteger kButtonTagOffset = 1000;

@interface KX_FKPopMeumView ()
@property (nonatomic, strong) UIView *arrowLayerBgView;
@property (nonatomic, strong) UIView *itemContainerView;
@property (nonatomic, copy) NSArray *btnItemArray; //array of btn

@end

@implementation KX_FKPopMeumView
#pragma mark - lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithMenuSize:(CGSize)size {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, size.width, size.height);
        [self setup];
    }
    return self;
}

#pragma mark - event method
- (void)didTapButton:(UIButton *)sender {
    NSUInteger tag = sender.tag - kButtonTagOffset;
    [self hide];
    if (self.actionHandlerBlock) {
        self.actionHandlerBlock(self, tag);
    }
}

#pragma mark - public methods
- (void)showFromNavigationBarButtonItem:(UIBarButtonItem *)barButtonItem {
    UIView *itemView = [barButtonItem valueForKey:@"view"];
    UIView *inView = itemView.window.rootViewController.view;
    
    CGPoint itemViewCenter = itemView.center;
    CGPoint startPoint = CGPointMake(itemViewCenter.x, 64);
    
    FKPopupMenuArrowPosition arrowPositon;
    if (itemViewCenter.x < CGRectGetWidth([UIScreen mainScreen].bounds)/2) {
        //LeftBarButtonItem
        arrowPositon = FKPopupMenuArrowPositionTopLeft;
    } else {
        //RightBarButtonItem
        arrowPositon = FKPopupMenuArrowPositionTopRight;
    }
    
    [self showFromStartPoint:startPoint inView:inView arrowPositon:arrowPositon];
}

- (void)showFromStartView:(UIView *)startView arrowPositon:(FKPopupMenuArrowPosition)position {
    UIView *inView = startView.superview;
    CGRect frame = startView.frame;
    CGPoint startPoint = CGPointZero;
    
    if (position == FKPopupMenuArrowPositionTopLeft || position == FKPopupMenuArrowPositionTopCenter || position == FKPopupMenuArrowPositionTopRight) {
        startPoint = CGPointMake(startView.center.x, CGRectGetMaxY(frame));
    }
    
    if (position == FKPopupMenuArrowPositionBottomLeft || position == FKPopupMenuArrowPositionBottomCenter || position == FKPopupMenuArrowPositionBottomRight) {
        startPoint = CGPointMake(startView.center.x, CGRectGetMinY(frame));
    }
    
    if (position == FKPopupMenuArrowPositionLeftTop || position == FKPopupMenuArrowPositionLeftCenter || position == FKPopupMenuArrowPositionLeftBottom) {
        startPoint = CGPointMake(CGRectGetMaxX(frame), startView.center.y);
    }
    
    if (position == FKPopupMenuArrowPositionRightTop || position == FKPopupMenuArrowPositionRightCenter || position == FKPopupMenuArrowPositionRightBottom) {
        startPoint = CGPointMake(CGRectGetMinX(frame), startView.center.y);
    }
    
    [self showFromStartPoint:startPoint inView:inView arrowPositon:position];
}


- (void)showFromStartPoint:(CGPoint)startPoint inView:(UIView *)inView arrowPositon:(FKPopupMenuArrowPosition)position
{
    CGFloat selfWidth = CGRectGetWidth(self.bounds);
    CGFloat selfHeight = CGRectGetHeight(self.bounds);
    
    CGFloat selfCenterX = 0;
    CGFloat selfCenterY = 0;
    CGRect itemContainerViewFrame = CGRectZero;
    
    if (position == FKPopupMenuArrowPositionTopLeft) {
        selfCenterX = startPoint.x - kArrowWidth / 2 - kArrowTrailingSuperSpacing + selfWidth / 2;
        selfCenterY = startPoint.y + selfHeight / 2;
        itemContainerViewFrame = CGRectMake(0, kArrowHeight, selfWidth, selfHeight - kArrowHeight);
    }
    if (position == FKPopupMenuArrowPositionTopCenter) {
        selfCenterX = startPoint.x;
        selfCenterY = startPoint.y + selfHeight / 2;
        itemContainerViewFrame = CGRectMake(0, kArrowHeight, selfWidth, selfHeight - kArrowHeight);
    }
    if (position == FKPopupMenuArrowPositionTopRight) {
        selfCenterX = startPoint.x + kArrowWidth / 2 + kArrowTrailingSuperSpacing - selfWidth / 2;
        selfCenterY = startPoint.y + selfHeight / 2;
        itemContainerViewFrame = CGRectMake(0, kArrowHeight, selfWidth, selfHeight - kArrowHeight);
    }
    
    if (position == FKPopupMenuArrowPositionBottomLeft) {
        selfCenterX = startPoint.x - kArrowWidth / 2 - kArrowTrailingSuperSpacing + selfWidth / 2;
        selfCenterY = startPoint.y - selfHeight / 2;
        itemContainerViewFrame = CGRectMake(0, 0, selfWidth, selfHeight - kArrowHeight);
    }
    if (position == FKPopupMenuArrowPositionBottomCenter) {
        selfCenterX = startPoint.x;
        selfCenterY = startPoint.y - selfHeight / 2;
        itemContainerViewFrame = CGRectMake(0, 0, selfWidth, selfHeight - kArrowHeight);
    }
    if (position == FKPopupMenuArrowPositionBottomRight) {
        selfCenterX = startPoint.x + kArrowWidth / 2 + kArrowTrailingSuperSpacing - selfWidth / 2;
        selfCenterY = startPoint.y - selfHeight / 2;
        itemContainerViewFrame = CGRectMake(0, 0, selfWidth, selfHeight - kArrowHeight);
    }
    
    if (position == FKPopupMenuArrowPositionLeftTop) {
        selfCenterX = startPoint.x + selfWidth / 2;
        selfCenterY = startPoint.y - kArrowWidth / 2 - kArrowTrailingSuperSpacing + selfHeight / 2;
        itemContainerViewFrame = CGRectMake(kArrowHeight, 0, selfWidth - kArrowHeight, selfHeight);
    }
    if (position == FKPopupMenuArrowPositionLeftCenter) {
        selfCenterX = startPoint.x + selfWidth / 2;
        selfCenterY = startPoint.y;
        itemContainerViewFrame = CGRectMake(kArrowHeight, 0, selfWidth - kArrowHeight, selfHeight);
    }
    if (position == FKPopupMenuArrowPositionLeftBottom) {
        selfCenterX = startPoint.x + selfWidth / 2;
        selfCenterY = startPoint.y + kArrowWidth / 2 + kArrowTrailingSuperSpacing - selfHeight / 2;
        itemContainerViewFrame = CGRectMake(kArrowHeight, 0, selfWidth - kArrowHeight, selfHeight);
    }
    
    if (position == FKPopupMenuArrowPositionRightTop) {
        selfCenterX = startPoint.x - selfWidth / 2;
        selfCenterY = startPoint.y - kArrowWidth / 2 - kArrowTrailingSuperSpacing + selfHeight / 2;
        itemContainerViewFrame = CGRectMake(0, 0, selfWidth - kArrowHeight, selfHeight);
    }
    if (position == FKPopupMenuArrowPositionRightCenter) {
        selfCenterX = startPoint.x - selfWidth / 2;
        selfCenterY = startPoint.y;
        itemContainerViewFrame = CGRectMake(0, 0, selfWidth - kArrowHeight, selfHeight);
    }
    if (position == FKPopupMenuArrowPositionRightBottom) {
        selfCenterX = startPoint.x - selfWidth / 2;
        selfCenterY = startPoint.y + kArrowWidth / 2 + kArrowTrailingSuperSpacing - selfHeight / 2;
        itemContainerViewFrame = CGRectMake(0, 0, selfWidth - kArrowHeight, selfHeight);
    }
    
    //layerBgView
    self.arrowLayerBgView.frame = CGRectMake(0, 0, selfWidth, selfHeight);
    //itemContainerView
    self.itemContainerView.frame = itemContainerViewFrame;
    //items
    CGFloat itemWidth = CGRectGetWidth(itemContainerViewFrame);
    CGFloat itemHeight = CGRectGetHeight(itemContainerViewFrame) / self.btnItemArray.count;
    for (NSUInteger i = 0; i < self.btnItemArray.count; i ++ ) {
        UIButton *item = self.btnItemArray[i];
        item.frame = CGRectMake(0, i * itemHeight, itemWidth, itemHeight);
    }
    
    CGRect frame = self.frame;
    frame.origin.x = selfCenterX - CGRectGetWidth(self.bounds)/2;
    frame.origin.y = selfCenterY - CGRectGetHeight(self.bounds)/2;
    self.frame = frame;
    
    FKPopup *popup = [FKPopup popupWithContentView:self];
    [popup showAtCenter:CGPointMake(selfCenterX, selfCenterY) startPoint:startPoint inView:inView animation:YES];
    
    //需要加入到popup后才能计算出三角形指示箭头的位置，此时才开始画layer
    [self addArrowLayer:startPoint inView:inView position:position];
}

#pragma mark - private methods
- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    
    _arrowLayerBgView = [[UIView alloc] init];
    _arrowLayerBgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_arrowLayerBgView];
    
    _itemContainerView = [[UIView alloc] init];
    _itemContainerView.backgroundColor = [UIColor clearColor];
    _itemContainerView.layer.cornerRadius = 5;
    _itemContainerView.layer.masksToBounds = YES;
    [self addSubview:_itemContainerView];
}

- (void)hide {
    [self dismissPresentingICDPopup];
}


- (void)addArrowLayer:(CGPoint)startPoint inView:(UIView *)inView position:(FKPopupMenuArrowPosition)position {
    startPoint = [self convertPoint:startPoint fromView:inView];
    
    CGPoint arrowTopPoint = startPoint;
    CGPoint arrowPointA = CGPointMake(arrowTopPoint.x - kArrowWidth/2, kArrowHeight);
    CGPoint arrowPointB = CGPointMake(arrowTopPoint.x + kArrowWidth/2, kArrowHeight);
    
    if (position == FKPopupMenuArrowPositionTopLeft || position == FKPopupMenuArrowPositionTopCenter || position == FKPopupMenuArrowPositionTopRight) {
        arrowPointA = CGPointMake(arrowTopPoint.x - kArrowWidth/2, arrowTopPoint.y + kArrowHeight);
        arrowPointB = CGPointMake(arrowTopPoint.x + kArrowWidth/2, arrowTopPoint.y + kArrowHeight);
    }
    
    if (position == FKPopupMenuArrowPositionBottomLeft || position == FKPopupMenuArrowPositionBottomCenter || position == FKPopupMenuArrowPositionBottomRight) {
        arrowPointA = CGPointMake(arrowTopPoint.x + kArrowWidth/2, arrowTopPoint.y - kArrowHeight);
        arrowPointB = CGPointMake(arrowTopPoint.x - kArrowWidth/2, arrowTopPoint.y - kArrowHeight);
    }
    
    if (position == FKPopupMenuArrowPositionLeftTop || position == FKPopupMenuArrowPositionLeftCenter || position == FKPopupMenuArrowPositionLeftBottom) {
        arrowPointA = CGPointMake(arrowTopPoint.x + kArrowHeight, arrowTopPoint.y + kArrowWidth / 2);
        arrowPointB = CGPointMake(arrowTopPoint.x + kArrowHeight, arrowTopPoint.y - kArrowWidth / 2);
    }
    
    if (position == FKPopupMenuArrowPositionRightTop || position == FKPopupMenuArrowPositionRightCenter || position == FKPopupMenuArrowPositionRightBottom) {
        arrowPointA = CGPointMake(arrowTopPoint.x - kArrowHeight, arrowTopPoint.y - kArrowWidth / 2);
        arrowPointB = CGPointMake(arrowTopPoint.x - kArrowHeight, arrowTopPoint.y + kArrowWidth / 2);
        
    }
    CAShapeLayer *layer = [self createArrowLayerWithArrowPointT:arrowTopPoint pointA:arrowPointA pointB:arrowPointB];
    [_arrowLayerBgView.layer addSublayer:layer];
}

- (UIButton *)createItemWithTitle:(NSString *)title imageName:(NSString *)imageName tag:(NSInteger)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor clearColor]];
//    [button setBackgroundImage:[UIImage imageWithColor:UIColorFromRGBA(0x000000, 0.9)] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
//    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 0)];
//    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 24, 0, 0)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.tag = tag;
    [button layerForViewWith:0 AndLineWidth:0.5];
    return button;
}

- (CAShapeLayer *)createArrowLayerWithArrowPointT:(CGPoint)pointT pointA:(CGPoint)pointA pointB:(CGPoint)pointB {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.itemContainerView.frame byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    [path moveToPoint:pointA];
    [path addLineToPoint:pointT];
    [path addLineToPoint:pointB];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.frame = self.bounds;
    return layer;
}

#pragma mark - setters
- (void)setItemArray:(NSArray *)itemArray {
    _itemArray = [itemArray copy];
    
    NSMutableArray *array = [NSMutableArray new];
    NSUInteger tag = kButtonTagOffset;
    for (FKPopupMenuItem *item in _itemArray) {
        UIButton *btnItem = [self createItemWithTitle:item.title imageName:item.imageName tag:tag];
        UIView *view = [self.itemContainerView viewWithTag:tag];
        if (view) {
            [view removeFromSuperview];
        }
        [self.itemContainerView addSubview:btnItem];
        [array addObject:btnItem];
        tag ++;
    }
    self.btnItemArray = [array copy];
}

@end

@implementation FKPopupMenuItem

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        _title = [title copy];
        _imageName = [imageName copy];
    }
    return self;
}

@end


