//
//  XMPushManager.m
//  XiaoMai
//
//  Created by chenzb on 15/9/1.
//  Copyright (c) 2015年 Jeanne. All rights reserved.
//

#import "XSPushManager.h"
#import "XSSpecialDetailVC.h"
#import "XSMyCouponListVC.h"
#import "XSMyFavoriteVC.h"
#import "XSCommissionSaleListVC.h"
#import "SPHHomeWhiteGlovesView.h"
#import "XSCertifiedVC.h"
#import "XSWareListVC.h"
#import "XSWareDetailVC.h"
#import "XSFilterVC.h"
#import "XSGoodsVC.h"
#import "XSHotActivityOrTopic.h"
#import "XSOrdinaryPublishVC.h"
#import "XSInvitationVC.h"
#import "MainAllLikeViewController.h"
#import "XSMyGlovesDetailVC.h"
#import "XSGlovePublishVC.h"
#import "XSMyListVC.h"
#import "XSBrandClassVC.h"
#import "XSZoneVC.h"
#import "XSBottomMenuV.h"
#import "XSPublicActivityVC.h"
#import "XSHomeVC.h"
#import "XSHomePageVC.h"
//#import "XSHomeVC_275.h"
//#import "XSHomeVC_277.h"
#import "XSHomeVC_305.h"
//#import "XSSearchResultVC.h"
#import "XSBrandListVC.h"
#import "XSFilterResultVC.h"
#import "XSSellerGoodsManagerVC.h"
#import "XSNativeWebVC.h"
#import "XSUMFeedBackVC.h"
#import "XSAPPViewManager.h"
#import "XSQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "XSOldExchangeNewVC.h"
#import "XSTradeinViewController.h"
#import "XSTradeinDetailVC.h"
#import "XSTradeinSendBackViewController.h"
#import "XSCurrencyVC.h"
#import "XSSelectShowGoodsVC.h"
#import "XSCommentViewController.h"
#import "XSPublishShareController.h"
#import "XSMyListDetailVC.h"
#import "XSFreePublicDetailViewController.h"
#import "XSMyRevenueVC.h"
#import "XSMyScoreVC.h"
#import "XSCheckAllCommentController.h"
#import "XSReplayCommentController.h"
//#import "XSSaleView.h"
#import "XSSaleView_308.h"
#import "XSCustomCellModel.h"
#import "XSSocialNormalVC.h"
#import "XSFocusController.h"
#import "OrderEditVC.h"
#import "XSSellerOrderVC.h"
#import "XSMyPublishVC_V230.h"
#import "XSFreePublishVC_322.h"
#import "XSSellerHotActivityVC.h"
#import "XSSellerActivityDetailVC.h"
#import "XSSellerActivityPublishVC.h"
#import "XSSellerActivityManagerVC.h"
#import "XSZCTool.h"
#import "XSMyCouponCenterVC.h"
#import "XSCommissionSaleDetailVC.h"
#import "XSCSaleManagerVC.h"
#import "XSSellerGoodsManagerVC.h"
#import "XSCommissionSalePublishVC.h"
#import "XSSelectAddressVC.h"
#import "XSRepayVC.h"
#import "XSMyAttentionViewController.h"
#import "XSMyActivitySignupVC.h"
#import "XSRentSearchResultController.h"
#import "XSCommunityCircleMainViewController.h"
#import "XSCommunityBuyerShowListViewController.h"
#import "XSRentHomeVC.h"
#import "XSCommunityHBGoodDetailViewController.h"
#import "XSCommunityGoodPublishPrefaceViewController.h"
#import "XSCommunityMyGiveListViewController.h"
#import "XSCommunityMyReceiveListViewController.h"
#import "XSCommunityMyMainViewController.h"
#import "XSCommunityOtherMainViewController.h"
#import "XSRentOrderDetailController.h"
#import "XSRentDetailVC.h"
#import "XSLineOfCreditVC.h"
#import "XSExpressInfoVC.h"
#import "XSForumFilterResultVC.h"
#import "XSForumViewController.h"
#import "XSEditUserInfoVC_306.h"
#import "XSC2CPublishVC_330.h"
#import "XSRentBuyoutOrderViewController.h"
#import "XSRentFriendHelpListVC.h"
#import "XSRentFriendHelpVC.h"
#import "XSMessageManagerVC.h"
#import "XSRentOrderListController.h"
#import "XSMyBehaviorVC.h"
#import "XSCommissionSaleAddProductVC.h"
#import "XSMyDessertViewController.h"
#import "XSConstantKeysConfiguration.h"
#import "XSC2CSnatchListVC.h"
#import "XSMyListDetailVC.h"

/** 反馈 */
//#import <BCHybridWebViewFMWK/BCHybridWebView.h>
//#import <YWFeedbackFMWK/YWFeedbackKit.h>
//#import <YWFeedbackFMWK/YWFeedbackViewController.h>
//#import <UTMini/AppMonitor.h>

//#import "EMCDDeviceManager.h"
//#import "EMCDDeviceManagerDelegate.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>

@interface XSPushManager ()

//@property (nonatomic, strong)YWFeedbackKit    *feedbackKit;

@end

@implementation XSPushManager

+ (XSPushManager *)sharedPushManager {
    static XSPushManager *_sharedPushManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPushManager = [[XSPushManager alloc] init];
    });
    return _sharedPushManager;
}

//- (void)pushVCbyURLInAppProtocal:(Protocal *)protocal_{
//
//    [XSAnalysisManager SensorsAnalyticsModelClickWithScreenName:nil
//                                                          advId:protocal_.advId
//                                                     positionId:protocal_.positionId];
//
//    if (protocal_.linkUrl.length > 0) {
//
//        [self pushVCbyURLInApp:protocal_.linkUrl];
//    }
//}

- (void)pushVCbyURLInApp:(NSString *)urlStr_ {

    NSLog(@"======= 跳转协议 =======\n=======%@",urlStr_);
    NSURL *openURL = [NSURL URLWithString:[urlStr_ trimedStr]];//stringByAddingPercentEscapesUsingEncoding:
    NSArray *sphSchemes = [[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"] firstObject] objectForKey:@"CFBundleURLSchemes"];//lastObject为应用内定义，如果添加URLTypes请注意顺序
    
    BOOL isSPHScheme = NO;
    NSString *openURLScheme = [[openURL scheme] lowercaseString];
    if (openURLScheme.length > 0) {
        for (NSString *aScheme in sphSchemes) {
            if ([openURLScheme isEqualToString:[aScheme lowercaseString]] || [openURLScheme isEqualToString:@"sph"]) {
                isSPHScheme = YES;
                break;
            }
        }
    }
    
    if (isSPHScheme) {
        NSMutableDictionary *dataParams = [XSTools processQueryFromString:urlStr_];
        if ([dataParams count] > 0) {
            NSString *targetLocation = [dataParams objectForKey:K_KEY_COMEFROM_OUT_TO_LOCATION];
            if (targetLocation.length > 0) {
                
                //todo
            }
        }
    }
}

- (void)isNeedLoginString:(NSString *) isNeedLogin isLoginSuccess:(void (^) (id code)) loginSuccess andLoginFail:(void (^) (id code)) loginFail
{
    NSString *isNeedLogStr = [isNeedLogin lowercaseString];
    if ([isNeedLogStr isEqualToString:@"true"] || [isNeedLogStr isEqualToString:@"yes"]) {
        [[XSAccountManager sharedAccountManager] accountLoginWithSource:XSAccountLoginSourceAccount sourceController:[XSTools getCurrentLastVC] openType:XSAccountLoginOpenPopup needLogin:YES success:loginSuccess fail:loginFail];
        
    }else{
        if(loginSuccess){
            loginSuccess(nil);
        }
    }
}

//- (YWFeedbackKit *)feedbackKit {
//    if (!_feedbackKit) {
//        _feedbackKit = [[YWFeedbackKit alloc] initWithAppKey:@"23466410"];
//    }
//    return _feedbackKit;
//}
//
//- (void)actionOpenFeedback{
//    /** 设置App自定义扩展反馈数据 */
//    NSString *tempmuid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    self.feedbackKit.extInfo = @{@"channel":@"iOS",
//                                 @"market":@"appStore",
//                                 @"deviceToken":tempmuid,
//                                 @"deviceType":[UIDevice currentDevice].model,
//                                 @"machineType":[[UIDevice currentDevice] deviceModel],
//                                 @"appId":K_APP_BUNDLEID,
//                                 @"appVersion":K_CLIENT_VERSION,
//                                 @"jpushId":[JPUSHService registrationID]?:@"",
//                                 @"mobile":[XSAccountManager getUserInfo].mobile?:@"",
//                                 @"osVersion":[UIDevice currentDevice].systemVersion};
//    //__weak typeof(self) weakSelf = self;
//    [self.feedbackKit makeFeedbackViewControllerWithCompletionBlock:^(YWFeedbackViewController *viewController, NSError *error) {
//        if (viewController != nil) {
//            viewController.title = @"意见反馈";
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
//            [APP_DELEGATE.mNavigationController presentViewController:nav animated:YES completion:nil];
//
//            [viewController setCloseBlock:^(UIViewController *aParentController){
//                [aParentController dismissViewControllerAnimated:YES completion:nil];
//            }];
//
//        }else {
//            /** 使用自定义的方式抛出error时，此部分可以注释掉 */
//            NSString *title = [error.userInfo objectForKey:@"msg"]?:@"接口调用失败，请保持网络通畅！";
//            XS_APP_TOAST(title)
//        }
//    }];
//}

@end
