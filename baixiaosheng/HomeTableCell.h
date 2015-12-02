//
//  HomeTableCell.h
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/2.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableCell : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (strong,nonatomic)NSString *titleText;
@property (weak, nonatomic) IBOutlet UIButton *imageBtu;
@property (weak, nonatomic) IBOutlet UILabel *lineLable;
-(void)setTitleText:(NSString *)titleText;
@end
