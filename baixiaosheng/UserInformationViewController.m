//
//  UserInformationViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/16.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//
#define kWindowHeight 205.0f
#import "UserInformationViewController.h"
#import "UserInformationHeadView.h"
@interface UserInformationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)UserInformationHeadView *uihView;
@property (strong,nonatomic)UIView *titleView;

@end

@implementation UserInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
// 
//    self.uihView=[[NSBundle mainBundle]loadNibNamed:@"UserInformationHeadView" owner:nil options:nil][0];
//    self.uihView.frame=CGRectMake(0, 0,WIDTH(WINDOW),218);
//    NSLog(@"%f",WIDTH(WINDOW));
//    self.tableView.tableHeaderView=self.uihView;
//
//    UIBarButtonItem *rightBii=[[UIBarButtonItem alloc]initWithTitle:@"私信" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
//    self.navigationItem.rightBarButtonItem=rightBii;
//    
//    
//    self.titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW),64)];
//    UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(0,20, WIDTH(WINDOW), 44)];
//    l.textAlignment=NSTextAlignmentCenter;
//    l.text=@"薛泽军";
//    [self.titleView addSubview:l];
//    self.titleView.backgroundColor=[UIColor colorWithRed:0.39f green:0.80f blue:0.70f alpha:1.00f];
//    [self.view addSubview:self.titleView];
//    self.titleView.alpha=0;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:nil];
}
- (void)rightClick
{
    
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object!=nil) {
        CGPoint newOffset = [change[@"new"] CGPointValue];
        [self updateSubViewsWithScrollOffset:newOffset];
    }
}
-(void)updateSubViewsWithScrollOffset:(CGPoint)newOffset
{
    if (newOffset.y>(218-64*2-44)) {
        CGFloat alpha=(newOffset.y-(218-64*2-44))/44;
        self.titleView.alpha=alpha;
//        self.navigationItem.title=@"薛泽军";
//        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.39f green:0.80f blue:0.70f alpha:0.50f]];
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"未标题-3"] forBarMetrics:UIBarMetricsDefault];

//        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    }else
    {
//        self.titleView.alpha=0;
//        self.navigationItem.title=@"";
//        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"clearImage"]]];
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"clearImage"] forBarMetrics:UIBarMetricsDefault];
    }
}
- (void)headTapClick
{
  
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO];
    self.tableView.frame=CGRectMake(0,-64,WIDTH(WINDOW), HEIGHT(WINDOW)+64);
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
