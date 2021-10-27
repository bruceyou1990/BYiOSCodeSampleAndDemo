//
//  AppDelegate.m
//  UITableViewSampleDemoOC
//
//  Created by BruceYou on 2021/10/13.
//

#import "AppDelegate.h"
#import "classicTableViewViewController.h"
#import "launcherViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


//为APP 添加启动VC
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //设置根视图控制器
    launcherViewController *root = [[launcherViewController alloc] init];
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:root];
    self.window.rootViewController = rootNav;
    
    //显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
