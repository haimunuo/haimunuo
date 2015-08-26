//
//  AppDelegate.m
//  NetPushDemo
//
//  Created by qianfeng on 15/8/11.
//  Copyright (c) 2015年 ZKK. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    /*
        网络推送
     应用场景
      1.每天晚八点电视剧推送
     2.新闻推送
     3.小说更新
     奇葩用
     1.聊天
     2.查询莫人的行为
     3.提醒业务，比如一些秀场
     */
    //启动推动通知
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0) {
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge) categories:nil]];
    }else{
        
    [[UIApplication sharedApplication]registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge];
    }
    
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
//当接到通知、时如何去处理，首先是去处理一个标识
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //我们首先获得一个token值，相当于qq ,需要一个qq号码，qq这是是 苹果的服务器，我们通过设备向苹果服务器发起请求，告诉他我们的应用、需要一个标示，作为它们之间的联系
    //获取token需要进行处理，把这个标示发给我们的服务器做记录，当我们的服务器需要给用户发消息的时候，要用这个标示+我们要发送的消息给苹果APNS服务器上，苹果根据想换个标示转发到对应的手机里面
    
    //那为什么能接受消息，因为在有网情况下，手机一直和苹果服务器保持通讯的，
    //最明显的是在关闭网络情况下，手机收不到，已有网会弹出很多消息
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"%@",error);
    //推送需要设置证书
}
//接受消息
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
   /* {aps:{
    alert:"";
    
    }
}
*/
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
