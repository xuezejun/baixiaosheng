//
//  OrganizationViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/8/31.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "OrganizationViewController.h"
#import "OrganizationHeadView.h"
#import "OrganizationMessageCollectionViewCell.h"
#import "OrganizationCollectionViewCell.h"
#import "AllOrganizationCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "OranizationInformationViewController.h"
#import "MenuLabel.h"
#import "HyPopMenuView.h"
#import "KIPageView.h"
@interface OrganizationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate,KIPageViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *allOrganizationCollectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableArray *allClueArray;
@property (strong,nonatomic)UITableView *tableView;
@property (nonatomic, strong) KIPageView        *pageView;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@property (strong,nonatomic)UIPageControl *pageC;

@end

@implementation OrganizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super navigationView];
//    [self.collectionView registerNib:[UINib nibWithNibName:@"OrganizationMessageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellOne"];
//    [self.collectionView registerNib:[UINib nibWithNibName:@"OrganizationCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellTwo"];
//    [self.collectionView registerNib:[UINib nibWithNibName:@"OrganizationHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
//    
//    
//    [self.allOrganizationCollectionView registerNib:[UINib nibWithNibName:@"AllOrganizationCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell2"];
    
    
    

    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW),HEIGHT(WINDOW)-49-64) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    _pageView = [[KIPageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW), WIDTH(WINDOW)*0.3)];
    [_pageView setBackgroundColor:[UIColor whiteColor]];
    [_pageView setDelegate:self];
    _pageView.pagingEnabled=YES;
    [_pageView setInfinite:YES];
    //    [_pageView setCellMargin:1];
    [_pageView flipOverWithTime:5];
    
    self.dataSource=[NSMutableArray array];
    for (int i=0;i<5;i++) {
        [self.dataSource addObject:@"443bf6f00b6522d43657ae4d29214a7c.jpg"];
    }
    _pageC=[[UIPageControl alloc]initWithFrame:CGRectMake(0,HEIGHT(_pageView)-10,WIDTH(_pageView),5)];
    _pageC.numberOfPages=self.dataSource.count;
    [_pageView addSubview:_pageC];
    [_pageView reloadData];

    self.tableView.tableHeaderView=_pageView;
    
    
    
    NSMutableDictionary *pare=[[[NetworkRequest sharedNetworkRequest] userTokenDict] mutableCopy];
    NSLog(@"%@",pare);
    [[NetworkRequest sharedNetworkRequest] postWithUrl:CLUBTYPE andParData:pare success:^(id responseObject, int code) {
        NSLog(@"%@",responseObject);
        self.allClueArray=responseObject[@"data"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
//    self.tableView.tableFooterView=self.scrollView;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)segClick:(UISegmentedControl *)sender
{
//    [self.scrollView setContentOffset:CGPointMake(WIDTH(self.view)*sender.selectedSegmentIndex,0) animated:YES];
    self.segmented.selectedSegmentIndex=sender.selectedSegmentIndex;
    [self.tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
//    self.allOrganizationCollectionView.frame=CGRectMake(WIDTH(WINDOW), 0, WIDTH(self.scrollView),HEIGHT(self.scrollView));
//    self.scrollView.contentSize=CGSizeMake(WIDTH(WINDOW)*2,0);
//    self.scrollView.pagingEnabled=YES;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    if (scrollView==self.scrollView) {
//        double index=self.scrollView.contentOffset.x/WIDTH(self.view);
//        self.segmented.selectedSegmentIndex=index;
//    }
    
}
#pragma mark TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.segmented.selectedSegmentIndex==0) {
        return 1;
    }else
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmented.selectedSegmentIndex==0) {
//        if (section==0) {
//            return 1;
//        }else
        return 5+1;
    }else
        NSLog(@"hang~~%lu", (self.allClueArray.count+2)/3+((self.allClueArray.count+2)%3>0?1:0));
        return (self.allClueArray.count+2)/3+((self.allClueArray.count+2)%3>0?1:0);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmented.selectedSegmentIndex==0) {
        if (indexPath.row==0) {
            return 95+20;
        }else
        return WIDTH(WINDOW)/2;
    }else
    {
        return WIDTH(WINDOW)/3;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.segmented.selectedSegmentIndex==0) {
        if (indexPath.row==0) {
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (cell==nil) {
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell1"];
                OrganizationMessageCollectionViewCell *collectioncell=[[NSBundle mainBundle]loadNibNamed:@"OrganizationMessageCollectionViewCell" owner:self options:nil][0];
                    //            CGSizeMake(WIDTH(WINDOW)/2-50,WIDTH(WINDOW)/2-20)
                collectioncell.frame=CGRectMake(25,0,WIDTH(WINDOW)-50,95);
                collectioncell.tag=200;
                [cell.contentView addSubview:collectioncell];
                cell.backgroundColor=[UIColor groupTableViewBackgroundColor];

            }
            return cell;
        }else
        {
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            for (int i=0;i<2;i++) {
                OrganizationCollectionViewCell *collectioncell=[[NSBundle mainBundle]loadNibNamed:@"OrganizationCollectionViewCell" owner:self options:nil][0];
                //            CGSizeMake(WIDTH(WINDOW)/2-50,WIDTH(WINDOW)/2-20)
                collectioncell.frame=CGRectMake(33+(WIDTH(WINDOW)/2-50+33)*i,0,WIDTH(WINDOW)/2-50,WIDTH(WINDOW)/2-20);
                collectioncell.tag=200+i;
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OrganizationCollectionViewCellClick:)];
                [collectioncell addGestureRecognizer:tap];
                
                
                
                cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
                [cell.contentView addSubview:collectioncell];
                }
           
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell2"];
            for (int i=0;i<3;i++) {
                AllOrganizationCollectionViewCell *collectioncell=[[NSBundle mainBundle]loadNibNamed:@"AllOrganizationCollectionViewCell" owner:self options:nil][0];
                //            CGSizeMake(WIDTH(WINDOW)/2-50,WIDTH(WINDOW)/2-20)
                collectioncell.frame=CGRectMake(7+(WIDTH(WINDOW)/3-10+7)*i,0,WIDTH(WINDOW)/3-10,WIDTH(WINDOW)/3);
                collectioncell.tag=100+i;
                [cell.contentView addSubview:collectioncell];
                
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AllOrganizationCollectionViewCellClick:)];
                [collectioncell addGestureRecognizer:tap];
                cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
            }
        }
        for (AllOrganizationCollectionViewCell *acell in cell.contentView.subviews) {
            if ([acell isMemberOfClass:[AllOrganizationCollectionViewCell class]]) {
                acell.hidden=YES;
            }
        }
    
        for (int i=indexPath.row*3;i<indexPath.row*3+3;i++) {
            if (i>=(self.allClueArray.count+2))
            {
                
            }else
            {
            AllOrganizationCollectionViewCell *collectioncell=(AllOrganizationCollectionViewCell *)[cell.contentView viewWithTag:100+i%3];
            collectioncell.number=i;
            collectioncell.hidden=NO;
            NSDictionary *dict;
            if (i>1) {
                dict=self.allClueArray[i-2];
                [collectioncell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,dict[@"pic"]]] placeholderImage:[UIImage imageNamed:IMAGEBACK] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    CGImageRef cgRef = image.CGImage;
                    CGImageRef imageRef;
                    imageRef =CGImageCreateWithImageInRect(cgRef, CGRectMake(image.size.width/4,image.size.height/12,image.size.width/2,image.size.height/4));
                    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
                    CGImageRelease(imageRef);
                    collectioncell.headImageView.image=thumbScale;
                }];
            collectioncell.titleLable.text=NSStringWithFormat(dict[@"name"]);
            }else
            {
                collectioncell.headImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"groupbg00%ld-h",(long)i]];
                collectioncell.titleLable.text=NSStringWithFormat(i==0?@"学生会":@"老乡会");
            }
            }
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }

}
- (void)OrganizationCollectionViewCellClick:(UITapGestureRecognizer *)tap
{
    
}
- (void)AllOrganizationCollectionViewCellClick:(UITapGestureRecognizer *)tap
{
    AllOrganizationCollectionViewCell *collectioncell=(AllOrganizationCollectionViewCell *)tap.view;
    {
        NSString *title;
        NSMutableDictionary *pare=[[[NetworkRequest sharedNetworkRequest] userTokenDict] mutableCopy];
        [pare setValue:[[[NetworkRequest sharedNetworkRequest] userInformation] objectForKey:@"school"] forKey:@"school"];
        NSDictionary *dict;
        if (collectioncell.number>1) {
            dict=self.allClueArray[collectioncell.number-2];
            [pare setValue:dict[@"id"] forKey:@"type"];
            title=dict[@"name"];
        }else
        {
            [pare setValue:NSStringWithFormat(collectioncell.number==0?@"学生会":@"老乡会") forKey:@"type"];
            title=NSStringWithFormat(collectioncell.number==0?@"学生会":@"老乡会");
        }
        NSLog(@"%@",pare);
        [[NetworkRequest sharedNetworkRequest] postWithUrl:INDEXCLUB andParData:pare success:^(id responseObject, int code) {
            NSLog(@"%@",responseObject);
            if (code==1) {
                if ([responseObject[@"data"] count]==0) {
                    [[NetworkRequest sharedNetworkRequest] alertViewWithTitle:@"温馨提示" andMessage:@"组织分类为空"];
                    return ;
                }
                [self hyPopMenuViewArray:responseObject[@"data"] WithTitle:title];
            }
        } failure:^(NSError *error) {
            
        }];
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 60;
    }else
    return 0;
}
- (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW), 60)];
    view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UISegmentedControl *segmented=[self duplicate:self.segmented];
//    self.segmented.frame=CGRectMake(69,16,180,30);
    NSLog(@"segmented~~~%@",self.segmented);
    [segmented addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    view.userInteractionEnabled=YES;
    [view addSubview:segmented];
    return view;
}



#pragma mark - KIPageViewDelegate
- (NSInteger)numberOfCellsInPageView:(KIPageView *)pageView {
    return self.dataSource.count;
}

- (KIPageViewCell *)pageView:(KIPageView *)pageView cellAtIndex:(NSInteger)index {
    static NSString *PAGE_VIEW_CELL_IDENTIFIER = @"PageViewCell";
    
    KIPageViewCell *pageViewCell = [pageView dequeueReusableCellWithIdentifier:PAGE_VIEW_CELL_IDENTIFIER];
    UIImageView *imageView = (UIImageView *)[pageViewCell viewWithTag:1001];
    if (pageViewCell == nil) {
        pageViewCell = [[KIPageViewCell alloc] initWithIdentifier:PAGE_VIEW_CELL_IDENTIFIER];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,WIDTH(WINDOW), HEIGHT(pageView))];
        //        [label setTextColor:[UIColor blackColor]];
        [imageView setTag:1001];
        [pageViewCell addSubview:imageView];
    }
    [pageViewCell setBackgroundColor:[UIColor redColor]];
    //    [label setText:self.dataSource[index]];
    imageView.image=[UIImage imageNamed:self.dataSource[index]];
    return pageViewCell;
}

- (void)pageView:(KIPageView *)pageView didDisplayPage:(NSInteger)pageIndex {
    //    NSLog(@"didDisplayPage %ld", pageIndex);
    _pageC.currentPage=pageIndex;
}

- (void)pageView:(KIPageView *)pageView didEndDisplayingPage:(NSInteger)pageIndex {
    //    NSLog(@"didEndDisplayingPage %ld", pageIndex);
    
}

- (void)pageView:(KIPageView *)pageView didSelectedCellAtIndex:(NSInteger)index {
    NSLog(@"选中了第 %ld 项", index);
    [pageView deselectCellAtIndex:index animated:YES];
}

- (void)pageView:(KIPageView *)pageView didDeselectedCellAtIndex:(NSInteger)index {
    NSLog(@"取消选中 %ld", index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)hyPopMenuViewArray:(NSArray *)array WithTitle:(NSString *)title
{
    
    NSMutableArray *Objs =[NSMutableArray array];
    for (NSDictionary *dict in array) {
        [Objs addObject:[MenuLabel CreatelabelIconName:[NSString stringWithFormat:@"%@%@",IMAGEURL,dict[@"clubpic"]] Title:dict[@"name"]]];
    }
    
    //自定义的头部视图
    //        UIImageView *topView = [[ImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    //        topView.image = [UIImage imageNamed:@"compose_slogan"];
    //        topView.contentMode = UIViewContentModeScaleAspectFit;
    UILabel  *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, WIDTH(WINDOW),40)];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.text=title;
    NSMutableDictionary *AudioDictionary = [NSMutableDictionary dictionary];
    
    //添加弹出菜单音效
    [AudioDictionary setObject:@"composer_open" forKey:kHyPopMenuViewOpenAudioNameKey];
    [AudioDictionary setObject:@"wav" forKey:kHyPopMenuViewOpenAudioTypeKey];
    //添加取消菜单音效
    [AudioDictionary setObject:@"composer_close" forKey:kHyPopMenuViewCloseAudioNameKey];
    [AudioDictionary setObject:@"wav" forKey:kHyPopMenuViewCloseAudioTypeKey];
    //添加选中按钮音效
    [AudioDictionary setObject:@"composer_select" forKey:kHyPopMenuViewSelectAudioNameKey];
    [AudioDictionary setObject:@"wav" forKey:kHyPopMenuViewSelectAudioTypeKey];
    
    
    [HyPopMenuView CreatingPopMenuObjectItmes:Objs TopView:lable OpenOrCloseAudioDictionary:AudioDictionary SelectdCompletionBlock:^(MenuLabel *menuLabel, NSInteger index) {
        NSLog(@"index:%ld ItmeNmae:%@",index,menuLabel.title);
        OranizationInformationViewController *oivc=[[OranizationInformationViewController alloc]initWithNibName:@"OranizationInformationViewController" bundle:nil];
        oivc.clubId=array[index][@"id"];
        oivc.navigationItem.title=array[index][@"name"];
        oivc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:oivc animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }];
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    NSLog(@"HyPopMenuView.count:%ld",windows.count);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    if (self.collectionView==collectionView) {
//        return 2;
//    }
//    return 1;
//}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    if (self.collectionView==collectionView)
//    {
//        if (section==0) {
//            return 1;
//        }else if (section==1)
//        {
//            return 10;
//        }else
//        {
//            return 1;
//        }
//    }else
//    {
//        return self.allClueArray.count+2;
//    }
//}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    OrganizationHeadView *view =nil;
//
//    if (kind == UICollectionElementKindSectionHeader){
//
//        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//        if (indexPath.section==0) {
//            view.titleLable.text=@"最新消息";
//        }else if (indexPath.section==1)
//        {
//            view.titleLable.text=@"关注组织";
//        }
//        return view;
//
//    }else
//    {
//        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FootView" forIndexPath:indexPath];
//    }
//    return view;
//}
//-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    CGSize size;
//    if (self.collectionView==collectionView) {
//        size = CGSizeMake(self.collectionView.frame.size.width,40);
//    }else
//    {
//        size = CGSizeMake(self.collectionView.frame.size.width,0);
//    }
//    NSLog(@"referenceSizeForHeaderInSection: %@", NSStringFromCGSize(size));
//    return size;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    if (indexPath.section==0) {
//    //        UserHeadViewCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellHead" forIndexPath:indexPath];
//    //        return cell;
//    //    }else
//    if (self.collectionView==collectionView) {
//        if (indexPath.section==0) {
//        OrganizationMessageCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellOne" forIndexPath:indexPath];
//        cell.layer.masksToBounds=YES;
//        cell.layer.cornerRadius=10;
//        return cell;
//        }else
//        {
//        OrganizationCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellTwo" forIndexPath:indexPath];
//        cell.layer.masksToBounds=YES;
//        cell.layer.cornerRadius=10;
//        return cell;
//    }
//    }else
//    {
//        AllOrganizationCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
//        cell.layer.masksToBounds=YES;
//        cell.layer.cornerRadius=10;
//        NSDictionary *dict;
//        if (indexPath.row>1) {
//            dict=self.allClueArray[indexPath.row-2];
//            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,dict[@"pic"]]] placeholderImage:[UIImage imageNamed:IMAGEBACK] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                CGImageRef cgRef = image.CGImage;
//                CGImageRef imageRef;
//                imageRef =CGImageCreateWithImageInRect(cgRef, CGRectMake(image.size.width/4,image.size.height/12,image.size.width/2,image.size.height/4));
//                UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
//                CGImageRelease(imageRef);
//                cell.headImageView.image=thumbScale;
//            }];
//            cell.titleLable.text=NSStringWithFormat(dict[@"name"]);
//        }else
//        {
//            cell.headImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"groupbg00%ld-h",(long)indexPath.row]];
//            cell.titleLable.text=NSStringWithFormat(indexPath.row==0?@"学生会":@"老乡会");
//        }
//        return cell;
//    }
//}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (self.collectionView==collectionView) {
//        OranizationInformationViewController *oivc=[[OranizationInformationViewController alloc]initWithNibName:@"OranizationInformationViewController" bundle:nil];
//        oivc.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:oivc animated:YES];
//        self.hidesBottomBarWhenPushed=NO;
//    }else
//    {
//        NSString *title;
//        NSMutableDictionary *pare=[[[NetworkRequest sharedNetworkRequest] userTokenDict] mutableCopy];
//        [pare setValue:[[[NetworkRequest sharedNetworkRequest] userInformation] objectForKey:@"school"] forKey:@"school"];
//        NSDictionary *dict;
//        if (indexPath.row>1) {
//            dict=self.allClueArray[indexPath.row-2];
//            [pare setValue:dict[@"id"] forKey:@"type"];
//            title=dict[@"name"];
//        }else
//        {
//            [pare setValue:NSStringWithFormat(indexPath.row==0?@"学生会":@"老乡会") forKey:@"type"];
//            title=NSStringWithFormat(indexPath.row==0?@"学生会":@"老乡会");
//        }
//        NSLog(@"%@",pare);
//        [[NetworkRequest sharedNetworkRequest] postWithUrl:INDEXCLUB andParData:pare success:^(id responseObject, int code) {
//            NSLog(@"%@",responseObject);
//            if (code==1) {
//                if ([responseObject[@"data"] count]==0) {
//                    [[NetworkRequest sharedNetworkRequest] alertViewWithTitle:@"温馨提示" andMessage:@"组织分类为空"];
//                    return ;
//                }
//                [self hyPopMenuViewArray:responseObject[@"data"] WithTitle:title];
//            }
//        } failure:^(NSError *error) {
//
//        }];
//
//    }
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (self.collectionView==collectionView) {
//        if (indexPath.section==0) {
//            return CGSizeMake(WIDTH(WINDOW)-50,95);
//        }else
//        {
//            return CGSizeMake(WIDTH(WINDOW)/2-50,WIDTH(WINDOW)/2-20);
//        }
//    }else
//    {
//        return CGSizeMake(WIDTH(WINDOW)/3-10,WIDTH(WINDOW)/3);
//    }
//}
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    if (self.collectionView==collectionView) {
//    return UIEdgeInsetsMake(20,33,20,33);
//    }else
//    {
//        return UIEdgeInsetsMake(20,10,20,10);
//    }
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    if (section==1) {
//        return 1;
//    }
//    return 2;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 33;
//}

@end
