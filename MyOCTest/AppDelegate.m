//
//  AppDelegate.m
//  MyOCTest
//
//  Created by netvox-ios1 on 2017/5/4.
//  Copyright © 2017年 netvox. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface AppDelegate (){
    
    
}
@property (nonatomic,strong) CLLocationManager *locationManager;


@end

@implementation AppDelegate

-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
//        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
////            [_locationManager requestWhenInUseAuthorization];
//
//        }
        if(![CLLocationManager locationServicesEnabled]){
            NSLog(@"请开启定位:设置 > 隐私 > 位置 > 定位服务");
            
        }
        // 持续使用定位服务
        if([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//            [_locationManager requestWhenInUseAuthorization];   //使用中授权 与永久授权 定位弹窗不同
            [_locationManager requestAlwaysAuthorization];  // 永久授权
            
        }
        // 方位服务
//        if ([CLLocationManager headingAvailable]) {
//            _locationManager.headingFilter = 5;
//            [_locationManager startUpdatingHeading];
//        }
    }
    return _locationManager;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    nav.navigationBarHidden = YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    
    
    [self locationManager];
    
    
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


@end
