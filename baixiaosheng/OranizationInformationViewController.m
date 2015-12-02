//
//  OranizationInformationViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/10.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "OranizationInformationViewController.h"
#import "ToDayTableViewCell.h"
#import "MemberCollectionViewCell.h"
#import "OrganizationInformationTableViewCell.h"
#import "OranizationInformationDataHeadView.h"
#import "UILabel+StringFrame.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "LCActionSheet.h"
#import "BusinessCard.h"
@interface OranizationInformationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,ABNewPersonViewControllerDelegate,LCActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *organizationTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *fansLable;
@property (weak, nonatomic) IBOutlet UIScrollView *titleView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic)UITableView *activityTableView;
@property (strong,nonatomic)UICollectionView *membersCollectionView;
@property (strong,nonatomic)UITableView *dataTableView;
@property (strong,nonatomic)UITableView *messageBoardTableView;


@property (strong,nonatomic)NSMutableDictionary *dataDict;

@property (strong,nonatomic)NSMutableArray *dataDepartArray;
@property (strong,nonatomic)NSMutableArray *activityArray;
@property (strong,nonatomic)NSMutableArray *memebersArray;
@property (strong,nonatomic)NSMutableArray *messageBoardArray;

@end

@implementation OranizationInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array=[NSMutableArray arrayWithObjects:@"活动",@"成员",@"资料",@"留言板", nil];
    for (int i=0;i<4;i++) {
        UIButton *btu=[UIButton buttonWithType:UIButtonTypeCustom];
        btu.frame=CGRectMake(i*(WIDTH(WINDOW)/4)-2,0,WIDTH(WINDOW)/4+4,HEIGHT(self.titleView));
        btu.tag=100+i;
        [btu setTitle:array[i] forState:UIControlStateNormal];
        [btu setTitle:array[i] forState:UIControlStateSelected];
        [btu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btu setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btu addTarget:self action:@selector(titleViewClick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(i*(WIDTH(WINDOW)/4)-1,10, 1, HEIGHT(self.titleView)-20)];
        lable.backgroundColor=[UIColor grayColor];
        if (i==0) {
            btu.backgroundColor=[UIColor greenColor];
        }
        [self.titleView addSubview:btu];
        [self.titleView addSubview:lable];
        [self.titleView sendSubviewToBack:lable];
    }

    
#warning "活动"
    self.activityTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,WIDTH(WINDOW),HEIGHT(self.scrollView))];
    self.activityTableView.delegate=self;
    self.activityTableView.dataSource=self;
    self.activityTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:self.activityTableView];
#warning @"成员"
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
//        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.membersCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(WIDTH(WINDOW),0,WIDTH(WINDOW),HEIGHT(self.scrollView))collectionViewLayout:flowLayout];
    self.membersCollectionView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.membersCollectionView.dataSource=self;
    self.membersCollectionView.delegate=self;
    [self.scrollView addSubview:self.membersCollectionView];
    [self.membersCollectionView registerNib:[UINib nibWithNibName:@"MemberCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell2"];

    [self.membersCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];

#warning @"资料"
    self.dataTableView=[[UITableView alloc]initWithFrame:CGRectMake(WIDTH(WINDOW)*2,0,WIDTH(WINDOW),HEIGHT(self.scrollView))];
    self.dataTableView.delegate=self;
    self.dataTableView.dataSource=self;
    [self.scrollView addSubview:self.dataTableView];
#warning @"留言"
    self.messageBoardTableView=[[UITableView alloc]initWithFrame:CGRectMake(WIDTH(WINDOW)*3,0,WIDTH(WINDOW),HEIGHT(self.scrollView))];
    self.messageBoardTableView.delegate=self;
    self.messageBoardTableView.dataSource=self;
    self.messageBoardTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:self.messageBoardTableView];
#warning @"scrollView";
    self.scrollView.contentSize=CGSizeMake(WIDTH(WINDOW)*4, 0);
    self.scrollView.pagingEnabled=YES;
    
    
    
    NSMutableDictionary *pare=[[[NetworkRequest sharedNetworkRequest] userTokenDict] mutableCopy];
    [pare setValue:self.clubId forKey:@"clubid"];
    [[NetworkRequest sharedNetworkRequest] postWithUrl:CLUBINFOR andParData:pare success:^(id responseObject, int code) {
        NSLog(@"clubinfo~~%@",responseObject);
        NSDictionary *dict=responseObject[@"data"];
        self.dataDict=[dict mutableCopy];
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,dict[@"clubpic"]]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    self.organizationTitleLable.text=NSStringWithFormat(dict[@"name"]);
        self.fansLable.text=[NSString stringWithFormat:@"%@人关注",dict[@"peoplenum"]];
        
        
        self.activityArray=responseObject[@"event"];
        [self.activityTableView reloadData];
        
        
        self.memebersArray=responseObject[@"member"];
        [self.membersCollectionView reloadData];
        
        self.dataDepartArray=dict[@"depart"];
        [self.dataTableView reloadData];
        
        
        self.messageBoardArray=responseObject[@"message"];
        [self.messageBoardTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (IOS9_AND_LATER) {
        self.scrollView.frame=CGRectMake(0,Y(self.scrollView),WIDTH(self.scrollView),HEIGHT(WINDOW)-Y(self.scrollView)-64); 
    }
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UITableView class]]||[view isKindOfClass:[UICollectionView class]]) {
            CGRect viewFrom=view.frame;
            viewFrom.size.height=HEIGHT(self.scrollView);
            view.frame=viewFrom;
        }
    }
    DOFavoriteButton *dofb=[[DOFavoriteButton alloc]initWithFrame:CGRectMake(WIDTH(WINDOW)-60-5,37-5,49,49) image:[UIImage imageNamed:@"star"] imageFrame:CGRectMake(12,12,25,25)];
//    dofb.backgroundColor=[UIColor greenColor];
    dofb.imageColorOn =[UIColor colorWithRed:45/255 green:204/255 blue:112/255 alpha:1.0];
    dofb.circleColor =[UIColor colorWithRed:45/255 green:204/255 blue:112/255 alpha:1.0];
    dofb.lineColor = [UIColor colorWithRed:45/255 green:195/255 blue:106/255 alpha:1.0];
    //    dofb.frame=CGRectMake(WIDTH(WINDOW)-60,37,35,35);
    [dofb addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dofb];
}
- (void)addClick:(DOFavoriteButton *)sender
{
    if (sender.selected) {
        [sender deselect];
    } else {
        [sender select];
    }
}
#define mark uitableview
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.dataTableView) {
        return 52;
    }else
    {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==self.dataTableView) {
        OranizationInformationDataHeadView *oidh=[[NSBundle mainBundle]loadNibNamed:@"OranizationInformationDataHeadView" owner:nil options:nil][0];
        CircleWithView(oidh.brackLable);
        if (section==0) {
            oidh.titleLable.text=@"社团简介";
        }else if (section==1)
        {
            oidh.titleLable.text=@"部门信息";
        }else
        {
            oidh.titleLable.text=@"联系信息";
        }
        return oidh;
    }else
    {
        return nil;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.dataTableView) {
        return 3;
    }else
    {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.activityTableView==tableView) {
        return self.activityArray.count;
    }else if (self.dataTableView==tableView)
    {
        if (section==1) {
            return self.dataDepartArray.count;
        }else
        {
            return 1;
        }
    }else
    {
    return self.messageBoardArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.activityTableView) {
    static NSString *cellName=@"cell";
    ToDayTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[NSBundle mainBundle] loadNibNamed:@"ToDayTableViewCell" owner:nil options:nil][0];
    }
    NSDictionary *dict=self.activityArray[indexPath.row];
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,dict[@"eventpic"]]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
    }];
        cell.titleLable.text=NSStringWithFormat(dict[@"name"]);
        cell.addressLable.text=[NSString stringWithFormat:@"地点:%@",dict[@"address"]];
    return cell;
    }else if (self.dataTableView==tableView)
    {
        static NSString *cellName=@"cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 0,WIDTH(WINDOW)-20,HEIGHT(cell))];
            lable.tag=100;
            lable.numberOfLines=0;
            lable.font=[UIFont systemFontOfSize:17];
            [cell.contentView addSubview:lable];
        }
        UILabel *lable=(UILabel *)[cell.contentView viewWithTag:100];
        lable.text=@"";
        cell.textLabel.text=@"";
        lable.frame=CGRectMake(10, 0,WIDTH(WINDOW)-20,HEIGHT(cell));
        if (indexPath.section==1) {
            NSDictionary *dict=self.dataDepartArray[indexPath.row];
            NSString *title=[NSString stringWithFormat:@"%@:",dict[@"title"]];
            cell.textLabel.text=title;
            CGFloat width;
            width=[self boundingRectWithSize:cell.textLabel.frame.size WithFont:cell.textLabel.font WithText:title].width;
            UILabel *lable=(UILabel *)[cell.contentView viewWithTag:100];
            CGRect frome=lable.frame;
            frome.origin.x=width+20;
            frome.size.width=WIDTH(WINDOW)-30-width;
            NSString *explain=[NSString stringWithFormat:@"%@",dict[@"explain"]];
            CGSize s = [self calculateSize:CGSizeMake(WIDTH(WINDOW)-30-width, FLT_MAX) font:lable.font WithString:explain];
            lable.text=explain;
            frome.size.height=s.height;
            lable.frame=frome;
            
          
        }else if (indexPath.section==0)
        {
            UILabel *lable=(UILabel *)[cell.contentView viewWithTag:100];
            NSString *information=[NSString stringWithFormat:@"         %@",self.dataDict[@"content"]];
            lable.text=information;
            CGSize s = [self calculateSize:CGSizeMake(WIDTH(WINDOW)-20, FLT_MAX) font:lable.font WithString:information];
            CGRect frome=lable.frame;
//            cell.textLabel.backgroundColor=[UIColor clearColor];
            frome.size.height=s.height+10;
            lable.frame=frome;
        }else
        {
            cell.textLabel.text=[NSString stringWithFormat:@"%@:%@",self.dataDict[@"user"],self.dataDict[@"usertel"]];
        }
        return cell;
    }else
    {
        static NSString *cellName=@"cells";
        OrganizationInformationTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell==nil) {
            cell=[[NSBundle mainBundle] loadNibNamed:@"OrganizationInformationTableViewCell" owner:nil options:nil][0];
        }
        NSDictionary *dict=self.messageBoardArray[indexPath.row];
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,dict[@"headpic"]]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        cell.titleLable.text=NSStringWithFormat(dict[@"nickname"]);
        cell.contentLable.text=NSStringWithFormat(dict[@"content"]);
        cell.timeLable.text=[[NetworkRequest sharedNetworkRequest] baseTimeString:dict[@"time"]];
        return cell;
    }
}
- (CGSize)boundingRectWithSize:(CGSize)size WithFont:(UIFont *)font WithText:(NSString *)text
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize retSize = [text boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    return retSize;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.activityTableView)
    {
        return 135;
    }else if (self.dataTableView==tableView)
    {
        if (indexPath.section==0) {
        NSString *information=[NSString stringWithFormat:@"     %@",self.dataDict[@"content"]];
        CGSize s = [self calculateSize:CGSizeMake(WIDTH(WINDOW)-20, FLT_MAX) font:[UIFont systemFontOfSize:17] WithString:information];
            return 13+s.height;
        }else if(indexPath.section==1)
        {
            NSDictionary *dict=self.dataDepartArray[indexPath.row];
            NSString *title=[NSString stringWithFormat:@"%@:",dict[@"title"]];
            CGFloat width;
            width=[self boundingRectWithSize:CGSizeMake(1000,50) WithFont:[UIFont systemFontOfSize:17] WithText:title].width;
            NSString *explain=[NSString stringWithFormat:@"%@",dict[@"explain"]];
            CGSize s = [self calculateSize:CGSizeMake(WIDTH(WINDOW)-30-width, FLT_MAX) font:[UIFont systemFontOfSize:17] WithString:explain];
            NSLog(@"%f~~~%f",width,s.height);
            return s.height;

        }
        return 44;
    }else
    {
        return 82;
    }
}
- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font WithString:(NSString *)string{
    CGSize expectedLabelSize = CGSizeZero;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        //        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle.copy,NSParagraphStyleAttributeName, nil];
        expectedLabelSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    else {
        expectedLabelSize = [string sizeWithFont:font
                               constrainedToSize:size
                                   lineBreakMode:NSLineBreakByWordWrapping];
    }
    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //在这里呼出下方菜单按钮项
    if (self.dataTableView==tableView)
    {
        
        if (indexPath.section==2)
        {
//            UIActionSheet *myActionSheet = [[UIActionSheet alloc]
//                                            initWithTitle:nil
//                                            delegate:self
//                                            cancelButtonTitle:@"取消"
//                                            destructiveButtonTitle:nil
//                                            otherButtonTitles: [NSString  stringWithFormat:@"拨打 %@",self.self.dataDict[@"usertel"]], @"新建联系人",nil];
//            [myActionSheet showInView:self.view];
            
            
            LCActionSheet *sheet = [LCActionSheet sheetWithTitle:nil
                                                    buttonTitles:@[[NSString  stringWithFormat:@"拨打 %@",self.self.dataDict[@"usertel"]],@"新建联系人"]
                                                  redButtonIndex:-1
                                                        delegate:self];
            
            [sheet show];
        }
    }
}
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
- (void)actionSheet:(LCActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==2)
    {
        NSLog(@"取消");
        return ;
    }
    if (buttonIndex==0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.dataDict[@"usertel"]]]];
        return;
    }
    // create a new view controller
    ABNewPersonViewController *newPersonViewController = [[ABNewPersonViewController alloc] init];
    // Create a new contact
    //ABContact *contact = [ABContact contact];
    // Create the pre-filled properties
    NSString *firstName=@"";
    NSString *lastName=@"";
    if ([self.dataDict[@"user"] length]>0) {
        firstName=[self.dataDict[@"user"] substringToIndex:1];
    }
    if ([self.dataDict[@"user"] length]>1) {
        lastName=[self.dataDict[@"user"] substringFromIndex:1];
    }
    NSString *organiza=[NSString stringWithFormat:@"%@(百校生)",self.organizationTitleLable.text];
    ABRecordRef newPerson = ABPersonCreate();
    CFErrorRef error = NULL;
    ABRecordSetValue(newPerson, kABPersonFirstNameProperty, (__bridge CFTypeRef)(lastName), &error);
    ABRecordSetValue(newPerson, kABPersonLastNameProperty, (__bridge CFTypeRef)(firstName), &error);
    ABRecordSetValue(newPerson, kABPersonOrganizationProperty,(__bridge CFTypeRef)(organiza), &error);
    ABRecordSetValue(newPerson, kABPersonJobTitleProperty, @"联系人", &error);
    ABMutableMultiValueRef multiValue = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
    multiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiValue,(__bridge CFTypeRef)(self.dataDict[@"usertel"]), kABPersonPhoneMainLabel, NULL);
    ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiValue , &error);
    NSAssert(!error, @"Something bad happened here.");
    newPersonViewController.displayedPerson = newPerson;
    // Set delegate
    newPersonViewController.navigationItem.leftBarButtonItem=nil;
    newPersonViewController.newPersonViewDelegate = self;
    [self.navigationController pushViewController:newPersonViewController animated:YES];
    
}
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person
{
    [newPersonView.navigationController popViewControllerAnimated:YES];
}

#define mark collectView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.memebersArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSLog(@"%@",self.memebersArray[section][@"data"]);
    return [self.memebersArray[section][@"data"] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MemberCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
    NSDictionary *dict=self.memebersArray[indexPath.section][@"data"][indexPath.row];
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,dict[@"headpic"]]] placeholderImage:[UIImage imageNamed:IMAGEBACK] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    cell.nameLable.text=NSStringWithFormat(dict[@"position"]);
    cell.remarkLable.text=NSStringWithFormat(dict[@"remark"]);
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.membersCollectionView==collectionView) {
//        if (indexPath.section==0) {
//            return CGSizeMake(WIDTH(WINDOW)/4,120);
//        }else
//        {
            return CGSizeMake(WIDTH(WINDOW)/4-5,120);
//        5
    }else
    {
        return CGSizeMake(WIDTH(WINDOW)/3-10,WIDTH(WINDOW)/3);
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view =nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        view.backgroundColor = [UIColor clearColor];
        UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(0,20, WIDTH(WINDOW),30)];
        lbl.backgroundColor=[UIColor whiteColor];
        lbl.numberOfLines = 1;
        NSString *headText;
        headText=[NSString stringWithFormat:@"  %@",self.memebersArray[indexPath.section][@"title"]];
        lbl.text = headText;
        for (UIView *subView in view.subviews) {
            [subView removeFromSuperview];
        }
        [view addSubview:lbl];
        return view;
    }
    return view;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MemberCollectionViewCell *cell=[collectionView cellForItemAtIndexPath:indexPath];

    BusinessCard *bc=[[NSBundle mainBundle]loadNibNamed:@"BusinessCard" owner:nil options:nil][0];
    bc.bView=cell.headImageView;
    [bc showView:WINDOW];
}
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size;
    size = CGSizeMake(collectionView.frame.size.width,50);
    return size;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (self.membersCollectionView==collectionView) {
        return UIEdgeInsetsMake(0,0,0,0);
    }else
    {
        return UIEdgeInsetsMake(20,10,20,10);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==1) {
        return 1;
    }
    return 2;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 33;
}
- (void)titleViewBtuSelect:(int)index
{
    for (UIButton *btu in self.titleView.subviews) {
        if ([btu isKindOfClass:[UIButton class]]) {
            btu.selected=NO;
            btu.backgroundColor=[UIColor clearColor];
        }
    }
    UIButton *btu=(UIButton *)[self.titleView viewWithTag:100+index];
    btu.backgroundColor=[UIColor greenColor];
    btu.selected=YES;
}
- (void)titleViewClick:(UIButton *)btu
{
    for (UIButton *btu in self.titleView.subviews) {
        if ([btu isKindOfClass:[UIButton class]]) {
            btu.selected=NO;
            btu.backgroundColor=[UIColor clearColor];
        }
    }
    btu.selected=!btu.selected;
    [self.scrollView setContentOffset:CGPointMake(WIDTH(self.view)*(btu.tag-100),0) animated:YES];
    btu.backgroundColor=[UIColor greenColor];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==self.scrollView) {
        double index=self.scrollView.contentOffset.x/WIDTH(self.view);
        [self titleViewBtuSelect:index];
    }
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
