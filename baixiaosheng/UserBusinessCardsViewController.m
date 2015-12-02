//
//  UserBusinessCardsViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/17.
//  Copyright © 2015年 薛泽军. All rights reserved.
//

#import "UserBusinessCardsViewController.h"
#import "LCActionSheet.h"
@interface UserBusinessCardsViewController ()<UITextFieldDelegate,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,LCActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *preservationBtu;
@property (strong,nonatomic)UIView *myText;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLable;
@property (weak, nonatomic) IBOutlet UITextField *nikeLable;
@property (weak, nonatomic) IBOutlet UITextField *nameLable;
@property (weak, nonatomic) IBOutlet UITextField *shoolLable;
@property (weak, nonatomic) IBOutlet UITextField *birthday;
@property (weak, nonatomic) IBOutlet UILabel *constellationLable;
@property (weak, nonatomic) IBOutlet UITextView *signatureTextView;


@property (strong,nonatomic)UIDatePicker *datePicker;

@end

@implementation UserBusinessCardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CircleWithView(self.preservationBtu);
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImageClick)];
    [self.headImageView addGestureRecognizer:tap];
    self.headImageView.userInteractionEnabled=YES;
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.minuteInterval = 30;
    [self.datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
    
    [self.birthday setInputView:self.datePicker];
    // Do any additional setup after loading the view from its nib.
}
- (void)chooseDate:(UIDatePicker *)sender {
    self.constellationLable.text=[[NetworkRequest sharedNetworkRequest] getXingzuo:sender.date];
    NSDate *selectedDate = sender.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateString = [formatter stringFromDate:selectedDate];
    self.birthday.text = dateString;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.scrollView.contentSize=CGSizeMake(0,568);
    NSLog(@"%@",self.scrollView);
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.myText=textField;
    if (textField==self.shoolLable) {
        return NO;
    }
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.myText=textView;
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.myText resignFirstResponder];
}
- (IBAction)keyDown:(id)sender
{
    [self.myText resignFirstResponder];
}
- (void)headImageClick
{
    LCActionSheet *sheet = [LCActionSheet sheetWithTitle:nil
                                            buttonTitles:@[@"拍照",@"相机"]
                                          redButtonIndex:-1
                                                delegate:self];
    [sheet show];
}
- (void)actionSheet:(LCActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self takePhoto];
    }else if (buttonIndex==1)
    {
        [self LocalPhoto];
    }

}
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentModalViewController:picker animated:YES];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    NSLog(@"%@",info);
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image,0.5);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        //        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //
        //        //文件管理器
        //        NSFileManager *fileManager = [NSFileManager defaultManager];
        //
        //        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        //        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        //        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        //
        //        //得到选择后沙盒中图片的完整路径
        //       filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        [picker dismissModalViewControllerAnimated:YES];
//        [[NetworkRequest sharedNetworkRequest] postWithUrl:QINIUTOKEN andParData:nil success:^(id responseObject) {
//            NSLog(@"%@",responseObject);
//            if ([responseObject[@"code"] intValue]==1) {
//                QNUploadManager *upManager = [[QNUploadManager alloc] init];
//                NSData *imageData = UIImageJPEGRepresentation(image,0.5);
//                // NSLog(@"token~~~%@~~~~image%@",token,imageData);
//                [upManager putData:imageData key:nil token:responseObject[@"data"] complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                    NSLog(@"info~~~%@",info);
//                    NSLog(@"resp~~~%@",resp);
//                    [self editMemberWithImageName:resp[@"hash"] andWithName:userInformation[@"username"]];
//                } option:nil];
//            }
//        } failure:^(NSError *error) {
//            NSLog(@"%@",error);
//        }];
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        self.headImageView.image = image;
        //加在视图中
    }
    
}
- (IBAction)sexClick:(UIButton *)sender
{
    for (UIButton *btu in sender.superview.subviews) {
        if ([btu isMemberOfClass:[UIButton class]]) {
            btu.selected=NO;
        }
    }
    sender.selected=!sender.selected;
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
