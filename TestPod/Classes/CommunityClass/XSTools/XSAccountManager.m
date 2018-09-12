//
//  XMAccountManager.m
//  XiaoMai
//
//  Created by chenzb on 15/6/25.
//  Copyright (c) 2015年 Jeanne. All rights reserved.
//


#import "XSAccountManager.h"
#import "NTESFileLocationHelper.h"
#import "NTalker.h"

@interface XSAccountManager ()

@property (nonatomic, assign)XSAccountLoginSource    mSource;
@property (nonatomic, assign)UIViewController        *mSourceController;//进入的页面
@property (nonatomic, assign)UIViewController        *mEndController;//最后离开的页面

//统一的登陆注册
@property (nonatomic, strong)NSString                *mUserName;
@property (nonatomic, strong)NSString                *mPassWord;

@property (nonatomic, assign)NSInteger               mHXIndex;//限制环信登录5次
@property (nonatomic, assign)BOOL                    mHXLock;
@property (nonatomic, assign)NSInteger               mGetInfoIndex;//当自己后台登录成功，环信id限制获取信息5次
@end

@implementation XSAccountManager

+ (XSAccountManager *)sharedAccountManager {
    static XSAccountManager *_sharedAccountManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAccountManager = [[XSAccountManager alloc] init];
    });
    return _sharedAccountManager;
}
#pragma mark----------判断是否登陆和取存用户基本信息----------
+ (BOOL)accountIsOnline {
    return ([XSAccountManager getUserInfo].sessionId && [XSAccountManager getUserInfo].sessionId.length > 0)?YES:NO;
}

+ (UserInfo *)getUserInfo  {
    UserInfo  *userInfo = [[XSCacheManager shareCacheManager] getClassCache:K_USER_INFORMATION];
    if (!userInfo) {
        userInfo = [[UserInfo alloc] init];
    }
    return userInfo;
}

+ (void)saveUserInfo:(UserInfo *)userInfo_ {
    [[XSCacheManager shareCacheManager] saveClassCache:userInfo_ key:K_USER_INFORMATION];
}

#pragma mark----------登陆注册模块----------
- (void)accountLoginWithSource:(XSAccountLoginSource)source_
             sourceController:(UIViewController *)sourceController_
                     openType:(XSAccountLoginOpenType)openType_
                    needLogin:(BOOL)flag_
                      success:(LoginSuccess)loginSuccess_
                         fail:(LoginFail)loginfail_ {
    
    self.mSourceController = sourceController_;
    self.mSuccess = loginSuccess_;
    self.mFail = loginfail_;
    self.mOpenType = openType_;
    //判断是否登陆
    if ([XSAccountManager accountIsOnline] || !flag_) {
        self.mOpenType = XSAccountLoginOpenNormal;
        self.mSuccess(nil);
        return;
    }
    
    XSLoginVC *loginVC = [[XSLoginVC alloc] initCustomVCType:LCCustomBaseVCTypeNormal];
    [XSAccountManager sharedAccountManager].mLoginViewIsOpen = YES;
    
    if (self.mOpenType == XSAccountLoginOpenNormal) {
        [XSTools pushController:loginVC animated:YES];
    }else if (self.mOpenType == XSAccountLoginOpenPopup) {
        [[XSNavigationProcessC sharedXMNavigationProcessC] initProcessRootViewController:loginVC completeProcess:^{}];
        [[XSNavigationProcessC sharedXMNavigationProcessC] animation:XSNavigationProcessCTypeShow completion:^(BOOL finished) {
            
            
            [UIView animateWithDuration:0.2 animations:^{
                loginVC.mContentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
            }];
            
        }];
    }
}

+ (void)loginNTalker{
    
    /**
     *  用户登录时调用此方法
     *  @param userid ： 登录用户的ID，小能识别用户身份唯一识别，不能重复，即不能传固定值！
     * 传值需要符合小能的传值规则 ：数字、英文字母和“@”、“.”、“_”三种字符。长度小于40,并且不能重复。
     【登录用户必传】来源：集成方传入，小能负责展示
     *  @param username  ：用户登录名称，显示于PC客服端。
     * 传值需要符合小能的传值规则：字母、汉字、数字、_、@、.的字符串，长度小于32。
     * 若用户游客身份则传入空字符串 ，系统随机会生成一个用户名, 如:“客人9527 ”。
     * 来源：集成方传入，小能负责展示
     *  @param userLevel :登录用户的等级，1/0   0:普通用户  1：VIP用户 【必填】
     * 来源：集成方传入，小能负责展示
     *
     *  @return 参数判断的返回值,0为参数正确
     */
    
    UserInfo *info = [XSAccountManager getUserInfo];
    [[NTalker standardIntegration] loginWithUserid:ToString(@"%d", info.userId)
                                       andUsername:info.nickName?:@""
                                      andUserLevel:0];
    
}

- (void)loginHX{
    
    //判断当前的登录状态
    BOOL loginState = [[[NIMSDK sharedSDK] loginManager] isLogined];
    if (!loginState &&
        [XSAccountManager getUserInfo].easemobId.length > 0 &&
        [XSAccountManager getUserInfo].easemobPwd.length > 0 &&
        !self.mHXLock) {
        self.mHXLock = YES;
        __weak __typeof(self)weakSelf = self;//@"testXinshang" @"sph123"
        [[[NIMSDK sharedSDK] loginManager] login:[XSAccountManager getUserInfo].easemobId
                                           token:[XSAccountManager getUserInfo].easemobPwd
                                      completion:^(NSError *error) {
                                          weakSelf.mHXLock = NO;
                                          if (error == nil) {
                                              
                                              [[NSNotificationCenter defaultCenter] postNotificationName:K_HX_ISPOP object:@YES];
                                              [weakSelf updateIMInfo];
                                              
                                          } else {
                                              /* 登录失败情况下进入聊天，循环登录失败退出 */
                                              [[NSNotificationCenter defaultCenter] postNotificationName:K_HX_ISPOP object:@NO];
                                              /* 登录失败统计 */
                                              NSDictionary *errorDict = @{@"errorCode":[NSString stringWithFormat:@"%ld",error.code],@"errorDes":error.domain?:@"",@"easemobId":[XSAccountManager getUserInfo].easemobId,@"easemobPwd":[XSAccountManager getUserInfo].easemobPwd};
                                              [MobClick event:@"nimError" attributes:errorDict];
                                              
                                              if (error.code == 302 || error.code == 404) {//登陆失败
                                                  XS_APP_TOAST(@"帐号或密码错误")
                                              } else if (error.code == 422){//账号被封禁
                                                  XS_APP_TOAST(@"您账号被限制，无法继续操作")
                                              } else {//未知原因，挤爆了
                                                  XS_APP_TOAST(@"人太多被挤爆啦，重新登录一下吧")
                                              }
                                          }
                                      }];
    }
    
}

- (void)updateIMInfo{
    __weak __typeof(self)weakSelf = self;
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[XSAccountManager getUserInfo].headImg] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        [weakSelf uploadImage:image];
        
    }];
}

- (void)uploadImage:(UIImage *)image{
    //UIImage *imageForAvatarUpload = [image imageForAvatarUpload];
    NSString *fileName = [NTESFileLocationHelper genFilenameWithExt:@"jpg"];
    NSString *filePath = [[NTESFileLocationHelper getAppDocumentPath] stringByAppendingPathComponent:fileName];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    BOOL success = data && [data writeToFile:filePath atomically:YES];
    __weak typeof(self) wself = self;
    if (success) {
        [[NIMSDK sharedSDK].resourceManager upload:filePath progress:nil completion:^(NSString *urlString, NSError *error) {
            if (!error && wself) {
                [[NIMSDK sharedSDK].userManager updateMyUserInfo:@{@(NIMUserInfoUpdateTagAvatar):urlString, @(NIMUserInfoUpdateTagNick):[XSAccountManager getUserInfo].nickName} completion:^(NSError *error) {
                    if (!error) {
                        [[SDWebImageManager sharedManager] saveImageToCache:image forURL:[NSURL URLWithString:urlString]];
                        
                    }else{
                        NSLog(@"设置头像失败，请重试");
                    }
                }];
            }else{
                NSLog(@"图片上传失败，请重试");
            }
        }];
    }else{
        NSLog(@"图片保存失败，请重试");
    }
}


#pragma mark----------登陆或者注册同意请求randomId和请求token和userInfo接口的逻辑
- (void)completionAccountEnterProcess:(BOOL)isLogin_ endViewController:(UIViewController *)endViewController_ userName:(NSString *)userName_ password:(NSString *)password_ sendCode:(NSString *)sendCode_{
    
    [XSTools showLoadingVOnTargetView:APP_DELEGATE.mWindow isLock:YES animation:YES];
    
    self.mUserName = userName_;
    self.mPassWord = password_;
    self.mEndController = endViewController_;
//    if (isLogin_) {
//        [UserXMConnectionFuction getLoginRandomIdDelegate:self allowCancel:YES finishSelector:@selector(requestRandomIdFinsh:) failSelector:@selector(requestFailed:) timeOutSelector:@selector(requestTimeOut:)];
//    }else{
//        [UserXMConnectionFuction registered_Phone:self.mUserName password:self.mPassWord sendCode:sendCode_ unionId:self.mUnionId delegate:self allowCancel:NO finishSelector:@selector(requestRandomIdFinsh:) failSelector:@selector(requestFailed:) timeOutSelector:@selector(requestTimeOut:)];
//    }
}
//RandomId 获取成功
- (void)requestRandomIdFinsh:(RKMappingResult *)data_ {
    LCAPIResult *result = data_.firstObject;
    if ([XSTools isAPIJsonError:result]) {
        [self.mEndController.view makeToast:result.msg duration:2.0 position:@"custom"];
        return;
    }
//    LoginGetId *temp = [result.data.modelList objectAtIndex:0];
//    XSMyData *myData = [XSAccountManager getXMMyData];
//    [myData setMRandomId:temp.randomId];
//    [XSAccountManager saveXMMyData:myData];
//    myData = nil;
//    
//    [UserXMConnectionFuction getLoginUserInfo_Phone:self.mUserName password:self.mPassWord delegate:self allowCancel:YES finishSelector:@selector(requestInfoFinsh:) failSelector:@selector(requestFailed:) timeOutSelector:@selector(requestTimeOut:)];
}
//获取用户信息成功
- (void)requestInfoFinsh:(RKMappingResult *)data_ {
    [XSTools hideLoadingVOnTargetView:APP_DELEGATE.mWindow animation:YES];
    LCAPIResult *result = data_.firstObject;
    if ([XSTools isAPIJsonError:result]) {
        [APP_DELEGATE.mWindow makeToast:result.msg duration:2.0 position:@"custom"];
        return;
    }
//    LoginGetToken *loginToken = [result.data.modelList objectAtIndex:0];
//     XMMyData *myData = [XMAccountManager getXMMyData];
//    [myData setMToken:loginToken.token];
//    myData.mUserInfo =loginToken.userInfo;
//    [XMAccountManager saveXMMyData:myData];
//    myData = nil;
    
    self.mUserName = nil;
    self.mPassWord = nil;
    self.mSuccess(0);
//    XMHomePageVC *homePage = [[LTools getBottomMenuV] checkRootControllerIsAlreadyHave:XMBottomMenuVTypeHomePage];
//    if (homePage) {
//        homePage.mIsNeedReflush = YES;
//    }
//    homePage = nil;
//    [self popToXMMyVC];
    self.mOpenType = XSAccountLoginOpenNormal;
//    if (loginToken) {
//         [self registerPushDeviceToken];
//    }
   
}
- (void)requestFailed:(NSError *)error_ {
    [XSTools hideLoadingVOnTargetView:APP_DELEGATE.mWindow animation:YES];
    XS_APP_TOAST(K_NETWORKlINK_FAIL)
}

- (void)requestTimeOut:(NSError *)error_ {
    [XSTools hideLoadingVOnTargetView:APP_DELEGATE.mWindow animation:YES];
    XS_APP_TOAST(K_NETWORKLINK_TIMEOUT)
}
#pragma mark----------退出登陆，删除用户信息 -------------
+ (void)exitAccount {
    
    [XSAccountManager requestForQuit];//退出登录请求
    
    [XSAccountManager quitHX];//退出环信
    [[XSCacheManager shareCacheManager] removeObjectForKey:K_USER_INFORMATION];
    
    [[NTalker standardIntegration] logout];//小能退出

    [[XSCertifiedManager sharedDefault] removeAllData];//移除商家认证信息
    
    [[XSCacheManager shareCacheManager] removeObjectForKey:FANS_LIST_CACHE];
    [[XSCacheManager shareCacheManager] removeObjectForKey:LOVEZAN_LIST_CACHE];


    [[XSLikeArrayManager sharedManager] clearAllLikeProduct];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:K_HOME_CARE_KEY];
    [[NSNotificationCenter defaultCenter]postNotificationName:K_REFRESH_CARE_KEY object:nil];
    [[XSAddressCacheManager shardDefaultManager] removeAllAddress];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:K_HXLOGIN_STATE];
    
    [[XSCacheManager shareCacheManager] removeObjectForKey:K_MY_LIST_DATA];//我买到的
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"agreeBtnBool"];//寄卖协议
    
    [[XSHXUnreadMessageMananger shardDefaultManager] clearUnreadXSMessageCountWithMessageType:UnReadMessage_SYS_HX_Type];
    //bar 显示
    [[XSTools getBottomMenuV] reSetBottomMenuButtonState:XSBottomMenuVTypeMessage cornerState:NO and:0];
    [[XSTools getBottomMenuV] reSetBottomMenuButtonState:XSBottomMenuVTypeMy cornerState:YES];

    //退出登录
    //BOOL isReal;
    //[[SensorsAnalyticsSDK sharedInstance] identify:[SensorsAnalyticsSDK getUniqueHardwareId:&isReal]];
    [[SensorsAnalyticsSDK sharedInstance] logout];
    
    // 更新购物车数量(归零)
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:@"CartNum"];
    
    //我的页面 点击卖家切换
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isSellerPage"];
    
    // 更新品牌关注状态
    NSPOSTNotification(K_Refreshcategory_Key, nil);
    
    //我的页面 切换买家卖家红点展示
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isShowed"];
    
    //新用户第一次登录时间
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:NEWUSER_LOGIN_TIME];
    
    // 保存用户登录历史
//    [[NSUserDefaults standardUserDefaults] setObject:Login_History forKey:Login_History];

    
    //本地查看福利有没有点击
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isClickBenefitBtn"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isFirstUser"];
    

    NSPOSTNotification(K_LOGIN_SUCCESS, @"fail");
}


+ (void)quitHX{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:K_HXLOGIN_STATE];
    [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error) {
        
    }];
    [[XSHXUnreadMessageMananger shardDefaultManager] clearUnreadXSMessageCountWithMessageType:UnReadMessage_SYS_HX_Type];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}
#pragma mark----------服务器更新用户信息----------
- (void)getLastUserInfoByNet {
//    [UserXMConnectionFuction upDataUserInfoDelegate:self allowCancel:NO finishSelector:@selector(updataUserInfoFinish:) failSelector:nil  timeOutSelector:nil];
}
- (void)updataUserInfoFinish:(RKMappingResult *)data_ {
//    LCAPIResult *result = data_.firstObject;
//    if ([LTools isAPIJsonError:result]) {
//        return;
//    }
//    XMMyData *myData =  [XMAccountManager getXMMyData];
//    myData.mUserInfo =[result.data.modelList objectAtIndex:0];
//    [XMAccountManager saveXMMyData:myData];
//    myData = nil;
}
#pragma mark----------登陆/注册 更新推送信息----------

- (void)registerPushDeviceToken {
//    [RegisterPushXMContentionFuction registerPushDeviceToken:[LTools getObjectFromSystemKey:K_KEY_DEVICE_TOKEN]
//                                                 mobilePhone:[XMAccountManager getXMMyData].mUserInfo.phone
//                                                    delegate:nil
//                                                 allowCancel:NO
//                                              finishSelector:@selector(registerPushDeviceToken:)
//                                                failSelector:nil
//                                             timeOutSelector:nil];
}

- (void)registerPushDeviceToken:(RKMappingResult *)result_ {
//    if (![LTools isAPIJsonError:result_.firstObject]) {
//        [[XMCacheManager shareCacheManager] saveObjectCache:@"OK" key:K_KEY_REGISTER_ALREADY];
//    } else {
//        [[XMCacheManager shareCacheManager] saveObjectCache:@"NO" key:K_KEY_REGISTER_ALREADY];
//    }
}

#pragma mark-------操作完成之后，pop回到用户中心的页面

- (void)popToXMMyVC {
//    if (self.mOpenType == XMAccountLoginOpenNormal) {
//        [APP_DELEGATE.mNavigationController popToViewController:self.mSourceController animated:YES];
//    }else if (self.mOpenType == XMAccountLoginOpenPopup) {
//        [[XMNavigationProcessC sharedXMNavigationProcessC] animation:XMNavigationProcessCTypeDisappear beforeCompletion:^{
//            if ([self.mSourceController isKindOfClass:[XMMyVC class]]) {
//                [(XMMyVC *)self.mSourceController viewWillAppear:YES];
//            }
//            self.mOpenType = XMAccountLoginOpenNormal;
//        }];
//    }
}

#pragma mark -----------------退出登录的网络请求-------------------------
+(void)requestForQuit
{
    [UserConnection logOutDelegate:self allowCancel:NO finishSelector:nil failSelector:nil timeOutSelector:nil];
}

#pragma mark --------- 重新获取用户信息 -----------
- (void)reQuestUserInfo{
    if (self.mGetInfoIndex < 3) {
        [UserConnection getUserInfoDelegate:self allowCancel:NO finishSelector:nil failSelector:nil timeOutSelector:nil];
        self.mGetInfoIndex ++;
    }
}
- (void)modelRequestFinished:(RKMappingResult *)_result {
    if ([XSTools isAPIJsonError:_result.firstObject]) {
        [APP_DELEGATE.mWindow makeToast:((LCAPIResult *)_result.firstObject).msg duration:2.0 position:@"custom"];
        return;
    }
    UserInfo *_userInfo = [((LCAPIResult *)_result.firstObject).data.modelList modelLastObject];
    
    UserInfo *tempUserInfo = [XSAccountManager getUserInfo];
    tempUserInfo.easemobId = _userInfo.easemobId;
    tempUserInfo.easemobPwd = _userInfo.easemobPwd;
    [XSAccountManager saveUserInfo:tempUserInfo];
    
    [self loginHX];
}

- (void)modelRequestFailed:(NSError *)_error {
    [XSTools cancelUnfinishedRequest];
}

- (void)modelRequestTimeOut:(NSError *)_error {
    [XSTools cancelUnfinishedRequest];
}


@end
