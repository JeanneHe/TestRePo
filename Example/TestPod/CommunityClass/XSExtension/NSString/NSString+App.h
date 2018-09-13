//
//  NSString+App.h
//  XSCommunity
//
//  Created by 何晓光 on 2018/9/11.
//  Copyright © 2018年 HXG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (App)

//将YYYY-MM-dd HH:ss:mm 转换为 yyyy.MM.dd 格式
+ (NSString *)createPointStringToString:(NSString *)string;

//将YYYY-MM-dd转换为 yyyy.MM.dd 格式
+ (NSString *)createPointStringWithTimeString:(NSString *)string;

//将YYYY-MM-dd HH:ss:mm 转换为 yyyy.MM.dd HH:ss 格式
+ (NSString *)createYhStringToString:(NSString *)string;

/**
 *  判断价格的显示（整数就不带小数点，一位小数，两位小数）
 */
+ (NSString *)xsPriceFormateString:(NSNumber *)priceNumber;

// 用"*"替换手机号中间四位
// @return 带"*"的手机号
- (NSString *)phoneSecurityString;

// 检查是否是表情
// @return 是否是表情
- (BOOL)isEmoji;

// 检查是否是手机号
// @return 是否是手机号
- (BOOL)isPhoneString;

// 检查是否是密码
// @return 是否是密码
- (BOOL)isPasswordString;

// 检查是否是数字
// @return 是否是数字
- (BOOL)isNumber;

// 检查是否是字母
// @return 是否是字母
- (BOOL)isCharacter;

// 检查是否是汉字
// @return 是否是汉字
- (BOOL)isHans;
@end
