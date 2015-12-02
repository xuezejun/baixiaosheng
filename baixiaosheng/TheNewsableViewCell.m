//
//  TheNewsableViewCell.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/11/24.
//  Copyright © 2015年 薛泽军. All rights reserved.
//

#import "TheNewsableViewCell.h"

@implementation TheNewsableViewCell

- (void)awakeFromNib {
    // Initialization code
    CircleWithView(self.thereNewsLable);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
