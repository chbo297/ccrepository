//
//  AppDelegate.m
//  TENotification
//
//  Created by bo on 03/01/2017.
//  Copyright © 2017 bo. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"%s\n%@", __func__, options);
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%s\n%@", __func__, launchOptions);
    
    // Override point for customization after application launch.
//    NSLog(@"%@", [NSThread currentThread]);
    [[UIApplication sharedApplication] registerForRemoteNotifications];
//    UNUserNotificationCenter
    UNUserNotificationCenter *noticenter = [UNUserNotificationCenter currentNotificationCenter];
    noticenter.delegate = self;
    [noticenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
            [noticenter requestAuthorizationWithOptions:UNAuthorizationOptionBadge|UNAuthorizationOptionBadge|UNAuthorizationOptionAlert
                                      completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                          NSLog(@"请求notification %i", granted);
                                      }];
        }
    }];
    
    return YES;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"%s", __func__);
    [[NSUserDefaults standardUserDefaults] setObject:@"willpre you" forKey:@"notification"];
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSLog(@"%s", __func__);
    [[NSUserDefaults standardUserDefaults] setObject:@"didreceive you" forKey:@"notificationres"];
    completionHandler();
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    NSLog(@"%s", __func__);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"%s", __func__);
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler {
    NSLog(@"%s", __func__);
    
    
    
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    NSLog(@"%s", __func__);
//}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"token:%@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"%@", error);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@"%s", __func__);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%s", __func__);
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    NSLog(@"%@", [NSThread currentThread]);
//    [NSThread sleepForTimeInterval:3];
    NSLog(@"%s", __func__);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    NSLog(@"%@", [NSThread currentThread]);
    NSLog(@"%s", __func__);
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    NSLog(@"%s", __func__);
//    NSLog(@"%@", [NSThread currentThread]);
    NSLog(@"%s", __func__);
}


@end
