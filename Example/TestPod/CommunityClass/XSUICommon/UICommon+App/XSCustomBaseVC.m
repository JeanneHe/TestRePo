//
//  LCCustomBaseVC.m
//  LeCai
//
//  Created by lehecaiminib on 14-12-2.
//
//

#import "XSCustomBaseVC.h"
#import "AppDelegate.h"
#import "XSBottomMenuV.h"

#define RIGHTBUTTON_TAG 200
//#import "XMNavigationProcessC.h"


@interface XSCustomBaseVC () <UIGestureRecognizerDelegate>
@property (nonatomic, strong)UILabel                 *mTitleLabel;//标题
@property (nonatomic, strong)NSString                *mTitleStr;

@end

@implementation XSCustomBaseVC

- (void)dealloc {
    _mTitleLabel = nil;
    _mLineV = nil;
    _mTitleStr = nil;
    _mBackButton = nil;
    _mTopView = nil;
    _mContentView = nil;
}

/// 判断页面有没有正在显示在屏幕上
- (BOOL)isVisible
{
    return (self.isViewLoaded && self.view.window);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mR_edge_Distance = XSCUSTOMBASEVC_TOPRIGHT_OFFSET_X;//默认值
    self.mR_X_Distance = XSCUSTOMBASEVC_TOPRIGHT_OFFSET_X;  //默认值
    
    self.mL_edge_Distance = XSCUSTOMBASEVC_TOPRIGHT_OFFSET_X; //默认值
    self.mL_X_Distance = XSCUSTOMBASEVC_TOPRIGHT_OFFSET_X;
    
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        [[UITableView appearance] setEstimatedRowHeight:0];
        [[UITableView appearance] setEstimatedSectionFooterHeight:0];
        [[UITableView appearance] setEstimatedSectionHeaderHeight:0];
    }else{
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }

    [self.view setFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
    self.mTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SYSTEM_BAR + K_NAVIGATION_BAR_HEIGHT)];
    [self.mTopView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mTopView];

    self.mTitleLabel = [UILabel new];
    [self.mTitleLabel setFrame:CGRectMake(0, K_SYSTEM_BAR, self.mTopView.width, self.mTopView.height - K_SYSTEM_BAR)];
    [self.mTitleLabel setBackgroundColor:[UIColor clearColor]];
    [self.mTitleLabel setTextColor:[UIColor blackColor]];
    [self.mTitleLabel setFont:K_FONT_SIZE(16)];
    [self.mTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.mTopView addSubview:self.mTitleLabel];
    [self setTitle:self.mTitleStr];
    
    self.mContentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mTopView.bottom, K_SCREEN_WIDTH, self.view.height - self.mTopView.height)];
    [self.mContentView setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
    [self.view addSubview:self.mContentView];
    [self.view bringSubviewToFront:self.mTopView];
    
    if (self.mCustomBaseType == LCCustomBaseVCTypeRoot) {
        [self.mContentView setFrame:CGRectMake(0, self.mTopView.bottom, K_SCREEN_WIDTH, self.view.height - self.mTopView.bottom - [XSBottomMenuV sharedBottomMenuV].height)];
    } else if (self.mCustomBaseType == LCCustomBaseVCTypeNormal) {
        self.mBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mBackButton setTag:XSBOTTOMMENUV_BACKBUTTON];
        [self.mBackButton setImage:[UIImage imageForKey:@"nav_back" cache:YES] forState:UIControlStateNormal];
        self.mBackButton.adjustsImageWhenHighlighted = NO;
        [self.mBackButton setFrame:CGRectMake(0, K_SYSTEM_BAR/2 + (self.mTopView.height - 40)/2, 100, 40)];
        [self.mBackButton setImageEdgeInsets:UIEdgeInsetsMake(0, -60, 0, 0)];
        [self.mBackButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.mTopView addSubview:self.mBackButton];
    }
    
    UIView *line = [UIView new];
    [line setFrame:CGRectMake(0, self.mTopView.bottom - LINE_HEIGHT, K_SCREEN_WIDTH, LINE_HEIGHT)];
    line.backgroundColor = [UIColor colorWithHexString:@"d0d0d0"];
    [self.view addSubview:line];
    self.mLineV = line;
    line = nil;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (self.navigationController == [XSNavigationProcessC sharedXMNavigationProcessC]) {
//        [XSNavigationProcessC sharedXMNavigationProcessC].interactivePopGestureRecognizer.enabled = YES;
//        [XSNavigationProcessC sharedXMNavigationProcessC].interactivePopGestureRecognizer.delegate = self;
//    } else {
        APP_DELEGATE.mNavigationController.interactivePopGestureRecognizer.enabled = YES;
        APP_DELEGATE.mNavigationController.interactivePopGestureRecognizer.delegate = self;
//    }
}

- (void)showButtonPressed {
    [self animationBottomAnimation:BottomAnimationTypeShow completion:^(BOOL finished) {
        
    }];
}

- (void)hideButtonPressed {
    [self animationBottomAnimation:BottomAnimationTypeDisappear completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --
#pragma mark self fuction
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (APP_DELEGATE.mNavigationController.viewControllers.count <= 1) {
        return NO;
    } else {
       return YES;
    }
}

+ (void)aopFuction {}

- (void)backButtonPressed {
    
//    [XSAnalysisManager SensorsAnalyticsButtonClickWithScreenName:nil
//                                                      buttonName:BUTTONNAME_RETURN_PREVIOUS_PAGE
//                                                targetScreenName:nil];

    if (self.navigationController == APP_DELEGATE.mNavigationController) {
//        [XSTools cancelUnfinishedRequest];
//        [XSTools popControllerAnimated:YES];
    }
//    else if (self.navigationController == [XSNavigationProcessC sharedXMNavigationProcessC]) {
//        if (self.navigationController.viewControllers.count <= 1) {
//            if([XSNavigationProcessC sharedXMNavigationProcessC].mNavigationProcessCType == XSNavigationProcessCTypeShow){
//                [[XSNavigationProcessC sharedXMNavigationProcessC] animation:XSNavigationProcessCTypeDisappear completion:^(BOOL finished) {
//                }];
//            } else if ([XSNavigationProcessC sharedXMNavigationProcessC].mNavigationProcessCType == XSNavigationProcessCTypePush) {
//                [[XSNavigationProcessC sharedXMNavigationProcessC] animation:XSNavigationProcessCTypePop completion:^(BOOL finished) {
//                }];
//            }
//        } else {
//            [XSNavigationProcessC XMPopViewControllerAnimated:YES];
//        }
//    }
//    [XSCustomBaseVC aopFuction];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];

}

- (void)initTopLeftV:(NSArray *)data_ {
    double totalWidth = 0;
    for (int i = 0; i < [data_ count]; i++) {
        UIView *temp = [data_ objectAtIndex:i];
        [temp setFrame:CGRectMake(0 + self.mL_X_Distance*(i) + totalWidth+self.mL_edge_Distance,K_SYSTEM_BAR/2 + (self.mTopView.height - temp.height)/2, temp.width, temp.height)];
        totalWidth += temp.width;
        [self.mTopView addSubview:temp];
        
    }
    if (data_) {
        [self.mBackButton setHidden:YES];
    }
}

- (void)setTopViewHidden:(BOOL)hidden_ {
    if (hidden_) {
        [self.mLineV setHidden:YES];
        [self.mTopView setBackgroundColor:[UIColor clearColor]];
        self.mContentView.top = 0;
        self.mContentView.height += self.mTopView.height;
    } else {
        [self.mLineV setHidden:NO];
        [self.mTopView setBackgroundColor:[UIColor colorWithHexString:@"F13131"]];
        CGRectMake(0, self.mTopView.bottom, K_SCREEN_WIDTH, self.view.height - self.mTopView.bottom);
    }
}

- (void)initTopRightV:(NSArray *)data_ {
    
    [self.mTopView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.tag >= RIGHTBUTTON_TAG&&obj.tag < RIGHTBUTTON_TAG+10){
            [obj removeFromSuperview];
        }
    }];
    double totalWidth = 0;
    for (int i = 0; i < [data_ count]; i++) {
        UIView *temp = [data_ objectAtIndex:i];
        temp.tag = RIGHTBUTTON_TAG+i;
        totalWidth += temp.width;
        
        self.mR_X_Distance = 3; 
        [temp setFrame:CGRectMake(K_SCREEN_WIDTH - self.mR_X_Distance*(i)-self.mR_edge_Distance - totalWidth,K_SYSTEM_BAR/2 + (self.mTopView.height - temp.height)/2, temp.width, temp.height)];
        [self.mTopView addSubview:temp];
    }
}

- (id)initCustomVCType:(LCCustomBaseVCType)type_ {
    if (self = [super init]) {
        self.mCustomBaseType = type_;
    }
    return self;
}

- (void)animationBottomAnimation:(BottomAnimationType)type_ completion:(void (^)(BOOL finished))completion_ {
    if (type_ == BottomAnimationTypeShow) {
        [UIView animateWithDuration:XSCUSTOMBASEVC_ANIMATION_DURATION delay:XSCUSTOMBASEVC_ANIMATION_DELAY options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
//            [self.mBottomMenuV setFrame:CGRectMake(0, K_SCREEN_HEIGHT - self.mBottomMenuV.height, self.mBottomMenuV.width, self.mBottomMenuV.height)];
            if (self.mIsControlWithContentV) {
//                [self.mContentView setFrame:CGRectMake(0, self.mTopView.bottom, K_SCREEN_WIDTH, self.view.height - self.mTopView.bottom - self.mBottomMenuV.height)];
            }
        } completion:^(BOOL finished) {
            if (completion_) {
                completion_(finished);
            }
        }];
    } else if (type_ == BottomAnimationTypeDisappear) {
        [UIView animateWithDuration:XSCUSTOMBASEVC_ANIMATION_DURATION delay:XSCUSTOMBASEVC_ANIMATION_DELAY options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
//            [self.mBottomMenuV setFrame:CGRectMake(0, K_SCREEN_HEIGHT , self.mBottomMenuV.width, self.mBottomMenuV.height)];
            if (self.mIsControlWithContentV) {
                [self.mContentView setFrame:CGRectMake(0, self.mTopView.bottom, K_SCREEN_WIDTH, self.view.height - self.mTopView.bottom)];
            }
        } completion:^(BOOL finished) {
            if (completion_) {
                completion_(finished);
            }
        }];
    }
}

- (void)setTitle:(NSString *)titleText_ {
    self.mTitleStr = titleText_;
    if (self.mTitleLabel != nil) {
        [self.mTitleLabel setHidden:NO];
        [self.mTitleLabel setText:self.mTitleStr];
    }
}

- (void)reSetCustomTitle:(UIView *)customView_ {
    [self.mTitleLabel setHidden:YES];
    customView_.tag = XSBOTTOMMENUV_RESETTITLE_OBJECT_ID;
    [customView_ setFrame:CGRectMake((self.mTopView.width - customView_.width)/2, (self.mTopView.height - customView_.height)/2 + K_SYSTEM_BAR/2, customView_.width, customView_.height)];
    [self.mTopView addSubview:customView_];
}

- (CGFloat)mBottomMenuHeight{
    return K_XMBOTTOMMENUV_HEIGHT;
}

#pragma mark LCBottomMenuVDelegate
- (void)bottomVDelegateButtonPressed:(XSBottomMenuVRootType)type_ controller:(id)controller_ {
    if (type_ == XSBottomMenuVTypeSell) {
//        [[XSNavigationProcessC sharedXMNavigationProcessC] initProcessRootViewController:controller_ completeProcess:^{}];
//        [[XSNavigationProcessC sharedXMNavigationProcessC] animation:XSNavigationProcessCTypeShow completion:^(BOOL finished) {}];
    } else {
//        self.mBottomMenuV = [XSTools getBottomMenuV];
//        [((XSCustomBaseVC *)controller_).view addSubview:self.mBottomMenuV];
        [APP_DELEGATE.mNavigationController setViewControllers:nil] ;
        [APP_DELEGATE.mNavigationController initWithRootViewController:controller_];        
    }
}

- (void)setbackGroundColor:(UIColor *)color_ {
    [self.mContentView setBackgroundColor:color_];
}
@end
