//
//  AppDelegate.m
//  edugames
//
//  Created by Angela Zhang on 2/14/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "CKSideBarController.h"
#import "CKTestViewController.h"

@interface AppDelegate () <CKSideBarControllerDelegate>

@property(nonatomic) CKSideBarController *barController;
@property(nonatomic) UINavigationController *controller1;
@property(nonatomic) UINavigationController *controller2;
@property(nonatomic) UINavigationController *controller3;
@property(nonatomic) UINavigationController *controller4;
@property(nonatomic) UINavigationController *controller5;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[[UINavigationBar appearance] setTintColor:[UIColor colorWithHue:0.6 saturation:0.55 brightness: 0.69 alpha:1.0]];
    [[UINavigationBar appearance] setTintColor:[UIColor clearColor]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    self.controller1 = [self navControllerWithImage:[UIImage imageNamed:@"game"]
                                      selectedImage:[UIImage imageNamed:@"game-highlighted"]];
    self.controller2 = [self navControllerWithImage:[UIImage imageNamed:@"search"]
                                      selectedImage:[UIImage imageNamed:@"search-highlighted"]];
    self.controller3 = [self navControllerWithImage:[UIImage imageNamed:@"folder"]
                                      selectedImage:[UIImage imageNamed:@"folder-highlighted"]];
    self.controller4 = [self navControllerWithImage:[UIImage imageNamed:@"profile"]
                                      selectedImage:[UIImage imageNamed:@"profile-highlighted"]];
    self.controller5 = [self navControllerWithImage:[UIImage imageNamed:@"settings"]
                                      selectedImage:[UIImage imageNamed:@"settings-highlighted"]];
    
    //UIViewController *detachedController = [[UIViewController alloc] init];
    
    self.barController = [[CKSideBarController alloc] init];
    self.barController.delegate = self;
    self.barController.viewControllers = @[
                                           self.controller1,
                                           self.controller2,
                                           self.controller3,
                                           self.controller4,
                                           self.controller5
                                           ];
    
    self.window.rootViewController = self.barController;
    return YES;
}

//Side bar controller stuff
BOOL shouldAlternate = YES;

- (UINavigationController *)navControllerWithImage:(UIImage *)defaultImage selectedImage:(UIImage *)selectedImage {
    CKTestViewController *controller = [[CKTestViewController alloc] init];
    controller.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [navController.sideBarItem setImage:defaultImage highlightedImage:selectedImage];
    
    return navController;
}

- (void)updateViewControllers {
    self.barController.viewControllers = @[
                                           self.controller1,
                                           self.controller2,
                                           self.controller3,
                                           self.controller4,
                                           self.controller5
                                           ];
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


@end
