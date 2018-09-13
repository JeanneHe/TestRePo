//
//  UIImageView+App.m
//  XSCommunity
//
//  Created by 何晓光 on 2018/9/11.
//  Copyright © 2018年 HXG. All rights reserved.
//

#import "UIImageView+App.h"
#import "UIColor+Class.h"

NSString * const kXSPlaceholderImageName = @"kXSPlaceholderImageName";

@implementation UIImageView (App)
- (void)xs_setImageWithURL:(NSURL *)url
{
    [self xs_setImageWithURL:url placeholderImage:nil options:SDWebImageTransformAnimatedImage progress:nil completed:nil];
}

- (void)xs_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self xs_setImageWithURL:url placeholderImage:placeholder options:SDWebImageTransformAnimatedImage progress:nil completed:nil];
}

- (void)xs_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock
{
    [self xs_setImageWithURL:url placeholderImage:placeholder options:SDWebImageTransformAnimatedImage progress:nil completed:completedBlock];
}

- (void)xs_setImageWithURL:(NSURL *)url completed:(SDExternalCompletionBlock)completedBlock
{
    [self xs_setImageWithURL:url placeholderImage:nil options:SDWebImageTransformAnimatedImage progress:nil completed:completedBlock];
}

- (void)xs_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    [self xs_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)xs_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDExternalCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:progressBlock completed:completedBlock];
}

@end
