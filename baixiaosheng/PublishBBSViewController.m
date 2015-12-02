//
//  PublishBBSViewController.m
//  Singapore
//
//  Created by 薛泽军 on 15/4/8.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "PublishBBSViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PulishCouReNaoCollectionViewCell.h"
#import "CocoaPickerViewController.h"
@interface PublishBBSViewController ()<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,CocoaPickerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *xinLangBtu;
@property (weak, nonatomic) IBOutlet UIButton *tengXunBtu;
@property (weak, nonatomic) IBOutlet UILabel *zhuTingLable;
@property (weak, nonatomic) IBOutlet UITextField *titleLable;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITableView *titleTableView;
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (strong,nonatomic)UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (strong,nonatomic)NSMutableArray *dataImageArray;
@property (strong,nonatomic)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIButton *typeBtu;
@property (strong,nonatomic)NSString *typeSring;
@property (strong,nonatomic)NSString *attachids;
@property (strong,nonatomic)NSMutableArray *assetsArray;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PublishBBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeSring=[[NSString alloc]init];
    self.typeSring=@"";
    
    
    self.attachids=[[NSString alloc]init];
    self.attachids=@"";
    
    
    IOS7_AND_LATER_ADAPTATION()
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing =1.0;
    layout.minimumInteritemSpacing =1.0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.collectionView setCollectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PulishCouReNaoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyDown) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    UIBarButtonItem *rightBii=[[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(rightBiiClick:)];
    self.navigationItem.rightBarButtonItem=rightBii;

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)titleBtuClick:(UIButton *)sender
{
    CGRect from=self.titleTableView.frame;
    from.origin.x=X(sender);
    from.origin.y=Y(sender)+HEIGHT(sender);
    from.size.width=WIDTH(sender);
    self.titleTableView.frame=from;
    if (from.size.height<=0)
    {
        from.size.height=44*5;
    }else
    {
        from.size.height=0;
    }
    [UIView animateWithDuration:.3 animations:^{
        self.titleTableView.frame=from;
    }];
}
- (IBAction)paiZhaoClick:(UIButton *)sender
{
 
}
- (IBAction)zhaoPianClick:(UIButton *)sender
{
   
}

- (void)rightBiiClick:(UIBarButtonItem *)bii
{
    if ([self.titleLable.text length]<=1) {
        [self.titleLable becomeFirstResponder];
        return;
    }
    if ([self.textView.text length]<=1||self.textView.textColor!=[UIColor blackColor]) {
        [self.textView becomeFirstResponder];
        return;
    }

}
- (void)upTieZiWith:(NSArray *)array
{
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{

    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{

}

- (void)keyChangeFrame:(NSNotification *)aNotification
{
    if ([self.textView.text isEqualToString:@"输入帖子内容"])
    {
        self.textView.selectedRange=NSMakeRange(0,0) ;   //起始位置
    }
        NSDictionary *info = [aNotification userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGSize keyboardSize = [value CGRectValue].size;
    
    
        float textViewH=HEIGHT(WINDOW)-64-keyboardSize.height-(self.textView.frame.origin.y+self.textView.frame.size.height);
        NSLog(@"%f~~~~%f~~~~%f",textViewH,HEIGHT(WINDOW)-64-keyboardSize.height,self.textView.frame.origin.y+self.textView.frame.size.height);
//        self.scrollView.contentSize=CGSizeMake(0,self.scrollView.frame.size.height+textViewH);
        CGRect from=self.view.frame;
        from.origin.y=textViewH;
        if (textViewH<0) {
        self.view.frame=from;
        }
        CGRect frome=self.downView.frame;
    if (textViewH<0) {
        frome.origin.y=HEIGHT(WINDOW)-64-keyboardSize.height-self.downView.frame.size.height+(64-textViewH);
    }else
    {
        frome.origin.y=HEIGHT(WINDOW)-64-keyboardSize.height-self.downView.frame.size.height;
    }
        [UIView animateWithDuration:.25 animations:^{
            self.downView.frame=frome;
    }];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.titleLable resignFirstResponder];
    [self.textView resignFirstResponder];
}
- (void)keyDown
{   CGRect from=self.view.frame;
    from.origin.y=64;
    self.view.frame=from;
    
    CGRect frome=self.downView.frame;
    frome.origin.y=HEIGHT(WINDOW)-64-0-self.downView.frame.size.height;
    [UIView animateWithDuration:.25 animations:^{
        self.downView.frame=frome;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cells";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    NSDictionary *dict=self.dataArray[indexPath.row];
    cell.textLabel.text=[NSString stringWithFormat:@"%@",dict[@"name"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict=self.dataArray[indexPath.row];
    self.zhuTingLable.text=dict[@"name"];
    self.typeSring=[NSString stringWithFormat:@"%@",dict[@"id"]];
    CGRect from=self.titleTableView.frame;
    from.size.height=0;
    [UIView animateWithDuration:.3 animations:^{
        self.titleTableView.frame=from;
    }];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    textView.textColor=[UIColor blackColor];
    if ([textView.text isEqualToString:@"输入帖子内容"]) {
        textView.text=@"";
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.text=@"输入帖子内容";
        textView.textColor=[UIColor grayColor];
    }
    return YES;
}
- (IBAction)fengXiangClick:(UIButton *)sender
{
    self.xinLangBtu.selected=NO;
    self.tengXunBtu.selected=NO;
    sender.selected=!sender.selected;
}
#define mark CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cell";
    PulishCouReNaoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    cell.remBtuClick.hidden=NO;
    if (indexPath.row==self.assetsArray.count)
    {
        cell.headImageView.image=[UIImage imageNamed:@"kuangl3.PNG"];
        cell.remBtuClick.hidden=YES;
    }else
    {
        
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(75*(WIDTH(WINDOW)/320),75*(WIDTH(WINDOW)/320)+5);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)[indexPath row]);
    [self.textView resignFirstResponder];
    if (indexPath.row==self.assetsArray.count) {
        [self composePicAdd];
    }
}
- (void)composePicAdd
{

    self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;//半透明
    CocoaPickerViewController *transparentView = [[CocoaPickerViewController alloc] init];
    transparentView.delegate = self;
    transparentView.modalPresentationStyle = UIModalPresentationOverFullScreen;
    transparentView.view.frame=self.view.frame;
    //        transparentView.view.superview.backgroundColor = [UIColor clearColor];
    [self presentViewController:transparentView animated:YES completion:nil];
}
- (void)CocoaPickerViewSendBackWithImage:(NSArray *)imageArray andString:(NSString *)str{

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
