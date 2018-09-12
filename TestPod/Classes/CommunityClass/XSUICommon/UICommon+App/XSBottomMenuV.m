//
//  XMBottomMenuV.m
//  XiaoMai
//
//  Created by Jeanne on 15/5/11.
//  Copyright (c) 2015年 Jeanne. All rights reserved.
//

#import "XSBottomMenuV.h"
#import "XSBottomMenuButton.h"
#import "UIButton+YYWebImage.h"

#define XMBOTTOMMENUV_BUTTON_WIDTH K_SCREEN_WIDTH/5//100
#define XMBOTTOMMENUV_BUTTON_HEIGHT 39

#define XMBOTTOMMENUV_BUTTON_OFFSET_X (K_SCREEN_WIDTH - XMBOTTOMMENUV_BUTTON_WIDTH*5)/6

@interface XSBottomMenuV ()
@property (nonatomic, strong)NSMutableArray            *mButtomArray;
@property (nonatomic, strong)NSMutableArray            *mRootVCArray;
@property (nonatomic, strong)NSMutableArray            *mRootVCIndexArray;
@property (nonatomic, strong)NSArray                   *mButtonNormalImageArray;
@property (nonatomic, strong)NSArray                   *mButtonSelectedImageArray;
@property (nonatomic, assign)int                       mCurrentIndex;
@property (nonatomic, assign)XSBottomMenuImageType     mBottomMenuImageType;
@property (nonatomic, strong)UIView                    *mCover;

@end

@implementation XSBottomMenuV

+ (XSBottomMenuV *)sharedBottomMenuV {
    static XSBottomMenuV *sharedBottomV = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBottomV = [[XSBottomMenuV alloc] initBottomMenuV];
    });
    return sharedBottomV;
}

- (void)dealloc {
    _mButtomArray = nil;
    _mRootVCArray = nil;
    _mRootVCIndexArray = nil;
    _mButtonNormalImageArray = nil;
    _mButtonSelectedImageArray = nil;
    _mBottomMenuVDelegate = nil;
}

#pragma mark selfFuction
- (instancetype)initBottomMenuV {
    if (self == [super init]) {
        self.mCurrentIndex = -1;
        self.mButtomArray = [NSMutableArray array];
        self.mRootVCArray = [NSMutableArray array];
        self.mRootVCIndexArray = [NSMutableArray array];
        
        [self setFrame:CGRectMake(0, K_SCREEN_HEIGHT - K_XMBOTTOMMENUV_HEIGHT, K_SCREEN_WIDTH, K_XMBOTTOMMENUV_HEIGHT)];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutcontrollersubviews) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, -0.15);
        self.layer.shadowOpacity = 0.1;
        
        self.mButtonNormalImageArray = [NSArray arrayWithObjects:@"tab_icon_homepage",@"icon_classify",@"icon_sale",@"tab_icon_news",@"tab_icon_mine",nil];
        self.mButtonSelectedImageArray = [NSArray arrayWithObjects:@"tab_icon_sel_homepage",@"icon_sel_classify",@"icon_sale",@"tab_icon_sel_news",@"tab_icon_sel_mine",nil];
        for (int i = 0; i < [self.mButtonNormalImageArray count]; i ++) {
            
            int height = (i == 2) ? 70 : (iPhoneX ? self.height - 34: self.height) ;
            int top = 0;
            if (i == 2) {
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isSaleBtnAnimation"]) {
                    top = -26;
                } else { 
                    top = 96;
                }
            } else {
                top = 0;
            };
            XSBottomMenuButton *tempButton = [[XSBottomMenuButton alloc] initWithFrame:CGRectMake((XMBOTTOMMENUV_BUTTON_OFFSET_X*(i+1)) + i*XMBOTTOMMENUV_BUTTON_WIDTH, top, XMBOTTOMMENUV_BUTTON_WIDTH, height) isMiddle:(i == 2) ? YES : NO];
            [tempButton setAdjustsImageWhenHighlighted:NO];
            [tempButton setTag:i];
            [tempButton setImage:[UIImage imageNamed:[self.mButtonNormalImageArray objectAtIndex:i]] forState:UIControlStateNormal];
            [tempButton setImage:[UIImage imageNamed:[self.mButtonSelectedImageArray objectAtIndex:i]] forState:UIControlStateSelected];
            
            [tempButton initTopIconUI];
            [tempButton setTopIconImageState:YES];
            [tempButton setTopIconImage:[UIImage imageNamed:@"news_bubble.png"]];

            [self addSubview:tempButton];

            [self.mButtomArray addObject:tempButton];
            [tempButton addTarget:self action:@selector(bottomVButtonPressed:animation:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        self.mBottomMenuImageType = XSBottomMenuImageTypeNomal;
        
    }
    return self;
}

- (void)reSetBottomButtonImage:(NSArray *)image_ selectImage:(NSArray *)selectImage_{
    
    if (image_.count == 5 && selectImage_.count == 5) {
        
        for (int i = 0; i<image_.count; i++) {
            XSBottomMenuButton *tempButton = [self.mButtomArray safeObjectAtIndex:i];
            
            [tempButton setImageWithURL:[NSURL URLWithString:[image_ safeObjectAtIndex:i]]
                               forState:UIControlStateNormal
                            placeholder:[UIImage imageNamed:[self.mButtonNormalImageArray safeObjectAtIndex:i]]];
            [tempButton setImageWithURL:[NSURL URLWithString:[selectImage_ safeObjectAtIndex:i]]
                               forState:UIControlStateSelected
                            placeholder:[UIImage imageNamed:[self.mButtonSelectedImageArray safeObjectAtIndex:i]]];
        }
    }else{
        
        for (int i = 0; i < 5; i++) {
            XSBottomMenuButton *tempButton = [self.mButtomArray safeObjectAtIndex:i];
            
            [tempButton setImage:[UIImage imageNamed:[self.mButtonNormalImageArray objectAtIndex:i]]
                        forState:UIControlStateNormal];
            [tempButton setImage:[UIImage imageNamed:[self.mButtonSelectedImageArray objectAtIndex:i]]
                        forState:UIControlStateSelected];
        }
    }
}

- (UIView *)mCover
{
    if (_mCover == nil) {
        _mCover = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _mCover.backgroundColor = [UIColor clearColor];
    }
    return _mCover;
}

- (void)bottomVSelected:(XSBottomMenuVRootType)type_ animation:(BOOL)animation_ {
    [self setSelectedIndex:type_];
    [self bottomVButtonPressed:[self.mButtomArray objectAtIndex:type_] animation:animation_];
}

- (void)reSetBottomMenuButtonState:(XSBottomMenuVRootType)index_ cornerState:(BOOL)state_ and:(NSUInteger )count {
    XSBottomMenuButton *tempButton = [self.mButtomArray objectAtIndex:index_];
    [tempButton setTopIconImageState:state_ andCount:count];

}

- (void)reSetBottomMenuButtonState:(XSBottomMenuVRootType)index_ cornerState:(BOOL)state_{
    XSBottomMenuButton *tempButton = [self.mButtomArray objectAtIndex:index_];
    [tempButton setTopIconImageState:state_];
}

- (instancetype)checkRootControllerIsAlreadyHave:(XSBottomMenuVRootType)type_ {
    id object = nil;
    for (int i = 0; i < [self.mRootVCIndexArray count]; i++) {
        if ([[self.mRootVCIndexArray objectAtIndex:i] intValue] == type_) {
            object = [self.mRootVCArray objectAtIndex:i];
        }
    }
    return object;
}

- (id)getRootControllerAndCreat:(XSBottomMenuVRootType)type_ {
    self.mCurrentIndex = type_;
//    __block XSBottomMenuV *blockSelf = self;
    __block id object = nil;
    object = [self getRootController:type_];
    if (object != nil) {
        return object;
    }
    
    switch (type_) {
        case XSBottomMenuVTypeHomePage:
        {
            
            break;
        }
        case XSBottomMenuVTypeIdle:
        {

            break;
        }
        case XSBottomMenuVTypeSell:
        {

            break;
        }
        case XSBottomMenuVTypeMessage:
        {


            break;
        }
        case XSBottomMenuVTypeMy:
        {

            break;
        }
    }
    return object;
}

- (id)getRootController:(XSBottomMenuVRootType)type_ {
    for (int i = 0; i < [self.mRootVCIndexArray count]; i++) {
        if ([[self.mRootVCIndexArray objectAtIndex:i] intValue] == type_) {
            return (id)[self.mRootVCArray objectAtIndex:i];
        }
    }
    return nil;
}

- (void)bottomVButtonPressed:(UIButton *)sender_ animation:(BOOL)animation_ {
//    [XSTools cancelUnfinishedRequest];
//    [XSTools popToRootViewControllerAnimated:NO];
    id object = [self getRootControllerAndCreat:sender_.tag];
    self.mBottomMenuVDelegate = object;
    [self.mBottomMenuVDelegate bottomVDelegateButtonPressed:sender_.tag controller:object];
    object = nil;
}

- (void)setSelectedIndex:(XSBottomMenuVRootType)type_ {
    self.mCurrentIndex = type_;
    [self.mButtomArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        if (idx == type_) {
            obj.selected = YES;
        } else {
            obj.selected = NO;
        }
    }];
}

- (XSBottomMenuVRootType)returnMenuCurrentType {
    return self.mCurrentIndex;
}

- (void)layoutcontrollersubviews{
    float barHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    //解决打电话，开启WIFI等页面下移问题
    if (barHeight > K_SYSTEM_BAR) {
        self.mIsShowWifi = YES;
        self.top = K_SCREEN_HEIGHT - K_XMBOTTOMMENUV_HEIGHT - 20;
    } else {
        self.mIsShowWifi = NO;
        self.top = K_SCREEN_HEIGHT - K_XMBOTTOMMENUV_HEIGHT;
    }
}
@end
