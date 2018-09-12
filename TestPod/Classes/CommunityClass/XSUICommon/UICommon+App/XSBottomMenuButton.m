//
//  XMBottomMenuButton.m
//  XiaoMai
//
//  Created by Jeanne on 15/5/11.
//  Copyright (c) 2015年 Jeanne. All rights reserved.
//

#import "XSBottomMenuButton.h"

@implementation XSBottomMenuButton

- (void)initTopIconUI {
    self.mTopIconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mTopIconButton setUserInteractionEnabled:NO];
    [self.mTopIconButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mTopIconButton.titleLabel setFont:K_FONT_SIZE(10)];
    [self.mTopIconButton setBackgroundColor:[UIColor colorWithHexString:@"fc655e"]];//K_COLOR_MAIN_ORANGER
    [self.mTopIconButton setFrame:CGRectMake(self.width - 37, 2, AUTOSIZEIPHONE6(15), AUTOSIZEIPHONE6(15))];//15,15
    [self addSubview:self.mTopIconButton];
}

- (void)setTopIconImage:(UIImage *)image_ {
    if (!self.mTopIconButton) {
        self.mTopIconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mTopIconButton setUserInteractionEnabled:NO];
        [self.mTopIconButton setFrame:CGRectMake(self.width - image_.size.width - 2, 0, image_.size.width, image_.size.height)];
        [self addSubview:self.mTopIconButton];
    }
}

- (void)setTopIconString:(NSString *)string_ {
    if (self.mTopIconButton) {
        [self.mTopIconButton setTitle:string_ forState:UIControlStateNormal];
    }
}

- (void)setTopIconImageState:(BOOL)hidden_ {
    if (self.mTopIconButton) {
        [self.mTopIconButton setHidden:hidden_];
    }
}
- (void)setTopIconImageState:(BOOL)hidden_  andCount:(NSInteger)count_
{
    if (self.mTopIconButton) {
        [self.mTopIconButton setHidden:hidden_];
    }
    if (count_ > 0) {
        if (count_ <= 9) {
            self.mTopIconButton.width = AUTOSIZEIPHONE6(15);
            [self.mTopIconButton setTitle:[NSString stringWithFormat:@"%ld",(long)count_] forState:UIControlStateNormal];
        }else if(count_ > 9 && count_ <= 99){
            self.mTopIconButton.width = AUTOSIZEIPHONE6(25);
            [self.mTopIconButton setTitle:[NSString stringWithFormat:@"%ld",(long)count_] forState:UIControlStateNormal];
        }else{
            self.mTopIconButton.width = AUTOSIZEIPHONE6(25);
            [self.mTopIconButton setTitle:@"99+" forState:UIControlStateNormal];
        }
        [self.mTopIconButton setHidden:NO];
    }else{
        [self.mTopIconButton setHidden:YES];
    }
}


@end
