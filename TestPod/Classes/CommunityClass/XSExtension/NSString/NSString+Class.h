//
//  NSString+Class.h
//  XSCommunity
//
//  Created by 何晓光 on 2018/9/11.
//  Copyright © 2018年 HXG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Class)
/// 检测一个字符串是否为空
- (BOOL)isNotBlank;

/// 去除空格
- (instancetype)trimedStr;
@end
