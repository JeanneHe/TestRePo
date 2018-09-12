//
//  NSArray+Class.m
//  XSCommunity
//
//  Created by 何晓光 on 2018/9/11.
//  Copyright © 2018年 HXG. All rights reserved.
//

#import "NSArray+Class.h"

@implementation NSArray (Class)

- (id)safeObjectAtIndex:(NSUInteger)index_ {
    if (index_ < [self count]) {
        return [self objectAtIndex:index_];
    }
    return nil;
}

- (id)modelLastObject {
    
    if ([[self lastObject] isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return [self lastObject];
}

@end

@implementation NSMutableArray (Class)

- (void)replaceObjectAtIndexSafely:(NSUInteger)index_ withObject:(id)anObject_ {
    if (index_ < [self count] && anObject_) {
        [self replaceObjectAtIndex:index_ withObject:anObject_];
    }
}

@end
