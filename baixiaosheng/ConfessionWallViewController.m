//
//  ConfessionWallViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/23.
//  Copyright © 2015年 薛泽军. All rights reserved.
//

#import "ConfessionWallViewController.h"
#import "ConfessionWallCollectionViewCell.h"
@interface ConfessionWallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation ConfessionWallViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ConfessionWallCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];

    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
- (IBAction)backClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addBiaoBaiClick:(UIButton *)sender
{
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ConfessionWallCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view =nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        view.backgroundColor = [UIColor clearColor];
        UIImageView *imge=[[UIImageView alloc]initWithFrame:CGRectMake(10,30,WIDTH(WINDOW),300)];
        if (indexPath.section==0) {
            imge.image=[UIImage imageNamed:@"收养麻雀.png"];
        }else if(indexPath.section==1)
        {
            imge.image=[UIImage imageNamed:@"周边活动.png"];
        }else
        {
            imge.image=[UIImage imageNamed:@""];
        }
        //        [view addSubview:imge];
        UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(30,0, WIDTH(WINDOW),40)];
        lbl.numberOfLines = 1;
        NSString *headText;
        if (indexPath.section==0) {
            headText=@"   收养麻雀";
        }else if(indexPath.section==1)
        {
            headText=@"   周边活动";
        }else
        {
            headText=@"   热门商家";
        }
        lbl.text = headText;
        for (UIView *subView in view.subviews) {
            [subView removeFromSuperview];
        }
        [view addSubview:imge];
//        [view addSubview:lbl];
        return view;
        
    }else
    {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FootView" forIndexPath:indexPath];
        view.backgroundColor = [UIColor whiteColor];
        UIButton *btu=[UIButton buttonWithType:UIButtonTypeCustom];
        btu.frame=CGRectMake(0, 0,WIDTH(WINDOW),30);
        btu.titleLabel.textAlignment=NSTextAlignmentCenter;
        [btu addTarget:self action:@selector(lookAllClick:) forControlEvents:UIControlEventTouchUpInside];
        [btu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return view;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WIDTH(WINDOW)/2-20,150);
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(WIDTH(WINDOW),350);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1,10,10,10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
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
