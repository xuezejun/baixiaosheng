//
//  AppDelegate.m
//  baixiaosheng
//
//  Created by 薛泽军 on 15/8/31.
//  Copyright (c) 2015年 薛泽军. All rights reserved.
//

#import "AppDelegate.h"
#import "HSSTabbarViewController.h"
#import "MyNavigationController.h"
#import "LoginViewController.h"
@implementation AppDelegate
{
    LoginViewController *_lvc;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USERINFORMATION]) {
        [self login];
    }else
    {
        [self main];
    }
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
//    [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare]
    // Override point for customization after application launch.
    UIApplicationShortcutItem *shortItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"定位" localizedTitle:@"定位" localizedSubtitle:@"我的位置" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation] userInfo:nil];
    UIApplicationShortcutItem *shortItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"闺蜜坊" localizedTitle:@"闺蜜坊"];
    UIApplicationShortcutItem *shortItem3 = [[UIApplicationShortcutItem alloc] initWithType:@"表白墙" localizedTitle:@"表白墙"];

    NSArray *shortItems = [[NSArray alloc] initWithObjects:shortItem1, shortItem2,shortItem3, nil];
    NSLog(@"%@", shortItems);
    [[UIApplication sharedApplication] setShortcutItems:shortItems];
    NSLog(@"weixin~~~%d",[self APCheckIfAppInstalled2:@"weixin://"]);
    NSLog(@"%d",[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]);
    
    return YES;
}
-(BOOL)  APCheckIfAppInstalled2:(NSString *)urlSchemes
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlSchemes]])
    {
        NSLog(@" installed");
        
        return  YES;
    }
    else
    {
        return  NO;
    }
}
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    if ([shortcutItem.type  isEqual: @"定位"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位" message:@"我的位置" delegate:self cancelButtonTitle:@"哦" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }else if ([shortcutItem.type isEqual: @"闺蜜坊"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:SHORTITEM object:@"3"];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"打开" message:@"打开文件" delegate:self cancelButtonTitle:@"哦" otherButtonTitles:nil, nil];
//        [alert show];
        return;
    }
}

- (void)login
{
//    UIViewController *vc=[[NSClassFromString([NSString stringWithFormat:@"%@ViewController",@"Life"]) alloc]initWithNibName:[NSString stringWithFormat:@"%@ViewController",@"Life"] bundle:nil];
    [_lvc removeFromParentViewController];
//    _lvc=nil;

    LifeViewController *lvc=[[LifeViewController alloc]initWithNibName:@"LifeViewController" bundle:nil];
//    NSLog(@"uvc--%@",vc);
//    MyNavigationController *mnvc=[[MyNavigationController alloc]initWithRootViewController:vc];

    HSSTabbarViewController *htvc=[[HSSTabbarViewController alloc]init];
//    MyNavigationController *mnvc=[[MyNavigationController alloc]initWithRootViewController:htvc];
    self.menu = [[LPSideMenu alloc] initWithContentViewController:htvc leftViewController:lvc];
    self.window.rootViewController = self.menu;
}
- (void)main
{
//    _lvc=nil;
    if(_lvc)
    {
        self.window.rootViewController = _lvc;
        return;
    }
    _lvc=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    self.window.rootViewController = _lvc;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url NS_DEPRECATED_IOS(2_0, 9_0, "Please use application:openURL:options:");
{
    NSLog(@"absoluteString: %@", [url absoluteString]);

    NSLog(@"relativeString: %@", [url relativeString]);
    
    NSLog(@"Scheme: %@", [url scheme]);
    
    NSLog(@"Host: %@", [url host]);
    
    NSLog(@"Port: %@", [url port]);
    
    NSLog(@"Path: %@", [url path]);
    
    NSLog(@"Relative path: %@", [url relativePath]);
    
    NSLog(@"Path components as array: %@", [url pathComponents]);
    
    NSLog(@"Parameter string: %@", [url parameterString]);
    
    NSLog(@"Query: %@", [url query]);
    
    NSLog(@"Fragment: %@", [url fragment]);
    
    NSLog(@"User: %@", [url user]);
    
    NSLog(@"Password: %@", [url password]);
    return YES;
}
@end
