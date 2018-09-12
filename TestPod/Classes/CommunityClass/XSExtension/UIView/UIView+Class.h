//
//  UIView+Class.h
//  XSCommunity
//
//  Created by 何晓光 on 2018/9/11.
//  Copyright © 2018年 HXG. All rights reserved.
//

#import <UIKit/UIKit.h>

CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (Class)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;


@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


- (void)moveBy:(CGPoint)delta_;
- (void)scaleBy:(CGFloat)scaleFactor_;
- (void)fitInSize:(CGSize)aSize_;
@end
