//
//  BaseViewController.m
//  emreal
//
//  Created by 薛泽军 on 15/4/20.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "BaseViewController.h"
#import "SearchViewController.h"
#import "TheNewsTableViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IOS7_AND_LATER_ADAPTATION()
    // Do any additional setup after loading the view.
}
- (void)navigationView
{
    
    UIImageView* shopCariv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30,30)];\
    shopCariv.image = [UIImage imageNamed:@"newlyBuild"];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shopCarClick)];
    [shopCariv addGestureRecognizer:tap];
    UIBarButtonItem* shopCarBut = [[UIBarButtonItem alloc]initWithCustomView:shopCariv];
    
    UIImageView* useriv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];\
    useriv.image = [UIImage imageNamed:@"search"];
    UITapGestureRecognizer* Cameratap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cameraClick)];
    [useriv addGestureRecognizer:Cameratap];
    UIBarButtonItem* userBtn = [[UIBarButtonItem alloc]initWithCustomView:useriv];
    
    
    UIImageView* homeiv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];\
    homeiv.image = [UIImage imageNamed:@"message"];
    UITapGestureRecognizer* hometap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(homeClick)];
    [homeiv addGestureRecognizer:hometap];
    UIBarButtonItem* homeBut = [[UIBarButtonItem alloc]initWithCustomView:homeiv];
    
    
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:userBtn,homeBut, nil];
    
    
    UIImageView* loginiv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,30, 30)];\
    loginiv.image = [UIImage imageNamed:@"headimage"];
    UITapGestureRecognizer* usertap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userClick)];
    [loginiv addGestureRecognizer:usertap];
    UIBarButtonItem* loginBut = [[UIBarButtonItem alloc]initWithCustomView:loginiv];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,100,44)];
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:15];
    
    label.text=[[NetworkRequest sharedNetworkRequest] userInformation][@"schoolname"];
    UIBarButtonItem* schoolBii= [[UIBarButtonItem alloc]initWithCustomView:label];
    self.navigationItem.leftBarButtonItems=@[loginBut,schoolBii];
    
    
    NSLog(@"%@",[[NetworkRequest sharedNetworkRequest] userInformation]);
}
- (void)userClick
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.menu showLeft:!delegate.menu.isShowing];
}
- (void)shopCarClick
{
    
}
- (void)cameraClick
{
    SearchViewController *svc=[[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:nil];
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
- (void)homeClick
{
    TheNewsTableViewController *svc=[[TheNewsTableViewController alloc]initWithNibName:@"TheNewsTableViewController" bundle:nil];
    svc.navigationItem.title=@"消息";
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
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
