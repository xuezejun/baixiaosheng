//
//  BusinessCard.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/9/29.
//  Copyright © 2015年 薛泽军. All rights reserved.
//

#import "BusinessCard.h"
#import "CALayer+Transition.h"
@implementation BusinessCard
#define DURATION 0.7f

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGRect frame = [self.bView convertRect:self.bView.bounds toView:WINDOW
                    ];
//    NSLog(@"%@",NSStringFromCGRect(frame));
//    self.frame=CGRectMake(0, 0, WIDTH(WINDOW),HEIGHT(WINDOW));
    CGRect backFrome=self.backView.frame;
    self.backView.frame=backFrome;
    [UIView animateWithDuration:1 animations:^{
        self.backView.frame=frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    [self transitionWithType:@"oglFlip" WithSubtype:kCATransitionFromLeft ForView:self];

}
- (void)showView:(UIView *)view;
{
//    CircleWithView(self.backView);
    self.backView.layer.masksToBounds=YES;
    self.backView.layer.cornerRadius=15;
    CGRect frame = [self.bView convertRect:self.bView.bounds toView:WINDOW
                    ];
//    NSLog(@"%@",NSStringFromCGRect(frame));
    self.frame=CGRectMake(0, 0, WIDTH(WINDOW),HEIGHT(WINDOW));
    [view addSubview:self];

    
    [self transitionWithType:@"oglFlip" WithSubtype:kCATransitionFromRight ForView:self];

    
    CGRect backFrome=self.backView.frame;
    
    self.backView.frame=frame;
    [UIView animateWithDuration:1 animations:^{
        self.backView.frame=backFrome;
    } completion:^(BOOL finished) {
        
    }];
 
}
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = DURATION;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}


@end
