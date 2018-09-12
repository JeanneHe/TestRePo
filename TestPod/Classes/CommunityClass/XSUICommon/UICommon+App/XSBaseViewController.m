//
//  LCBaseViewController.m
//  LeCai
//
//  Created by HXG on 11/19/14.
//
//

#import "XSBaseViewController.h"

@interface XSBaseViewController ()

@end

@implementation XSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    
//    NSString *className = NSStringFromClass([self class]);
//    
//    Class class_ = [self class];
//    
    //NSString *temp = [self returnPageName];
    
    //[XSAnalysisManager SensorsAnalyticsButtonClickWithScreenName:nil buttonName:@"00" targetScreenName:@""];
    
    NSLog(@"\n*******************\n *******************\n *******************className: %@\n *******************\n *******************",NSStringFromClass([self class]));
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [MOAspects hookInstanceMethodForClass:[self class] selector:NSSelectorFromString(@"viewDidAppear:") aspectsPosition:MOAspectsPositionBefore usingBlock:^(id object){
//        [MobClick endLogPageView:[self XSUMengPageIdentifier]];
//    }];
}

#pragma mark - private
- (NSString *)returnPageName{
    return @"";
}

#pragma mark - public & override
- (NSString *)XSUMengPageIdentifier
{
    return NSStringFromClass([self class]);
}

@end
