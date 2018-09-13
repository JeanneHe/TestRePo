//
//  LAppConfig.h
//  LeHeCai
//
//  Created by HXG on 11-9-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


//UIScreen&UIDevice

#define IOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >=8.0 ? YES : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define K_SYSTEM_BAR                        ([UIScreen mainScreen].bounds.size.height == 812.0 ? 44.0 : 20.0)
#define K_SYSTEM_TOPVIEW_H                  (K_SYSTEM_BAR + 44)
#define K_ANIMATION_SYSTEM_BAR              ([[[UIDevice currentDevice] systemVersion] intValue] >= 7 ? 0.0 : 20.0)
#define K_NAVIGATION_BAR_HEIGHT             (44)

#define AUTOSIZEIPHONE5(i)                 ceil(((([UIScreen mainScreen].bounds).size.width*2) / 640) * i) //根据屏幕宽度调整尺寸(以iPhone5尺寸为基准 640)
#define AUTOSIZEIPHONE6(i) ceil([UIScreen mainScreen].bounds.size.width == 414 ? (i):((([UIScreen mainScreen].bounds.size.width*2) / 750.00) * i))

#define AUTOSIZEIPHONE(i)                 ceil(((([UIScreen mainScreen].bounds).size.width*2) / 750) * i) //根据屏幕宽度调整尺寸(以iPhone6尺寸为基准 750)

// 屏幕宽高、标准组件高度 --------------------
#define K_SCREEN_X                      [UIScreen mainScreen].bounds.origin.x
#define K_SCREEN_Y                      [UIScreen mainScreen].bounds.origin.y
#define K_SCREEN_WIDTH                  ([[[UIDevice currentDevice] systemVersion] intValue] >= 7 ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].applicationFrame.size.width)
#define K_SCREEN_HEIGHT                 ([[[UIDevice currentDevice] systemVersion] intValue] >= 7 ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].applicationFrame.size.height)

#define ScaleHeight(height) (K_SCREEN_WIDTH * (height/375.0))
#define ScaleWidth(width) (SCREEN_H * (width/667.0))

#define LINE_HEIGHT 1.0/[UIScreen mainScreen].scale

//x 是bottom的高度
#define K_BOTTOM_TOP(X)  (self.mContentView.height - (iPhoneX ? self.mBottomMenuHeight : AUTOSIZEIPHONE6(X)))

// 通知的一些宏定义
#define NSREMOVENotification [[NSNotificationCenter defaultCenter] removeObserver:self];

#define NSPOSTNotification(NAME, obj) [[NSNotificationCenter defaultCenter] postNotificationName:NAME object:obj];

#define NSAddObserver(selectorStr ,keyName) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectorStr) name:keyName object:nil];

// 收起键盘
#define ENDEDITINGKEBARD [[UIApplication sharedApplication].keyWindow endEditing:YES];

// 使用Localizable.strings文件中字符串方法--------------------
#define STRING(x)                       NSLocalizedString(x, nil)

//16进制颜色转换
#define HEXCOLOR(s)          [XSTools colorWithHexString:(s)]

//font
#define K_FONT_SIZE(size)                   [UIFont systemFontOfSize:size]
#define K_BOLD_FONT_SIZE(size)              [UIFont boldSystemFontOfSize:size]
#define K_FONT_AUTOSIZE(size)               [UIFont systemFontOfSize:iPhone6Plus ? (size+1):size]
#define K_BOLD_FONT_AUTOSIZE(size)          [UIFont boldSystemFontOfSize:iPhone6Plus ? (size+1):size]

// float
#define K_EPSINON                       (1e-127)
#define IS_ZERO_FLOAT(X)                (X < K_EPSINON && X > -K_EPSINON)


//正则表达式 Regular Expressions
#define K_REGULAR_PHONE                 @"SELF MATCHES '(1[0-9]|2[0-9])\\\\d{9}'"
#define K_REGULAR_PASSWORD              @"SELF MATCHES '^[0-9a-zA-Z]{6,15}$'"
#define K_REGULAR_PASSWORD_SCREEN       @"SELF MATCHES '^[0-9a-zA-Z][\u4e00-\u9fa5]{6,20}$'"
#define K_REGULAR_VERIFY_CODE           @"SELF MATCHES '^[0-9a-zA-Z]{1,20}$'"
#define K_REGULAR_EMAIL                 @"SELF MATCHES '[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}'"
#define K_REGULAR_TELEPHONE_NUM         @"SELF MATCHES '1[0-9]{10}'"
#define K_NUMBER                        @"SELF MATCHES '^[0-9]*[1-9][0-9]*$'"
#define K_REGULAR_VERIFICATION_CODE     @"SELF MATCHES '[0-9]{4}'"

#define K_ExpNumber_Holomorphy          @"SELF MATCHES '^[0-9a-zA-Z]{6,20}$'"
#define K_TELEPHONE_HOLOMORPHY          @"SELF MATCHES '1[0-9]{10}'"


//APP delegate
#define APP_DELEGATE     ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//protocal
#define K_KEY_COMEFROM_OUT_TO_LOCATION     @"target"

