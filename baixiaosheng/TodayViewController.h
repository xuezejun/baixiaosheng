//
//  TodayViewController.h
//  baixiaosheng
//
//  Created by 薛泽军 on 15/8/31.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"

@interface TodayViewController : BaseViewController
@property (strong, nonatomic) JTCalendar *calendar;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTCalendarContentView *calendarContentView;

@end
