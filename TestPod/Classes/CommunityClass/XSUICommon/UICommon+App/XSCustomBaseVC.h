//
//  LCCustomBaseVC.h
//  LeCai
//
//  Created by lehecaiminib on 14-12-2.
//
//

#import <UIKit/UIKit.h>
#import "XSBaseViewController.h"
#define XSCUSTOMBASEVC_ANIMATION_DURATION 0.4
#define XSCUSTOMBASEVC_ANIMATION_DELAY 0.0
#define XSCUSTOMBASEVC_TOPRIGHT_OFFSET_X 10
#define XSBOTTOMMENUV_BACKBUTTON 9999
#define XSBOTTOMMENUV_RESETTITLE_OBJECT_ID 9998

typedef NS_ENUM(NSInteger, LCCustomBaseVCType) {
    LCCustomBaseVCTypeRoot = 0,
    LCCustomBaseVCTypeNormal = 1
};
typedef NS_ENUM(NSInteger, BottomAnimationType) {
    BottomAnimationTypeShow = 0,
    BottomAnimationTypeDisappear = 1
};

@class XSBottomMenuV;
@interface XSCustomBaseVC : XSBaseViewController

@property (nonatomic, strong)UIView                  *mTopView;
@property (nonatomic, strong)UIView                  *mContentView;
@property (nonatomic, strong)UIView                  *mLineV;
@property (nonatomic, strong)UIButton                *mBackButton;//后退
@property (nonatomic, assign)CGFloat                 mBottomMenuHeight;
@property (nonatomic, assign)BOOL                    mIsControlWithContentV;
@property (nonatomic, assign)LCCustomBaseVCType      mCustomBaseType;
@property (nonatomic, assign)CGFloat                 mR_edge_Distance; //按钮的右边距，默认取XSCUSTOMBASEVC_TOPRIGHT_OFFSET_X
@property (nonatomic, assign)CGFloat                 mR_X_Distance; //右边按钮之间水平（x）间距，默认取
@property (nonatomic, assign)CGFloat                 mL_edge_Distance; //按钮的左边距，默认取XSCUSTOMBASEVC_TOPRIGHT_OFFSET_X
@property (nonatomic, assign)CGFloat                 mL_X_Distance; //左边按钮之间水平（x）间距，默认取XSCUSTOMBASEVC_TOPRIGHT_OFFSET_X


/**
 *  aop的监测回调，只能aop使用
 */
+ (void)aopFuction;


/**
 *  视图类别
 *  @param type_            root类型
 */
- (instancetype)initCustomVCType:(LCCustomBaseVCType)type_;

/**
 *  设置标题
 *  @param titleText_            title
 */
- (void)setTitle:(NSString *)titleText_;

/**
 *  重设title控件 父类默认把传进来的view对象添加在title位置
 *  @param customView_            自定义title
 */
- (void)reSetCustomTitle:(UIView *)customView_;

/**
 *  底部bottom动画
 *  @param type_            动画类型
 *  @param completion_      动画完成block
 */
- (void)animationBottomAnimation:(BottomAnimationType)type_ completion:(void (^)(BOOL finished))completion_;

/**
 *  后退
 */
- (void)backButtonPressed;

/**
 *  右上角显示的活动或功能按钮(array中传view对象)
 *  @param data_      自定义容器包含要渲染的view
 */
- (void)initTopRightV:(NSArray *)data_;

/**
 *  左上角显示的活动或功能按钮(array中传view对象)
 *  @param data_      自定义容器包含要渲染的view
 */
- (void)initTopLeftV:(NSArray *)data_;

/**
 *  设置mTopView,从新refresh mContentView的frame 调用隐藏后可自定义topview,contentview的y坐标重置为0
 *  @param hidden_  是否隐藏
 */
- (void)setTopViewHidden:(BOOL)hidden_;

/**
 *  判断页面有没有正在显示在屏幕上
 */
- (BOOL)isVisible;

- (void)setbackGroundColor:(UIColor *)color_;
@end
