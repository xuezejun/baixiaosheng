//
//  LoginViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/8/31.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//
#import "LoginViewController.h"
#import "KrVideoPlayerController.h"
#import "RegViewController.h"
@interface LoginViewController ()
//@property (nonatomic, strong) KrVideoPlayerController  *videoController;
@property (weak, nonatomic) IBOutlet UITextField *telephoneText;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (weak, nonatomic) IBOutlet UIButton *loginBtu;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CircleWithView(self.loginBtu);
//    MPMusicPlayerController *mpc = [MPMusicPlayerController applicationMusicPlayer];
//    mpc.volume = 0;  //0.0~1.0    // Do any additional setup after loading the view from its nib.
}
- (BOOL)becText:(UITextField *)text
{
    if ([text.text isEqualToString:@""]) {
        [text becomeFirstResponder];
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)loginClick:(UIButton *)sender
{
    if (![self becText:self.telephoneText]) {
        return;
    };
    if (![self becText:self.passWordText]) {
        return;
    };
    NSMutableDictionary *pare=[NSMutableDictionary dictionary];
    [pare setValue:self.telephoneText.text forKey:@"uname"];
    [pare setValue:self.passWordText.text forKey:@"password"];
    [[NetworkRequest sharedNetworkRequest] postWithUrl:LOGIN andParData:pare success:^(id responseObject, int code) {
        NSLog(@"%@",responseObject);
        if (code==1) {
            [[NSUserDefaults standardUserDefaults] setValue:responseObject[@"imgpath"] forKey:@"imageurl"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NetworkRequest sharedNetworkRequest] PreservationUserInformation:responseObject[@"data"]];
            AppDelegate *app=[UIApplication sharedApplication].delegate;
            [app login];
//            super.videoController=nil;

        }else
        {
         
        }

    } failure:^(NSError *error) {
        
    }];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.videoController play];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self.videoController pause];

}
- (IBAction)regClick:(UIButton *)sender
{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"suckEffect";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
//    kCATransitionFromRight
    
//    self.view.hidden=YES;
    
    
    RegViewController *lvc=[[RegViewController alloc]initWithNibName:@"RegViewController" bundle:nil];
//    [self.view.window.layer addAnimation:animation forKey:nil];

    lvc.view.frame=WINDOW.frame;
    for (UIView *view in self.view.subviews) {
        if (view!=super.videoController.view) {
            view.hidden=YES;
        }
    }
    [self.view addSubview:lvc.view];
    lvc.back=^(BOOL isyes)
    {
        [lvc.view removeFromSuperview];
        for (UIView *view in self.view.subviews) {
//            if (view!=lvc.view||view!=super.videoController.view) {
                view.hidden=NO;
//            }
        }
    };
//    [self presentViewController:lvc animated:NO completion:^{
    
//    }];
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
