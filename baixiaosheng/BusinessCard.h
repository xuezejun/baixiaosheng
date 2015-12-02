//
//  BusinessCard.h
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/29.
//  Copyright © 2015年 薛泽军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessCard : UIView
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong,nonatomic)UIView *bView;

- (void)showView:(UIView *)view;
@end
