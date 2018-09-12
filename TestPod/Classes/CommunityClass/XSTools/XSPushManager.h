//
//  XMPushManager.h
//  XiaoMai
//
//  Created by chenzb on 15/9/1.
//  Copyright (c) 2015年 Jeanne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSPushManager : NSObject

+ (XSPushManager *)sharedPushManager;

/**
 * 协议跳转 
 *
 */
- (void)pushVCbyURLInApp:(NSString *)urlStr_;

/**
 * 协议跳转 （默认方法，如果跳转时获取的模型不是Protocal，采用上面的方法）
 *
 */
//- (void)pushVCbyURLInAppProtocal:(Protocal *)protocal_;
@end
