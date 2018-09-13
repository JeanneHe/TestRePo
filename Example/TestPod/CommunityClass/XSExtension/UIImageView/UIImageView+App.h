//
//  UIImageView+App.h
//  XSCommunity
//
//  Created by 何晓光 on 2018/9/11.
//  Copyright © 2018年 HXG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

UIKIT_EXTERN NSString * const kXSPlaceholderImageName;

@interface UIImageView (App)

- (void)xs_setImageWithURL:(NSURL *)url;

- (void)xs_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

- (void)xs_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock;

- (void)xs_setImageWithURL:(NSURL *)url completed:(SDExternalCompletionBlock)completedBlock;

- (void)xs_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options;

- (void)xs_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDExternalCompletionBlock)completedBlock;
@end
