//
//  AppDelegate.m
//  Lab-07
//
//  Created by felipe on 18/02/15.
//  Copyright (c) 2015 felipe. All rights reserved.
//

#import "AppDelegate.h"
#import "GAI.h"
#import <Parse/Parse.h>
#import <GoogleMaps/GoogleMaps.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Google Analytics
    //Parse
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"lG5Njs7mn0FAdKG7nyir8TD5Hze2bkef8lNE1jli"
                  clientKey:@"CKjhaesJ9LBAhMkDvQTPw52gsgHgq8HdQAy4rIiR"];
   
   
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
    
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-59929101-1"];
    
    
    
    //Google maps
    
     [GMSServices provideAPIKey:@"AIzaSyDs703lLfydRw7Z0C-xqIbkV5Xydhl04ho"];
 
    
    
 
    return YES;
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
