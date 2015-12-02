//
//  TodayViewController.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/8/31.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "TodayViewController.h"
#import "ToDayTableViewCell.h"
#import "ActivityDetailsViewController.h"
@interface TodayViewController ()<JTCalendarDataSource,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic)BOOL isUp;

@end

@implementation TodayViewController
{
    int _lastPosition;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [super navigationView];
    self.calendar = [JTCalendar new];
    
    // All modifications on calendarAppearance have to be done before setMenuMonthsView and setContentView
    // Or you will have to call reloadAppearance
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 1; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
    }
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    self.calendar.calendarAppearance.isWeekMode=YES;

    [UIView animateWithDuration:0
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
    NSLog(@"data~~~%@",[NSDate date]);
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cell";
    ToDayTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[NSBundle mainBundle] loadNibNamed:@"ToDayTableViewCell" owner:nil options:nil][0];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isUp) {
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }else
    {
        cell.layer.transform = CATransform3DMakeScale(1.1,1.1, 1);
    }
    //设置动画时间为0.25秒,xy方向缩放的最终值为1
    [UIView animateWithDuration:.25 animations:^{
        //       CATransform3D positionTransform = CATransform3DMakeTranslation(0, 0, 0); //位置移动
        //       cell.layer.transform=positionTransform;
        
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityDetailsViewController *advc=[[ActivityDetailsViewController alloc]initWithNibName:@"ActivityDetailsViewController" bundle:nil];
    [self.navigationController pushViewController:advc animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - _lastPosition > 30) {
        _lastPosition = currentPostion;
        self.isUp=NO;
    }
    else if (_lastPosition - currentPostion >30)
    {
        self.isUp=YES;
        _lastPosition = currentPostion;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.calendar reloadData]; // Must be call in viewDidAppear
}
- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *d = [dateFormatter dateFromString:@"2015-11-28 00:00:00"];
    if (date==d) {
        return 1;
    }else
    {
        return NO;
    }
}
- (NSString *)dateToString:(NSDate *)date {
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    
    return dateString;
    
}
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSLog(@"Date: %@", [self dateToString:date]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
