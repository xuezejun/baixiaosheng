
//
//  TheRegistrationViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/23.
//  Copyright © 2015年 薛泽军. All rights reserved.
//

#import "TheRegistrationViewController.h"
#import "HomeTableViewCell.h"
@interface TheRegistrationViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong,nonatomic)HomeTableViewCell *cell;
@property (strong,nonatomic)UIView *textVorF;

@end

@implementation TheRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.cell=[[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:nil options:nil][0];
//    self.cell.titleNameArray=[NSArray arrayWithObjects:@"1233123",@"123123123",@"",@"", nil];
    self.cell.myBtuSelect=^(NSInteger tag)
    {
       
    };
    [self.view addSubview:self.cell];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textVorF resignFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.cell.frame=CGRectMake(0,self.textView.frame.origin.y+HEIGHT(self.textView)+20, WIDTH(WINDOW),160);
    self.cell.downView.hidden=YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.textVorF=textField;
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.textVorF=textView;
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
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
