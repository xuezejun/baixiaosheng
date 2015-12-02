//
//  ForumViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/8/31.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "ForumViewController.h"
#import "ForumViewTableViewCell.h"
#import "ConfidantesGirlsViewController.h"
#import "MakeComplaintsViewController.h"
#import "ConfessionWallViewController.h"
@interface ForumViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ForumViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShortcutItem:) name:SHORTITEM object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [super navigationView];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.view];
        
    }
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}
- (void)ShortcutItem:(NSNotification *)aNotification
{
    if (aNotification.object!=nil&&[aNotification.object intValue]==3)
    {
        [self pushConfidante];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cells";
    ForumViewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"ForumViewTableViewCell" owner:nil options:nil][0];
        
    }
    cell.headImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"forum%ld",(long)indexPath.section+1]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 124;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1) {
        [self pushConfidante];
    }else if (indexPath.section==0)
    {
        MakeComplaintsViewController *mcvc=[[MakeComplaintsViewController alloc]initWithNibName:@"MakeComplaintsViewController" bundle:nil];
        mcvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:mcvc animated:YES];
        self.hidesBottomBarWhenPushed=NO;
;
    }else if (indexPath.section==2)
    {
        ConfessionWallViewController *cwvc=[[ConfessionWallViewController alloc]initWithNibName:@"ConfessionWallViewController" bundle:nil];
        cwvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:cwvc animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
}
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    
    //通过当前点按的位置拿到当前 tableview 的行号，此处实现 peek 动作
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    ForumViewTableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section==2) {
        ConfessionWallViewController *cwvc=[[ConfessionWallViewController alloc]initWithNibName:@"ConfessionWallViewController" bundle:nil];
        cwvc.preferredContentSize=CGSizeMake(0,568);
        previewingContext.sourceRect = cell.frame;
        return cwvc;
    }else if (indexPath.section==0)
    {
        MakeComplaintsViewController *mcvc=[[MakeComplaintsViewController alloc]initWithNibName:@"MakeComplaintsViewController" bundle:nil];
        mcvc.preferredContentSize=CGSizeMake(0,568);
        previewingContext.sourceRect = cell.frame;
        return mcvc;
    }else
    {
        ConfidantesGirlsViewController *cfdvc=[[ConfidantesGirlsViewController alloc]initWithNibName:@"ConfidantesGirlsViewController" bundle:nil];
        cfdvc.preferredContentSize=CGSizeMake(0,568);
        previewingContext.sourceRect = cell.frame;
        return cfdvc;
    }
    return nil;
}
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    
    
    
    UIPreviewAction *p1 =[UIPreviewAction actionWithTitle:@"分享" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
//        NSLog(@'点击了分享');
    
    }];
    
    
    
    UIPreviewAction *p2 =[UIPreviewAction actionWithTitle:@"收藏'" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
//        NSLog(@'点击了收藏');
        
    }];
    
    
    
    NSArray *actions = @[p1,p2];

    return actions;
    
}
- (void)pushConfidante
{
    ConfidantesGirlsViewController *cfdvc=[[ConfidantesGirlsViewController alloc]initWithNibName:@"ConfidantesGirlsViewController" bundle:nil];
    cfdvc.navigationItem.title=@"闺蜜坊";
    UINavigationController *nvc=[[UINavigationController alloc]initWithRootViewController:cfdvc];
    [nvc.navigationBar setBarTintColor:[UIColor redColor]];
    nvc.navigationBar.translucent=NO;
    [nvc.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor,[UIColor whiteColor],UITextAttributeTextShadowColor, nil]];
    [self presentViewController:nvc animated:YES completion:^{
        
    }];
//    [self.navigationController pushViewController:cfdvc animated:YES];
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
