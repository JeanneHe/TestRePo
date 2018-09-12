//
//  XMCacheManager.m
//  XiaoMai
//
//  Created by chenzb on 15/6/29.
//  Copyright (c) 2015年 Jeanne. All rights reserved.
//


@implementation XSCacheManager

static NSMutableDictionary  *kDictionary;

+ (XSCacheManager *)shareCacheManager {
    static XSCacheManager *_shareCacheManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareCacheManager = [[XSCacheManager alloc] init];
    });
    return _shareCacheManager;
}

- (void)saveObjectCache:(id)data_ key:(NSString *)key_ {
    
    [self saveObject:data_ key:key_];
}

- (id)getObjectCache:(NSString *)key_ {
    return [self getObject:key_];
}

- (void)saveClassCache:(id)data_ key:(NSString *)key_ {
    [self setObjectFromSystem:data_ key:key_];
}

- (id)getClassCache:(NSString *)key_ {
    return [self getObjectFromSystemKey:key_];
}

- (void)saveObjectMemory:(id)data_ key:(NSString *)key_ {
    if (!kDictionary) {
        kDictionary = [NSMutableDictionary dictionary];
    }
    [kDictionary setValue:data_ forKey:key_];
}

- (id)getObjectMemory:(NSString *)key_ {
    return [kDictionary objectForKey:key_];
}

- (void)removeObjectForKey:(NSString *)key_{
    if(!key_){
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key_];
}

#pragma NSKeyedArchiver 序列化存储
- (void)setObjectFromSystem:(id)data_ key:(NSString *)key_ {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:data_];
    [defaults setObject:data forKey:key_];
    [defaults synchronize];
}

- (id)getObjectFromSystemKey:(NSString *)key_ {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:key_];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
#pragma mark  缓存一般对象对象的存储
- (void)saveObject:(id)data_ key:(NSString*)key_ {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data_ forKey:key_];
    [defaults synchronize];
}

- (id)getObject:(NSString*)key_ {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key_];
}
@end
