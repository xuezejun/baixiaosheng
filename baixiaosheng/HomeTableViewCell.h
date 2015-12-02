//
//  HomeTableViewCell.h
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/2.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell
@property (strong,nonatomic)void (^myBtuSelect)(NSInteger tag);
@property (strong,nonatomic)NSArray *titleNameArray;
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@end
