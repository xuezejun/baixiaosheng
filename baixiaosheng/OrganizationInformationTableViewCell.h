//
//  OrganizationInformationTableViewCell.h
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/10.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrganizationInformationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@end
