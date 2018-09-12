//
//  UIImage+Class.h
//  XSCommunity
//
//  Created by 何晓光 on 2018/9/11.
//  Copyright © 2018年 HXG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Class)

+ (UIImage *)imageForKey:(NSString *)name;

+ (UIImage *)imageForKey:(NSString *)name cache:(BOOL)needCache;
@end
