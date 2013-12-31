//
//  AppDelegate.m
//  Ambagan
//
//  Created by Kana on 11/27/13.
//  Copyright (c) 2013 Kana. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize ds;
@synthesize ambagers;
@synthesize splitType;
@synthesize location;
@synthesize bill;
@synthesize serviceCharge;
@synthesize tip;
@synthesize discount;
@synthesize report_date;
@synthesize report_type;

-(void) invalidateValues{
    self.ambagers = nil;
    self.splitType = nil;
    self.location = nil;
    self.bill = 0;
    self.serviceCharge = 0;
    self.tip = 0;
    self.discount = 0;
    self.report_date = 0;
    self.report_type = 0;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions

{
    ds = [[DataSource alloc] init];
    NSLog(@"didFinishLaunchingWithOptions");
    [self.ds setupDatabase];
    // Override point for customization after application launch.
    return YES;
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
    //[self.ds closeDatabase];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
