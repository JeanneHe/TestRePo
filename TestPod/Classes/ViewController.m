//
//  ViewController.m
//  test
//
//  Created by 何晓光 on 2018/9/13.
//  Copyright © 2018年 HXG. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "MYViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//    [temp setBackgroundColor:[UIColor blackColor]];
//    [temp sd_setImageWithURL:[NSURL URLWithString:@"http://icon.58pic.com/wangEditImg/2018/09/06/17/64bcdea8929bddc3303a0cb1ac394eee.jpg"]];
//    //    http://img.91sph.com/goods//20180830//006c3e6c4c2944fc8b81d4eb3920077d_s1.jpg
//    [self.view addSubview:temp];
//    temp = nil;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    MYViewController *temp = [MYViewController new];
    [self presentViewController:temp animated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
