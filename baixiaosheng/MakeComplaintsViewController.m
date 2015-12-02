//
//  MakeComplaintsViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/10/15.
//  Copyright © 2015年 薛泽军. All rights reserved.
//

#import "MakeComplaintsViewController.h"
#import "MakeComplaintsTableViewCell.h"
#import "PublishBBSViewController.h"
@interface MakeComplaintsViewController ()<UITableViewDataSource,UITableViewDelegate>
@end

@implementation MakeComplaintsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *rightBii=[[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(rightBiiClick:)];
    self.navigationItem.rightBarButtonItem=rightBii;
}
- (void)rightBiiClick:(UIBarButtonItem *)bii
{
    PublishBBSViewController *pbvc=[[PublishBBSViewController alloc]initWithNibName:@"PublishBBSViewController" bundle:nil];
    [self.navigationController pushViewController:pbvc animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cells";
    MakeComplaintsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"MakeComplaintsTableViewCell" owner:nil options:nil][0];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 166;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
