//
//  LifeViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/1.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "LifeViewController.h"
#import "UserBusinessCardsViewController.h"
#import "LifeViewSelectBtu.h"
#import "SetUpViewController.h"
#import "LCActionSheet.h"
#import "MyReleaseViewController.h"
#import "MyActivityViewController.h"
#import "MyFriendsViewController.h"
#import "ViewController.h"
@interface LifeViewController ()<LCActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *downView;

@end

@implementation LifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.scrollView);
    self.scrollView.contentSize=CGSizeMake(0,568);
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    NSArray *array=[NSArray arrayWithObjects:@"我的发布",@"我的活动",@"我的组织",@"我的好友", nil];
    for (int i=0;i<array.count;i++) {
        LifeViewSelectBtu *lvs=[[NSBundle mainBundle]loadNibNamed:@"LifeViewSelectBtu" owner:nil options:nil][0];
        lvs.frame=CGRectMake((WIDTH(WINDOW)*0.8-220)/3*(i%2+1)+(i%2)*110,i/2*150+218,110,150);
        lvs.titleLable.text=array[i];
        lvs.titleBtu.tag=i;
        [lvs.titleBtu addTarget:self action:@selector(lvsClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:lvs];
        self.downView.frame=CGRectMake(X(self.downView),Y(lvs)+HEIGHT(lvs)+30, WIDTH(self.downView),HEIGHT(self.downView));
        self.scrollView.contentSize=CGSizeMake(0,Y(self.downView)+HEIGHT(self.downView)+30);
    }
    
}
- (void)lvsClick:(UIButton *)btn
{
    AppDelegate *app=[UIApplication sharedApplication].delegate;
    //    [app main];
    [app.menu showLeft:NO];
    UIViewController *userOrder;
    if (btn.tag==0) {
         userOrder=[[MyReleaseViewController alloc]initWithNibName:@"MyReleaseViewController" bundle:nil];
        userOrder.navigationItem.title=@"我的发布";
    }else if (btn.tag==1)
    {
        userOrder=[[MyActivityViewController alloc]initWithNibName:@"MyActivityViewController" bundle:nil];
        userOrder.navigationItem.title=@"我的活动";
    }else if (btn.tag==2)
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedIndex" object:@"2"];
        return;
    }else if(btn.tag==3)
    {
        userOrder=[[MyFriendsViewController alloc]initWithNibName:@"MyFriendsViewController" bundle:nil];
        userOrder.navigationItem.title=@"我的好友";
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushview" object:userOrder];

}
- (IBAction)signOutClick:(UIButton *)sender
{
    
    LCActionSheet *sheet = [LCActionSheet sheetWithTitle:@"退出登录部分信息将会清除"
                                            buttonTitles:@[@"退出登录"]
                                          redButtonIndex:0
                                                delegate:self];
    [sheet show];
}
- (void)actionSheet:(LCActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        AppDelegate *app=[UIApplication sharedApplication].delegate;
        [app main];
        [[NetworkRequest sharedNetworkRequest] PreservationUserInformation:nil];
    }
}
- (IBAction)headClick:(UIButton *)sender
{
    AppDelegate *app=[UIApplication sharedApplication].delegate;
//    [app main];
    [app.menu showLeft:NO];
//    UserBusinessCardViewController *userOrder=[[UserBusinessCardViewController alloc]initWithNibName:@"UserBusinessCardViewController" bundle:nil];
    UserBusinessCardsViewController *userOrder=[[UserBusinessCardsViewController alloc]initWithNibName:@"UserBusinessCardsViewController" bundle:nil];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushview" object:userOrder];
}
- (IBAction)setUp:(UIButton *)sender{
    AppDelegate *app=[UIApplication sharedApplication].delegate;
    //    [app main];
    [app.menu showLeft:NO];
    SetUpViewController *userOrder=[[SetUpViewController alloc]initWithNibName:@"SetUpViewController" bundle:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushview" object:userOrder];
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
