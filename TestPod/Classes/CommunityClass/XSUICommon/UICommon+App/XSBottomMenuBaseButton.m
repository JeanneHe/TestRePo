//
//  XMBottomMenuBaseButton.m
//  XSSPH
//
//  Created by 宋吉超 on 2017/9/21.
//  Copyright © 2017年 Jeanne. All rights reserved.
//

#import "XSBottomMenuBaseButton.h"
#import "YYAnimatedImageView.h"

#ifndef CGWidth
#define CGWidth(rect)                   rect.size.width
#endif

#ifndef CGHeight
#define CGHeight(rect)                  rect.size.height
#endif

#ifndef CGOriginX
#define CGOriginX(rect)                 rect.origin.x
#endif

#ifndef CGOriginY
#define CGOriginY(rect)                 rect.origin.y
#endif

@interface XSBottomMenuBaseButton ()

@property (nonatomic, strong)YYAnimatedImageView         *mNormalImgV;

@property (nonatomic, strong)YYAnimatedImageView         *mSelectImgV;

@end

@implementation XSBottomMenuBaseButton

- (instancetype)initWithFrame:(CGRect)frame isMiddle:(BOOL)isMiddle_
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat image_w = isMiddle_ ? 70 : 45;
        CGFloat image_h = image_w;
        
        YYAnimatedImageView *normalImgV = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake((self.width - image_w)/2, (self.height - image_h)/2, image_w, image_h)];
        normalImgV.hidden = YES;
        [self addSubview:normalImgV];
        self.mNormalImgV = normalImgV;
        normalImgV = nil;
        
        YYAnimatedImageView *selectImgV = [[YYAnimatedImageView alloc] initWithFrame:self.mNormalImgV.frame];
        selectImgV.hidden = YES;
        [self addSubview:selectImgV];
        self.mSelectImgV = selectImgV;
        selectImgV = nil;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.mNormalImgV.hidden = selected;
    self.mSelectImgV.hidden = !selected;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    if (state == UIControlStateNormal) {
        self.mNormalImgV.image = image;
    }else{
        self.mSelectImgV.image = image;
    }
}

@end
