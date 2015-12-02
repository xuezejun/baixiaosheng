//
//  SetUpViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/17.
//  Copyright © 2015年 薛泽军. All rights reserved.
//

#import "SetUpViewController.h"

@interface SetUpViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }else
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text=@"清除缓存";
                break;
            case 1:
                cell.textLabel.text=@"意见反馈";
                break;
            case 2:
                cell.textLabel.text=@"用户协议";
                break;
            default:
                break;
        }
    }else
    {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text=@"隐私";
                break;
            case 1:
                cell.textLabel.text=@"关于百校";
                break;
            case 2:
                cell.textLabel.text=@"";
                break;
            default:
                break;
        }
        
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
