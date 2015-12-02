//
//  HomeHeadView.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/2.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "HomeHeadView.h"
#import "UIImageView+WebCache.h"
@implementation HomeHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setTitleArray:(NSMutableArray *)titleArray
{
//    NSArray *array = [NSArray arrayWithObjects:@"tabs1.png", @"tabs2.png", @"tabs3.png", @"tabs4.png", nil];
//    self.titleArray=titleArray;
    double width = self.scrollView.frame.size.width/4;
    for (int i=0;i<titleArray.count;i++) {
        
        UIButton *xiaoButton=[UIButton buttonWithType:UIButtonTypeCustom];
        xiaoButton.frame = CGRectMake(i*width+(width-50)/2,8,50,50);
        [xiaoButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+10]] forState:UIControlStateNormal];
        UIImageView *imageView=[[UIImageView alloc]init];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"1%d",i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            [xiaoButton setImage:image forState:UIControlStateNormal];
//        }];
        [self addSubview:imageView];
//        [xiaoButton setImage:[UIImage imageNamed:[array2 objectAtIndex:i]] forState:UIControlStateSelected];
        xiaoButton.tag=i+1000;
        [xiaoButton addTarget:self action:@selector(OnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:xiaoButton];

        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(i*width,48+10,width,20)];
        lable.tag=i+500;
        lable.font=[UIFont systemFontOfSize:14];
        lable.text=titleArray[i];
        lable.textAlignment=NSTextAlignmentCenter;
        [self.scrollView addSubview:lable];
        
//        //让第一个成为选中状态
//        if (button.tag ==1500) {
//            button.selected =YES;
//            lable.textColor=[UIColor colorWithRed:0.39f green:0.80f blue:0.70f alpha:1.00f];
//            xiaoButton.selected=YES;
//        }
    }
    NSLog(@"%lu",(titleArray.count/4+(titleArray.count%4>0?1:0)));
    self.scrollView.contentSize=CGSizeMake((titleArray.count/4+(titleArray.count%4>0?1:0))*WIDTH(self.scrollView),0);
    self.scrollView.pagingEnabled=YES;
}
- (IBAction)lifeClick:(UIButton *)sender
{
    if (self.scrollView.contentOffset.x>0) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x-WIDTH(self.scrollView),0) animated:YES];
    }
}
- (IBAction)rightClick:(UIButton *)sender
{
    if (self.scrollView.contentOffset.x<self.scrollView.contentSize.width-WIDTH(self.scrollView)) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x+WIDTH(self.scrollView),0) animated:YES];
    }
}
- (void)OnBtnClick:(UIButton *)btu
{
    
}
@end
