//
//  LCUncaughtExceptionHandler.m
//  LeCai
//
//  Created by lehecaiminib on 13-3-27.
//
//

#import "XSUncaughtExceptionHandler.h"
NSString *applicationDocumentsDirectory() {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *urlStr = [NSString stringWithFormat:@"mailto://hexiaoguang@baidu.com?subject=bug报告&body=感谢您的配合!<br><br><br>"
                        "错误详情:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@",
                        name,reason,[arr componentsJoinedByString:@"<br>"]];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

@implementation XSUncaughtExceptionHandler

-(NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (void)setDefaultHandler {
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
    struct sigaction sigAction;
    
    sigAction.sa_sigaction = signalHandler;
    
    sigAction.sa_flags = SA_SIGINFO;
    
    sigemptyset(&sigAction.sa_mask);
    
    sigaction(SIGQUIT, &sigAction, NULL);
    
    sigaction(SIGILL, &sigAction, NULL);
    
    sigaction(SIGTRAP, &sigAction, NULL);
    
    sigaction(SIGABRT, &sigAction, NULL);
    
    sigaction(SIGEMT, &sigAction, NULL);
    
    sigaction(SIGFPE, &sigAction, NULL);
    
    sigaction(SIGBUS, &sigAction, NULL);
    
    sigaction(SIGSEGV, &sigAction, NULL);
    
    sigaction(SIGSYS, &sigAction, NULL);
    
    sigaction(SIGPIPE, &sigAction, NULL);
    
    sigaction(SIGALRM, &sigAction, NULL);
    
    sigaction(SIGXCPU, &sigAction, NULL);
    
    sigaction(SIGXFSZ, &sigAction, NULL);
}

+ (NSUncaughtExceptionHandler*)getHandler {
    return NSGetUncaughtExceptionHandler();
}

void signalHandler(int sig, siginfo_t *info, void *context) {
    NSException *exception = [NSException
                              exceptionWithName:@"UncaughtExceptionHandlerSignalExceptionName"
                              reason:
                              [NSString stringWithFormat:
                               NSLocalizedString(@"Signal %d was raised.\n"
                                                 , nil),
                               signal]
                              userInfo:
                              [NSDictionary
                               dictionaryWithObject:[NSNumber numberWithInt:sig]
                               forKey:@"UncaughtExceptionHandlerSignalKey"]];
    
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *urlStr = [NSString stringWithFormat:@"mailto://hexiaoguang@baidu.com?subject=bug报告&body=感谢您的配合!<br><br><br>"
                        "错误详情:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@",
                        name,reason,[arr componentsJoinedByString:@"<br>"]];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

@end


