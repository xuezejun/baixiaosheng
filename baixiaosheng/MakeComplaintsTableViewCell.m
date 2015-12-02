//
//  MakeComplaintsTableViewCell.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/10/19.
//  Copyright © 2015年 薛泽军. All rights reserved.
//

#import "MakeComplaintsTableViewCell.h"
#import "HomeTableCell.h"

@implementation MakeComplaintsTableViewCell

- (void)awakeFromNib {
    NSArray *array=[NSArray arrayWithObjects:@"321",@"322",@"323",@"324", nil];
    for (int i=0;i<4;i++) {
        HomeTableCell *htc=[[[NSBundle mainBundle]loadNibNamed:@"HomeTableCell" owner:nil options:nil]lastObject];
        htc.frame=CGRectMake(i*WIDTH(WINDOW)/4,0,WIDTH(WINDOW)/4,HEIGHT(self.downView));
        htc.tag=100+i;
        htc.imageBtu.tag=i;
        if (i==3) {
            htc.lineLable.hidden=YES;
        }
        [htc.imageBtu addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
        [htc.imageBtu setBackgroundImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        [self.downView addSubview:htc];
    }
    
    // Initialization code
}
- (void)imageClick:(UIButton *)btu
{
    //    NSLog(@"%@",b);
    self.myBtuSelect(btu.superview.tag);
}
- (void)setTitleNameArray:(NSArray *)titleNameArray
{
    for (int i=0;i<4;i++) {
        HomeTableCell *htc=(HomeTableCell *)[self.downView viewWithTag:100+i];
        htc.titleText=titleNameArray[i];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
