//
//  AppDelegate.m
//  myJanDan
//
//  Created by mervin on 2017/8/13.
//  Copyright © 2017年 浅浅浅. All rights reserved.
//

#import "AppDelegate.h"
#import "JDRootTabViewController.h"
#import "SettingsHelper.h"

#ifdef DEBUG
#import <FLEX/FLEX.h>
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    DebugLog(@"Sanbox:%@", NSHomeDirectory());
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self setRootTabController];
    [self customizeInterface];
    
#ifdef DEBUG
    [[FLEXManager sharedManager] showExplorer];
#endif
    
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Custom Method
- (void)setRootTabController {
    JDRootTabViewController *root = [[JDRootTabViewController alloc] init];
    root.tabBar.translucent = YES;
    self.window.rootViewController = root;
    
}

- (void)customizeInterface {
    //设置Nav的背景色和title色
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:kColorNavBG] forBarMetrics:UIBarMetricsDefault];

    [navigationBarAppearance setTintColor:kColorBack];//返回按钮的箭头颜色
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: FontOfSize(SizeT1),
                                     NSForegroundColorAttributeName: kColorNavTitle,
                                     };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

@end
