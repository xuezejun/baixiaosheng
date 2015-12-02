//
//  MyFriendsViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/20.
//  Copyright © 2015年 薛泽军. All rights reserved.
//

#import "MyFriendsViewController.h"
#import "ViewController.h"
@interface MyFriendsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (strong,nonatomic)NSIndexPath *myIndexPath;

@end

@implementation MyFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i=0;i<2;i++) {
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(WIDTH(WINDOW)*i,0,WIDTH(WINDOW),HEIGHT(self.scrollView)) style:UITableViewStylePlain];
        tableView.tag=100+i;
        tableView.delegate=self;
        tableView.dataSource=self;
        [self.scrollView addSubview:tableView];
    }
    self.scrollView.contentSize=CGSizeMake(WIDTH(WINDOW)*2,0);
    self.scrollView.pagingEnabled=YES;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)btuClick:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame=self.titleImageView.frame;
        frame.origin.x=WIDTH(WINDOW)/2*(sender.tag-1);
        self.titleImageView.frame=frame;
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    for (UITableView *tableView in self.scrollView.subviews) {
        NSLog(@"%@",self.scrollView.subviews);
        if ([tableView isKindOfClass:[UITableView class]]) {
            tableView.frame=CGRectMake(X(tableView),0,WIDTH(WINDOW),HEIGHT(WINDOW)-64-46);
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    if (tableView.tag==100) {
        cell.textLabel.text=@"关注";
    }else
    {
        cell.textLabel.text=@"粉丝";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ViewController *vc=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    vc.navigationItem.title=@"11";
    [self.navigationController pushViewController:vc animated:YES];
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
