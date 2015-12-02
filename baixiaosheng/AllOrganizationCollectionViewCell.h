//
//  AllOrganizationCollectionViewCell.h
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/9.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllOrganizationCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (nonatomic)int number;
@end
