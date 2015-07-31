//
//  BNRAppDelegate.swift
//  Homepwner
//
//  Created by Kevin Lin on 7/30/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit

@UIApplicationMain
class BNRAppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let itemsViewController = BNRItemsViewController()
        let navigationController = UINavigationController(rootViewController: itemsViewController)
        
        window?.rootViewController = navigationController
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        let success = BNRItemStore.sharedStore().saveChanges()
        
        if (success) {
            NSLog("Saved all of the BNRItems")
        } else {
            NSLog("Could not save any of the BNRItems")
        }
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

/*
//
//  BNRAppDelegate.m
//  Homepwner
//
//  Created by Kevin Lin on 4/17/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRAppDelegate.h"
#import "Homepwner-Swift.h"

@implementation BNRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

BNRItemsViewController *itemsViewController = [[BNRItemsViewController alloc] init];
UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:itemsViewController];

self.window.rootViewController = navigationController;

self.window.backgroundColor = [UIColor whiteColor];
[self.window makeKeyAndVisible];
return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
BOOL success = [[BNRItemStore sharedStore] saveChanges];

if (success) {
NSLog(@"Saved all of the BNRItems");
} else {
NSLog(@"Could not save any of the BNRItems");
}
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

@end

*/

