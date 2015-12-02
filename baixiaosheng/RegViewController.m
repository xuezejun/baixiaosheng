//
//  RegViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/7.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "RegViewController.h"
#import "JKCountDownButton.h"
#import "SchoolViewController.h"
@interface RegViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *regBtu;
@property (weak, nonatomic) IBOutlet UIButton *shoolBtu;
@property (weak, nonatomic) IBOutlet UIView *shoolView;
@property (strong,nonatomic)NSDictionary *shoolDict;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *nikeNameText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UITextField *telphoneText;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (weak, nonatomic) IBOutlet UITextField *turePassWordText;
@property (strong,nonatomic)UITextField *textField;
@property (weak, nonatomic) IBOutlet JKCountDownButton *codeButton;

@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CircleWithView(self.regBtu);
    CircleWithView(self.shoolView);
    self.scrollView.contentSize=CGSizeMake(0, 568);
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)shoolClick:(UIButton *)sender
{
    SchoolViewController *shvc=[[SchoolViewController alloc]initWithNibName:@"SchoolViewController" bundle:nil];
    shvc.view.frame=WINDOW.frame;
    for (UIView *view in self.view.subviews) {
        //        if (view!=super.videoController.view) {
        view.hidden=YES;
        //        }
    }
    [self.view addSubview:shvc.view];
    shvc.back=^(BOOL isyes,NSDictionary *dict)
    {
        NSLog(@"dict~~~%@",dict);
        [self.shoolBtu setTitle:dict[@"name"] forState:UIControlStateNormal];
        self.shoolDict=dict;
        [shvc.view removeFromSuperview];
        for (UIView *view in self.view.subviews) {
            //            if (view!=lvc.view||view!=super.videoController.view) {
            view.hidden=NO;
            //            }
        }
    };

}
- (IBAction)getCodeClick:(JKCountDownButton *)sender
{
    if (self.telphoneText.text.length<11) {
        return;
    }
    
    NSMutableDictionary *para=[NSMutableDictionary dictionary];
    [para setValue:self.telphoneText.text forKey:@"mobile"];
    [[NetworkRequest sharedNetworkRequest] postWithUrl:REGSITERYZM andParData:para success:^(id responseObject, int code) {
        sender.enabled = NO;
        //button type要 设置成custom 否则会闪动
        [sender startWithSecond:60];
        
        [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
            NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
            return title;
        }];
        [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"获  取";
        }];
    } failure:^(NSError *error) {
        
    }];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.textField=textField;
    return YES;
}
- (IBAction)scrollViewTap:(UITapGestureRecognizer *)sender
{
    [self.textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)regClick:(UIButton *)sender
{
    NSMutableDictionary *pare=[NSMutableDictionary dictionary];
    [pare setValue:self.nikeNameText.text forKey:@"nikename"];
    [pare setValue:self.telphoneText.text forKey:@"telephone"];
    [pare setValue:self.passWordText.text forKey:@"password"];
    [pare setValue:self.codeText.text forKey:@"code"];
    [pare addEntriesFromDictionary:self.shoolDict];
    [[NetworkRequest sharedNetworkRequest] postWithUrl:REGISTER andParData:pare success:^(id responseObject, int code) {
        NSLog(@"%@",responseObject);
        if (code==1) {
            [[NetworkRequest sharedNetworkRequest] PreservationUserInformation:responseObject[@"data"]];
            AppDelegate *app=[UIApplication sharedApplication].delegate;
            [app login];
        }else
        {
//              [[NetworkRequest sharedNetworkRequest] alertViewWithTitle:@"温馨提示" andMessage:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
    NSLog(@"%@",pare);
}
- (IBAction)backClick:(UIButton *)sender
{
    self.back(YES);
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
