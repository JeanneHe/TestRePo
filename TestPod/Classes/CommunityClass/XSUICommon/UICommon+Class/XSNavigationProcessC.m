//
//  XMNavigationProcessC.m
//  XiaoMai
//
//  Created by Jeanne on 15/7/10.
//  Copyright (c) 2015年 Jeanne. All rights reserved.
//

#import "XSNavigationProcessC.h"

@interface XSNavigationProcessC ()

@end

@implementation XSNavigationProcessC

static XSNavigationProcessC *sharedXMNavigationProcessC = nil;

+ (XSNavigationProcessC *)sharedXMNavigationProcessC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedXMNavigationProcessC = [[XSNavigationProcessC alloc] init];
        sharedXMNavigationProcessC.navigationBarHidden = YES;
        [sharedXMNavigationProcessC.view setFrame:CGRectMake(0, K_SCREEN_HEIGHT, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
        [APP_DELEGATE.mWindow addSubview:sharedXMNavigationProcessC.view];
    });
    return sharedXMNavigationProcessC;
}

- (void)dealloc {
    self.mCompltePrecess = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark selfFuction
- (void)initProcessRootViewController:(id)controller_ completeProcess:(compltePrecess)block_ {
    [self setViewControllers:@[]];
    [self setViewControllers:@[controller_]];
    self.mCompltePrecess = nil;
    self.mCompltePrecess = block_;
}

- (void)animation:(XSNavigationProcessCType)type_ completion:(void (^)(BOOL finished))completion_ {
    self.mNavigationProcessCType = type_;
    if (type_ == XSNavigationProcessCTypeShow) {
        [sharedXMNavigationProcessC.view setFrame:CGRectMake(0, K_SCREEN_HEIGHT, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
        [UIView animateWithDuration:XSCUSTOMBASEVC_ANIMATION_DURATION delay:XSCUSTOMBASEVC_ANIMATION_DELAY options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            [self.view setFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
        } completion:^(BOOL finished) {
            if (completion_) {
                completion_(finished);
            }
        }];
    } else if (type_ == XSNavigationProcessCTypeDisappear) {
        [UIView animateWithDuration:XSCUSTOMBASEVC_ANIMATION_DURATION delay:XSCUSTOMBASEVC_ANIMATION_DELAY options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            [self.view setFrame:CGRectMake(0, K_SCREEN_HEIGHT, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
        } completion:^(BOOL finished) {
            if (completion_) {
                completion_(finished);
                [self popToRootViewControllerAnimated:NO];
            }
            if (self.mCompltePrecess) {
                self.mCompltePrecess();
            }
        }];
    } else  if (type_ == XSNavigationProcessCTypePush) {
        [sharedXMNavigationProcessC.view setFrame:CGRectMake(K_SCREEN_WIDTH, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
        [UIView animateWithDuration:XSCUSTOMBASEVC_ANIMATION_DURATION delay:XSCUSTOMBASEVC_ANIMATION_DELAY options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            [self.view setFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
        } completion:^(BOOL finished) {
            if (completion_) {
                completion_(finished);
            }
            //self.mNavigationProcessCType = XSNavigationProcessCTypeShow;
        }];
    } else if(type_ == XSNavigationProcessCTypePop){
        [UIView animateWithDuration:XSCUSTOMBASEVC_ANIMATION_DURATION delay:XSCUSTOMBASEVC_ANIMATION_DELAY options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            [self.view setFrame:CGRectMake(K_SCREEN_WIDTH, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
        } completion:^(BOOL finished) {
            if (completion_) {
                completion_(finished);
                [self popToRootViewControllerAnimated:NO];
            }
            if (self.mCompltePrecess) {
                self.mCompltePrecess();
            }
        }];
    }
}

- (void)animation:(XSNavigationProcessCType)type_ beforeCompletion:(void (^)(void))completion_ {
    if (completion_) {
        completion_();
    }
    if (type_ == XSNavigationProcessCTypeShow) {
        [UIView animateWithDuration:XSCUSTOMBASEVC_ANIMATION_DURATION delay:XSCUSTOMBASEVC_ANIMATION_DELAY options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            [self.view setFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
        } completion:^(BOOL finished) {}];
    } else if (type_ == XSNavigationProcessCTypeDisappear) {
        [UIView animateWithDuration:XSCUSTOMBASEVC_ANIMATION_DURATION delay:XSCUSTOMBASEVC_ANIMATION_DELAY options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            [self.view setFrame:CGRectMake(0, K_SCREEN_HEIGHT, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
        } completion:^(BOOL finished) {}];
    }
    
    if (type_ == XSNavigationProcessCTypePush) {
        [UIView animateWithDuration:XSCUSTOMBASEVC_ANIMATION_DURATION delay:XSCUSTOMBASEVC_ANIMATION_DELAY options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            [self.view setFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
        } completion:^(BOOL finished) {}];
    } else if (type_ == XSNavigationProcessCTypePop) {
        [UIView animateWithDuration:XSCUSTOMBASEVC_ANIMATION_DURATION delay:XSCUSTOMBASEVC_ANIMATION_DELAY options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            [self.view setFrame:CGRectMake(K_SCREEN_WIDTH, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
        } completion:^(BOOL finished) {}];
    }
}

+ (void)XMPushViewController:(UIViewController *)vc_ animated:(BOOL)animated_ {
    [[XSNavigationProcessC sharedXMNavigationProcessC] pushViewController:vc_ animated:YES];
}

+ (void)XMPopViewControllerAnimated:(BOOL)animated_ {
    [[XSNavigationProcessC sharedXMNavigationProcessC] popViewControllerAnimated:animated_];
}

+ (void)XMPopToRootViewControllerAnimated:(BOOL)animated_ {
    [[XSNavigationProcessC sharedXMNavigationProcessC] popToRootViewControllerAnimated:YES];
}

+ (void)XMPopToViewController:(NSString *)controller_ Animated:(BOOL)animated_ {
    for (UIViewController *temp in [XSNavigationProcessC sharedXMNavigationProcessC].viewControllers) {
        if ([temp isKindOfClass:NSClassFromString(controller_)]) {
            [[XSNavigationProcessC sharedXMNavigationProcessC] popToViewController:temp animated:animated_];
            return;
        }
    }
    return;
}

@end
