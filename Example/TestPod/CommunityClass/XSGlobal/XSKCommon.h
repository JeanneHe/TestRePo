//
//  KCommon.h
//
//  Created by HXG on 11-9-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// Debug 模式选项
//   SensorsAnalyticsDebugOff - （上线）关闭 Debug 模式
//   SensorsAnalyticsDebugOnly - 打开 Debug 模式，校验数据，但不进行数据导入
//   SensorsAnalyticsDebugAndTrack - （测试）打开 Debug 模式，校验数据，并将数据导入到 Sensors Analytics 中
// 注意！请不要在正式发布的 App 中使用 Debug 模式！   


/*********************!!!上线前重要提示!!!*********************
*********************
********************* 1、需要关闭神策debug模式 (上线是  SensorsAnalyticsDebugOff)
********************* 2、需要修改 K_APPUPDATE_VERSION 递增
********************* 3、需要注意 K_PACKAGE 马甲包参数 （主APP 选0）
********************* 4、需要更改 URL Schemes （马甲和主app不一样）
********************* 5、需要注释 K_DEBUG （注释掉以后就不可切环境了）
*********************
*********************!!!重要提示!!!*********************/

//打包环境
#define K_ENVIRONMENT 1

#if (K_ENVIRONMENT == 0)
//#define K_URL_HOST          @"http://192.168.3.22"
#define K_URL_HOST          @"http://192.168.1.190"
#define K_EASMOB_CER        @"XSPushDevelop"
#define K_DEBUG             @"1"
#define K_APPUPDATE_VERSION @"21"   //****此参数是为了弹更新提示弹框，每次上线前+1
#elif (K_ENVIRONMENT == 1)//正式环境
#define K_URL_HOST          @"https://api.91xinshang.com/"//@"http://api.91sph.com" //@"https://api.91xinshang.com/"
#define K_EASMOB_CER        @"XSPushRelease"
#define K_APPUPDATE_VERSION @"23"   //****此参数是为了弹更新提示弹框，每次上线前+1； 4.0.2——23
//#define K_DEBUG             @"1"
#define NSLog(...) {}
#endif


//application
#define K_CLIENT_VERSION        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define K_CHANNEL               [NSString stringWithFormat:@"%@",[[XSTools getAppData] objectAtIndex:0]]
#define K_APP_MARK              [NSString stringWithFormat:@"%@",[[XSTools getAppData] objectAtIndex:1]]
#define K_BACK_URL              [NSString stringWithFormat:@"%@",[[XSTools getAppData] objectAtIndex:2]]
#define K_APP_BUNDLEID          [NSString stringWithFormat:@"%@",[[XSTools getAppData] objectAtIndex:3]]
#define K_SYSTEM_VERSION        [[[UIDevice currentDevice] systemVersion] intValue]
#define K_KEY_DEVICE_TOKEN      @""


