//
//  NSArray+Class.h
//  XSCommunity
//
//  Created by 何晓光 on 2018/9/11.
//  Copyright © 2018年 HXG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Class)

- (id)safeObjectAtIndex:(NSUInteger)index_;

- (id)modelLastObject;

@end

@interface NSMutableArray (Class)

- (void)replaceObjectAtIndexSafely:(NSUInteger)index_ withObject:(id)anObject_;

@end
