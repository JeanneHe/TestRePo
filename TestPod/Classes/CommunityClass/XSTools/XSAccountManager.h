//
//  XMAccountManager.h
//  XiaoMai
//
//  Created by chenzb on 15/6/25.
//  Copyright (c) 2015年 Jeanne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSMyData.h"

typedef NS_ENUM (NSInteger, XSAccountLoginSource){
    XSAccountLoginSourceAccount,//我的账户
    XSAccountLoginSourcePay,//结账
    XSAccountLoginSourceBanners //活动
};

typedef NS_ENUM (NSInteger, XSAccountLoginOpenType){
    XSAccountLoginOpenNormal , //正常
    XSAccountLoginOpenPopup    //弹出
};

/* 公司账号登录 */
typedef void(^LoginSuccess)(id code);
typedef void(^LoginFail)(NSString *msg);

/* 环信登录 */
//typedef void (^HXLoginSuccess) (void);
//typedef void (^HXLoginFail) (void);

@interface XSAccountManager : NSObject
//打开方式
@property (nonatomic, assign)XSAccountLoginOpenType   mOpenType;

@property (nonatomic, strong)LoginSuccess             mSuccess;
@property (nonatomic, strong)LoginFail                mFail;
//@property (nonatomic, strong)HXLoginSuccess           mHXLoginSuccess;
//@property (nonatomic, strong)HXLoginFail              mHXLoginFail;
@property (nonatomic, assign)BOOL                     isNeedOrderListRefresh;
@property (nonatomic, assign)BOOL                     isNeedRefreshFromInApp;

//首页请求百分点数据需要特殊处理 ()
@property (nonatomic, assign)BOOL                     mIsFromHome;

/** 登录页面是否打开 */
@property (nonatomic, assign)BOOL                     mLoginViewIsOpen;

+ (XSAccountManager *)sharedAccountManager;
//判断用户是否在线
+ (BOOL)accountIsOnline;

//获取用户信息
+ (UserInfo *)getUserInfo;
+ (void)saveUserInfo:(UserInfo *)userInfo_;

//更新NIM用户信息
- (void)updateIMInfo;

//从服务器更新用户信息
- (void)getLastUserInfoByNet;

//统一的登录入口
- (void)accountLoginWithSource:(XSAccountLoginSource)source_
             sourceController:(UIViewController *)sourceController_
                      openType:(XSAccountLoginOpenType)openType_
                     needLogin:(BOOL)flag_
                      success:(LoginSuccess)loginSuccess_
                         fail:(LoginFail)loginfail_;
//环信登录
//- (void)loginHXSuccess:(HXLoginSuccess)loginSuccess_ fail:(HXLoginFail)loginFail_;
- (void)loginHX;

//小能登录
+ (void)loginNTalker;

//登陆同意的参数调用方法
- (void)completionAccountEnterProcess:(BOOL)isLogin_ endViewController:(UIViewController *)endViewController_ userName:(NSString *)userName_ password:(NSString *)password_ sendCode:(NSString *)sendCode_;

//退出登录
+ (void)exitAccount;
+ (void)quitHX;//环信


@end
