//
//  UIImage+App.h
//  XSCommunity
//
//  Created by 何晓光 on 2018/9/11.
//  Copyright © 2018年 HXG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (App)

- (UIImage *)imageByScaleingToMinimumSize:(CGSize)targetSize_;

- (UIImage *)scaleImageWithFactor:(CGFloat)scaleFactor_;
@end
