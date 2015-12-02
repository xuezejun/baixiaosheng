//
//  LoginBaseViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/7.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "LoginBaseViewController.h"
#import "AppDelegate.h"
@interface LoginBaseViewController ()

@end

@implementation LoginBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playVideo];
    [self.view sendSubviewToBack:self.videoController.view];
    // Do any additional setup after loading the view from its nib.
}
- (void)playVideo{
    //    NSURL *url = [NSURL URLWithString:@"http://krtv.qiniudn.com/150522nextapp"];
    //    NSURL *url = [NSURL URLWithString:@"張惠妹精選1.mp4"];
    //    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *file = [[NSBundle mainBundle] pathForResource:@"IMG_0835" ofType:@"MOV"];      NSLog(@"%@",[NSBundle mainBundle]);
    
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"我的影片 2" ofType:@"mp4"];
    NSLog(@"%@",file);
    NSURL *movieURL = [NSURL fileURLWithPath:file];
    [self addVideoPlayerWithURL:movieURL];
}

- (void)addVideoPlayerWithURL:(NSURL *)url{
//    self.videoController=nil;
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat heght=[UIScreen mainScreen].bounds.size.height;
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:CGRectMake(-(heght*2-width)/2,0, heght*2,heght)];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController setWillBackOrientationPortrait:^{
            [weakSelf toolbarHidden:NO];
        }];
        [self.videoController setWillChangeToFullscreenMode:^{
            [weakSelf toolbarHidden:YES];
        }];
        [self.view addSubview:self.videoController.view];
    }
    self.videoController.contentURL = url;
}
//隐藏navigation tabbar 电池栏
- (void)toolbarHidden:(BOOL)Bool{
    //    self.navigationController.navigationBar.hidden = Bool;
    self.tabBarController.tabBar.hidden = Bool;
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
