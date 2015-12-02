//
//  SchoolViewController.h
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/8.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolViewController : UIViewController
@property (strong,nonatomic)void (^back)(BOOL isyes,NSDictionary *dict);

@end
