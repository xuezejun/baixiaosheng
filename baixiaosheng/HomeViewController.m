//
//  HomeViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/8/31.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "HomeViewController.h"
#import "KIPageView.h"
#import "HomeHeadView.h"
#import "HomeTableViewCell.h"
#import "TheRegistrationViewController.h"
@interface HomeViewController ()<KIPageViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) KIPageView        *pageView;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@property (strong,nonatomic)UIPageControl *pageC;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *dataArray;
@property (nonatomic)BOOL isUp;

@end

@implementation HomeViewController
{
    int _lastPosition;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [super navigationView];
    
    
    _pageView = [[KIPageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW), WIDTH(WINDOW)*0.5)];
    [_pageView setBackgroundColor:[UIColor whiteColor]];
    [_pageView setDelegate:self];
    _pageView.pagingEnabled=YES;
    [_pageView setInfinite:YES];
//    [_pageView setCellMargin:1];
    [_pageView flipOverWithTime:5];
    
    self.tableView.tableHeaderView=_pageView;
    self.dataSource=[NSMutableArray array];
    for (int i=0;i<5;i++) {
        [self.dataSource addObject:@"443bf6f00b6522d43657ae4d29214a7c.jpg"];
    }
    _pageC=[[UIPageControl alloc]initWithFrame:CGRectMake(0,HEIGHT(_pageView)-10,WIDTH(_pageView),5)];
    _pageC.numberOfPages=self.dataSource.count;
    [_pageView addSubview:_pageC];
    [_pageView reloadData];
    
    self.dataArray=[NSMutableArray array];
    for (int i=0;i<20;i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"%d",i*9000]];
    }
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.hidesBottomBarWhenPushed=NO;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.titleNameArray=[NSArray arrayWithObjects:self.dataArray[indexPath.row],self.dataArray[self.dataArray.count-1-indexPath.row],@"",@"", nil];
    cell.myBtuSelect=^(NSInteger tag)
    {
//        NSLog(@"~~%ld",(long)tag);
        if (tag==103) {
            TheRegistrationViewController *trvc=[[TheRegistrationViewController alloc]initWithNibName:@"TheRegistrationViewController" bundle:nil];
            trvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:trvc animated:YES];
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 187;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 66+15;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isUp) {
        cell.transform=CGAffineTransformMakeTranslation(0, 1);
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }else
    {
//        cell.layer.transform = CATransform3DMakeScale(1.1,1.1, 1);

        cell.transform=CGAffineTransformMakeTranslation(150, 1);
        [UIView animateWithDuration:.4 animations:^{
            //       CATransform3D positionTransform = CATransform3DMakeTranslation(0, 0, 0); //位置移动
            //       cell.layer.transform=positionTransform;
            cell.transform=CGAffineTransformMakeTranslation(0, 1);
            //        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
        } completion:^(BOOL finished) {
            
        }];
//        cell.layer.transform = CATransform3DMakeScale(1.1,1.1, 1);
    }
    //设置动画时间为0.25秒,xy方向缩放的最终值为1

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - _lastPosition > 30) {
        _lastPosition = currentPostion;
        self.isUp=NO;
    }
    else if (_lastPosition - currentPostion >30)
    {
        self.isUp=YES;
        _lastPosition = currentPostion;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HomeHeadView *hhv=[[[NSBundle mainBundle]loadNibNamed:@"HomeHeadView" owner:nil options:nil] lastObject];
    hhv.frame=CGRectMake(0, 0,WIDTH(WINDOW),66+15);
    hhv.titleArray=[NSMutableArray arrayWithObjects:@"比赛",@"学术",@"公益",@"实践",@"娱乐",@"运动", nil];
    return hhv;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
