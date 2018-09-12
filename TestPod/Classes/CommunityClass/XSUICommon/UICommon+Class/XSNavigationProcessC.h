//
//  XMNavigationProcessC.h
//  XiaoMai
//
//  Created by Jeanne on 15/7/10.
//  Copyright (c) 2015年 Jeanne. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  用于有动画的弹出UINavigationController，当此动画弹出的viewcontroller将自动收起
 */

typedef NS_ENUM(NSInteger, XSNavigationProcessCType) {
    XSNavigationProcessCTypeShow      = 0,
    XSNavigationProcessCTypeDisappear = 1,
    XSNavigationProcessCTypePush      = 2,
    XSNavigationProcessCTypePop       = 3,
};

typedef void(^compltePrecess)(void);
@interface XSNavigationProcessC : UINavigationController

@property (nonatomic, strong)compltePrecess mCompltePrecess;

@property (nonatomic,assign) XSNavigationProcessCType mNavigationProcessCType;

/**
 *  单例
 */
+ (XSNavigationProcessC *)sharedXMNavigationProcessC;


/**
 *  选择页面
 *  @param controller_     RootViewController
 *  @param block_          block
 */
- (void)initProcessRootViewController:(id)controller_ completeProcess:(compltePrecess)block_;

/**
 *  选择页面
 *  @param type_           动画类型
 *  @param completion_     在动画之后的block
 */
- (void)animation:(XSNavigationProcessCType)type_ completion:(void (^)(BOOL finished))completion_;

/**
 *  选择页面
 *  @param type_           动画类型
 *  @param completion_     在动画之前的block
 */
- (void)animation:(XSNavigationProcessCType)type_ beforeCompletion:(void (^)(void))completion_;

/**
 *  选择页面
 *  @param vc_             push的目标controller
 *  @param animated_       是否要动画渲染
 */
+ (void)XMPushViewController:(UIViewController *)vc_ animated:(BOOL)animated_;

/**
 *  选择页面
 *  @param animated_       是否要动画渲染
 */
+ (void)XMPopViewControllerAnimated:(BOOL)animated_;

/**
 *  选择页面
 *  @param animated_       是否要动画渲染
 */
+ (void)XMPopToRootViewControllerAnimated:(BOOL)animated_;
/**
 *  选择页面
 *  @param animated_       是否要动画渲染
 */
+ (void)XMPopToViewController:(NSString *)controller_ Animated:(BOOL)animated_;
@end
