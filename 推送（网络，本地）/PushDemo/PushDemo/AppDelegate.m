//
//  AppDelegate.m
//  PushDemo
//
//  Created by qianfeng on 15/8/10.
//  Copyright (c) 2015年 ZKK. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    /*
     本地推送的应用场景：
     1.一般用于不需要网络提醒的情况；比如：游戏中一道九点立即提示开启双倍经验；书籍类：多少天没登陆看书了
     硬件类：与蓝牙连接，当程序在后台时 与蓝牙断开，需要一个提示，告诉用户，蓝牙断开
     */
    
    //iOS8以后才需要添加授权方法
    if([UIApplication instanceMethodForSelector:@selector(registerUserNotificationSettings:) ]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    //创建本地的推送
    UILocalNotification *local=[[UILocalNotification alloc]init];
    local.alertBody=@"该吃药了";
    //设置声音，这个声音需要小于三十秒
    local.soundName=@"音效.caf";
    local.applicationIconBadgeNumber=1000;
    //开始时间
    local.fireDate=[NSDate dateWithTimeIntervalSinceNow:10];
    //把推送通知加入队列中，需要注意，推送通知加入以后，程序计算被抹杀，推送任然在进行；
    
    //如果想要弹出通知，需要程序退出时， commande+shfit+h
    [[UIApplication sharedApplication]scheduleLocalNotification:local];
    
    //如何删除一个推送通知
    //首先要获取推送
    NSArray *localArray=[[UIApplication sharedApplication]scheduledLocalNotifications];
    for (UILocalNotification *notification in localArray) {
        if ([notification.alertBody isEqualToString:@"该吃药了"]) {
            [[UIApplication sharedApplication]cancelLocalNotification:notification];
        }
    }
    //删除所有通知
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    /*
        本地推送的通知到的 假如 3天没来，程序启动一次，把原来的通知删除，并计算三天后的时间
    
    NSInteger num=[UIApplication sharedApplication].applicationIconBadgeNumber;
    num=num+1;
    local.applicationIconBadgeNumber=num;
     */
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark-本地推送的协议
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"接受本地消息");
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
