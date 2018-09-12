//
//  XMCacheManager.h
//  XiaoMai
//
//  Created by chenzb on 15/6/29.
//  Copyright (c) 2015年 Jeanne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSCacheManager : NSObject

+ (XSCacheManager *)shareCacheManager;

//缓存一般对象
- (void)saveObjectCache:(id)data_ key:(NSString *)key_;

//获取缓存一般对象
- (id)getObjectCache:(NSString *)key_;

//缓存序列化对象
- (void)saveClassCache:(id)data_ key:(NSString *)key_;

//获取缓存序列化对象
- (id)getClassCache:(NSString *)key_;

//保存内存对象
- (void)saveObjectMemory:(id)data_ key:(NSString *)key_;

//获取内存对象
- (id)getObjectMemory:(NSString *)key_;

//移除对象
- (void)removeObjectForKey:(NSString *)key_;

@end
