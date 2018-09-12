//
//  UIImage+App.m
//  XSCommunity
//
//  Created by 何晓光 on 2018/9/11.
//  Copyright © 2018年 HXG. All rights reserved.
//

#import "UIImage+App.h"

@implementation UIImage (App)
- (UIImage *)imageByScaleingToMinimumSize:(CGSize)targetSize_ {
    
    UIImage *resultImage = nil;
    
    if (targetSize_.height > 0 && targetSize_.width > 0) {
        CGSize originImageSize = self.size;
        CGFloat targetWidth  = targetSize_.width;
        CGFloat targetHeight = targetSize_.height;
        
        CGFloat scaledFactor = 0.f;
        CGFloat scaledWidth  = targetWidth;
        CGFloat scaledHeight = targetHeight;
        
        CGRect targetFrame      = CGRectZero;
        
        if (!CGSizeEqualToSize(targetSize_, originImageSize)) {
            
            CGFloat widthFactor  = targetWidth / originImageSize.width;
            CGFloat heightFactor = targetHeight / originImageSize.height;
            
            if (widthFactor > heightFactor) {
                scaledFactor = heightFactor;
            } else {
                scaledFactor = widthFactor;
            }
            
            scaledWidth  = originImageSize.width * scaledFactor;
            scaledHeight = originImageSize.height * scaledFactor;
            
            if (widthFactor > heightFactor) {
                targetFrame.origin.x = (targetWidth - scaledWidth) * 0.5f;
            } else {
                targetFrame.origin.y = (targetHeight - scaledHeight) * 0.5f;
            }
        }
        
        targetFrame.size.width  = scaledWidth;
        targetFrame.size.height = scaledHeight;
        
        UIGraphicsBeginImageContextWithOptions(targetSize_, NO, [UIScreen mainScreen].scale);
        [self drawInRect:targetFrame];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return resultImage;
}

- (UIImage *)scaleImageWithFactor:(CGFloat)scaleFactor_ {
    
    CGSize targetSize = self.size;
    targetSize.width  = targetSize.width * scaleFactor_;
    targetSize.height = targetSize.height * scaleFactor_;
    UIImage *resultImage = nil;
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
@end
