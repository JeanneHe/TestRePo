//
//  XMBottomMenuV.h
//  XiaoMai
//
//  Created by Jeanne on 15/5/11.
//  Copyright (c) 2015年 Jeanne. All rights reserved.
//

#import <UIKit/UIKit.h>
#define K_XMBOTTOMMENUV_HEIGHT (iPhoneX ? 34 + 49 : 49) //49

typedef NS_ENUM(NSInteger, XSBottomMenuVRootType) {
    XSBottomMenuVTypeHomePage = 0,
    XSBottomMenuVTypeIdle = 1,
    XSBottomMenuVTypeSell = 2,
    XSBottomMenuVTypeMessage = 3,
    XSBottomMenuVTypeMy = 4
};

typedef NS_ENUM(NSInteger, XSBottomMenuImageType) {
    XSBottomMenuImageTypeNomal = 0,
    XSBottomMenuImageTypeSpecail = 1,
};

@protocol XMBottomMenuVDelegate
@optional
- (void)bottomVDelegateButtonPressed:(XSBottomMenuVRootType)type_ controller:(id)controller_;
@end

@interface XSBottomMenuV : UIView

@property (nonatomic, assign)id<XMBottomMenuVDelegate>   mBottomMenuVDelegate;

/** 是否开启了热点、电话、导航...页面下移 */
@property (nonatomic, assign)BOOL                        mIsShowWifi;

/**
 *  初始化Initializer
 */
+ (XSBottomMenuV *)sharedBottomMenuV;

/**
 *  初始化 Designated Initializer
 */
- (instancetype)initBottomMenuV;

/**
 *  检测缓存root类
 *  @param type_            root类型
 */
- (instancetype)checkRootControllerIsAlreadyHave:(XSBottomMenuVRootType)type_;

/**
 *  检测缓存root类如果没有则创建
 *  @param type_            root类型
 */
- (id)getRootControllerAndCreat:(XSBottomMenuVRootType)type_;

/**
 *  选择页面
 *  @param type_            root类型
 */
- (void)bottomVSelected:(XSBottomMenuVRootType)type_ animation:(BOOL)animation_;

/**
 *  设置下方menu是否有红点
 *  @param index_            索引
 *  @param state_            状态
 */
- (void)reSetBottomMenuButtonState:(XSBottomMenuVRootType)index_ cornerState:(BOOL)state_ and:(NSUInteger )count ;

/**
 *  设置下方menu是否有红点 ****** 不携带数量 ******
 *  @param index_            索引
 *  @param state_            状态
 */
- (void)reSetBottomMenuButtonState:(XSBottomMenuVRootType)index_ cornerState:(BOOL)state_;

/**
 *  更改tabbar图片
 *  image_
 *  selectImage_       点击状态图片
 */
- (void)reSetBottomButtonImage:(NSArray *)image_ selectImage:(NSArray *)selectImage_;

/**
 *  选择type
 *  type_       XSBottomMenuVRootType
 */
- (void)setSelectedIndex:(XSBottomMenuVRootType)type_;

/**
 *  返回当前的XSBottomMenuVRootType
 */
- (XSBottomMenuVRootType)returnMenuCurrentType;

/**
 *  解决打电话，开启WIFI等页面下移问题
 */
- (void)layoutcontrollersubviews;

@end
