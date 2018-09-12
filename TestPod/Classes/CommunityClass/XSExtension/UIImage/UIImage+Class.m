//
//  UIImage+Class.m
//  XSCommunity
//
//  Created by 何晓光 on 2018/9/11.
//  Copyright © 2018年 HXG. All rights reserved.
//

#import "UIImage+Class.h"

@implementation UIImage (Class)
+ (UIImage *)imageForKey:(NSString *)name
{
    return [UIImage imageForKey:name cache:YES];
}


+ (UIImage *)imageForKey:(NSString *)name cache:(BOOL)needCache
{
    if (name == nil) {
        return nil;
    }
    
    if ([name hasSuffix:@".png"] || [name hasSuffix:@".jpg"] || [name hasSuffix:@".gif"]) {
        name = [name substringToIndex:((NSString *)name).length-4];
    }
    
    UIImage *image = nil;
    if (needCache) {
        image = [UIImage imageNamed:name];
    } else {
        image = [UIImage imageWithContentsOfFile:[self imagePathForName:name inBundle:[NSBundle mainBundle]]];
        if (image == nil) {
            image = [UIImage imageNamed:name];
        }
    }
    
    if (image == nil) {
        NSLog(@"========================\nimage: %@加载失败\n========================", name);
    }
    
    return image;
}

+ (NSString *)imagePathForName:(NSString *)name inBundle:(NSBundle *)bundle
{
    NSString *imagePath = nil;
    if ((imagePath = [bundle pathForResource:name ofType:@"png"])) {
        return imagePath;
    } else if((imagePath = [bundle pathForResource:name ofType:@"jpg"])) {
        return imagePath;
    } else if((imagePath = [bundle pathForResource:name ofType:@"gif"])) {
        return imagePath;
    } else{
        NSString *name2x = [name stringByAppendingString:@"@2x"];
        if ((imagePath = [bundle pathForResource:name2x ofType:@"png"])) {
            return imagePath;
        } else if((imagePath = [bundle pathForResource:name2x ofType:@"jpg"])) {
            return imagePath;
        }
    }
    
    return imagePath;
}
@end
