//
//  Qhead.h
//  maQueSheQu
//
//  Created by 薛泽军 on 15/6/1.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//


#define WINDOW [[UIApplication sharedApplication].delegate window]
#define WIDTH(view) view.frame.size.width
#define HEIGHT(view) view.frame.size.height
#define X(view) view.frame.origin.x
#define Y(view) view.frame.origin.y
#define CircleWithView(view)\
view.layer.masksToBounds=YES;\
view.layer.cornerRadius=HEIGHT(view)/2;



#define NSStringWithFormat(string) [NSString stringWithFormat:@"%@",string]
#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE6 ([[UIScreen mainScreen] currentMode].size.height >=1334)

//判断IOS7及以后系统
#define IOS7_AND_LATER ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)

#define IOS8_AND_LATER ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0)

#define IOS9_AND_LATER ([[[UIDevice currentDevice] systemVersion] doubleValue]>=9.0)

//IOS7及以后系统适配
#define IOS7_AND_LATER_ADAPTATION()\
if (IOS7_AND_LATER) {\
self.edgesForExtendedLayout = UIRectEdgeNone;\
}
#define IMAGEBACK @"imageback"


#define USERINFORMATION @"userInformation"



#define HOST @"http://www.51bxs.com/app.php/"
#define REGISTER (HOST@"Login/doregister")//注册
#define LOGIN (HOST@"Login/dologin")//登录
#define REGSITERYZM  (HOST@"TelCheck/send_yzm")//验证码
#define CLUBTYPE (HOST@"Index/ClubType")//组织
#define INDEXCLUB (HOST@"/Index/club")//组织内容
#define CLUBINFOR (HOST@"/Index/clubinfo")//组织信息





#define IMAGEURL [[NSUserDefaults standardUserDefaults] objectForKey:@"imageurl"]



#define SHORTITEM @"ShortcutItem"
