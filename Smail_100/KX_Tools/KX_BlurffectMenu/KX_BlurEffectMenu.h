//
//  KX_BlurEffectMenu.h
//  KX_Service
//
//  Created by Frank on 16/10/21.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,AddMenuType){
    LogNAddMenuType,                 //新增日志
    ShareAddMenuType,               //新增分享
    ApprovalMenuType,               //新增审批
    AddressNeWGroupChatType,         //新增群聊
    AddressNewCRM                    //新建CRM
    
};

@class KX_BlurEffectMenu,BlurEffectMenuItem;
@protocol BlurEffectMenuDelegate <NSObject>

//点击背景dismiss
- (void)blurEffectMenuDidTapOnBackground:(KX_BlurEffectMenu *)menu;
//点击item
- (void)blurEffectMenu:(KX_BlurEffectMenu *)menu didTapOnItem:(BlurEffectMenuItem *)item;

@end

@interface BlurEffectMenuItem : NSObject

@property (nonatomic,copy) NSString *title;//标题
@property (nonatomic,strong) UIImage *icon;//图标
@end



@interface KX_BlurEffectMenu : KX_BaseViewController
@property (nonatomic,assign) id<BlurEffectMenuDelegate>delegate;
@property (nonatomic,copy) NSArray *menuItemArr;
@property (nonatomic, assign) AddMenuType addMenuType;
//初始化
- (instancetype)initWithMenus:(NSArray *)menus WithAddMenusType:(AddMenuType)addMenuType;
@end
