//
//  HSSTabbarViewController.m
//  HundredSchoolStudents
//
//  Created by 薛泽军 on 15/6/30.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "HSSTabbarViewController.h"
#import "MyNavigationController.h"
@interface HSSTabbarViewController ()
@property (strong,nonatomic)NSArray *titleName;

@end

@implementation HSSTabbarViewController
{
   UIImageView *imageView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleName=[NSArray arrayWithObjects:@"首页",@"今日",@"组织",@"论坛", nil];


    [self inic];

    
    imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"caidanlanbeijing_12"]];
    imageView.backgroundColor=[UIColor whiteColor];
    imageView.frame=CGRectMake(0,0,self.view.frame.size.width,49+18);
    self.tabBar.barTintColor=[UIColor clearColor];
    imageView.userInteractionEnabled=YES;
    
    
    
    self.tabBar.backgroundImage =[UIImage new];
    //    self.tabBar.backgroundColor =[UIColor clearColor];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    NSArray *array = [NSArray arrayWithObjects:@"tabs1.png", @"tabs2.png", @"tabs3.png", @"tabs4.png", nil];
    NSArray *array2 = [NSArray arrayWithObjects:@"tab1.png", @"tab2.png", @"tab3.png", @"tab4.png", nil];
    double width = self.view.frame.size.width/4;
    for (int i=0;i<4;i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width,0,width,49);
        if (i==6) {
            button.frame = CGRectMake(i*width+(width-30)/2,-3,30,49-8);
        }
        button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        button.backgroundColor = [UIColor clearColor];

        //点击Btn没有闪动
        button.adjustsImageWhenHighlighted = NO;
        button.tag = i+1500;
        
        
        UIButton *xiaoButton=[UIButton buttonWithType:UIButtonTypeCustom];
        xiaoButton.frame = CGRectMake(i*width+(width-25)/2,5,25,25);
        [xiaoButton setImage:[UIImage imageNamed:[array objectAtIndex:i]] forState:UIControlStateNormal];
        [xiaoButton setImage:[UIImage imageNamed:[array2 objectAtIndex:i]] forState:UIControlStateSelected];
        xiaoButton.tag=i+1000;
        [button addTarget:self action:@selector(OnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(i*width,30,width,20)];
        lable.tag=i+500;
        lable.font=[UIFont systemFontOfSize:12];
        lable.text=self.titleName[i];
        lable.textAlignment=NSTextAlignmentCenter;
        [imageView addSubview:lable];
        [imageView addSubview:xiaoButton];
        [imageView addSubview:button];
        //让第一个成为选中状态
        if (button.tag ==1500) {
            button.selected =YES;
            lable.textColor=[UIColor colorWithRed:0.39f green:0.80f blue:0.70f alpha:1.00f];
            xiaoButton.selected=YES;
        }
    }
    [self.tabBar addSubview:imageView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNewView:) name:@"pushview" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selected:) name:@"selectedIndex" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShortcutItem:) name:SHORTITEM object:nil];
    self.selectedIndex=[BaiXiaoShengStandard baiXiaostandard].selectedIndex;
    // Do any additional setup after loading the view.
}
- (void)ShortcutItem:(NSNotification *)aNotification
{
    if (aNotification.object!=nil)
    {
        self.selectedIndex=[aNotification.object intValue];
    }
}
- (void)selected:(NSNotification *)aNotification
{
    NSLog(@"111~~~~%@",aNotification.object);
    self.selectedIndex=[aNotification.object intValue];
}
- (void)pushNewView:(NSNotification *)aNotification
{
    UIViewController *vc=(UIViewController *)aNotification.object;
    vc.hidesBottomBarWhenPushed=YES;
    [self.viewControllers[self.selectedIndex] pushViewController:aNotification.object animated:YES];
    self.viewControllers[self.selectedIndex].hidesBottomBarWhenPushed=NO;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
}
- (void)inic
{
    NSMutableArray *vcs=[NSMutableArray array];
    NSMutableArray *vcsName=[NSMutableArray arrayWithObjects:@"Home",@"Today",@"Organization",@"Forum", nil];
    for (int i=0;i<vcsName.count;i++) {
        UIViewController *vc=[[NSClassFromString([NSString stringWithFormat:@"%@ViewController",vcsName[i]]) alloc]initWithNibName:[NSString stringWithFormat:@"%@ViewController",vcsName[i]] bundle:nil];
        MyNavigationController *mnvc=[[MyNavigationController alloc]initWithRootViewController:vc];
        vc.navigationItem.title=self.titleName[i];
        [vcs addObject:mnvc];
    }
    self.viewControllers=vcs;
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    NSLog(@"~~~~~%lu",(unsigned long)selectedIndex);
    for (UIButton *BTU in imageView.subviews) {
        if ([BTU isKindOfClass:[UIButton class]]) {
            BTU.selected=NO;
        }
    }
    for (UILabel *lab in imageView.subviews) {
        if ([lab isKindOfClass:[UILabel class]]) {
            lab.textColor=[UIColor blackColor];
        }
    }
    UILabel *l=(UILabel *)[imageView viewWithTag:selectedIndex+500];
    if (l) {
        l.textColor=[UIColor colorWithRed:0.39f green:0.80f blue:0.70f alpha:1.00f];
    }
    UIButton *b=(UIButton *)[imageView viewWithTag:selectedIndex+1000];
    if (b) {
        b.selected =YES;
    }
    [self setSelectedViewController:[[self viewControllers] objectAtIndex:selectedIndex]];
//    self.las=selectedIndex;
}
//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    
//    self.selectedIndex = [tabBar.items indexOfObject:item];
//    
//}
- (void)OnBtnClick:(UIButton *)btu
{
    
//    for (UIButton *BTU in btu.superview.subviews) {
//        if ([BTU isKindOfClass:[UIButton class]]) {
//            BTU.selected=NO;
//        }
//    }
//    for (UILabel *lab in btu.superview.subviews) {
//        if ([lab isKindOfClass:[UILabel class]]) {
//            lab.textColor=[UIColor blackColor];
//        }
//    }
    self.selectedIndex=btu.tag-1500;
//
//    UILabel *l=(UILabel *)[btu.superview viewWithTag:btu.tag-1000];
//    l.textColor=[UIColor colorWithRed:0.39f green:0.80f blue:0.70f alpha:1.00f];
//    UIButton *b=(UIButton *)[btu.superview viewWithTag:btu.tag-500];
//    b.selected =!b.selected;
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
