//
//  AppDelegate.m
//  edugames
//
//  Created by Angela Zhang on 2/14/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//
#define FORCE_LOGOUT false

#import "AppDelegate.h"
// At the top of the file
#import "GCTurnBasedMatchHelper.h"

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
    
    [[UINavigationBar appearance] setTintColor:[UIColor clearColor]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    self.controller1 = [self navControllerWithImage:[UIImage imageNamed:@"game"]
                                      selectedImage:[UIImage imageNamed:@"game-highlighted"] tag:@"game"];
    self.controller2 = [self navControllerWithImage:[UIImage imageNamed:@"search"]
                                      selectedImage:[UIImage imageNamed:@"search-highlighted"] tag:@"search"];
    self.controller3 = [self navControllerWithImage:[UIImage imageNamed:@"folder"]
                                      selectedImage:[UIImage imageNamed:@"folder-highlighted"] tag:@"folder"];
    self.controller4 = [self navControllerWithImage:[UIImage imageNamed:@"profile"]
                                      selectedImage:[UIImage imageNamed:@"profile-highlighted"] tag:@"profile"];
    self.controller5 = [self navControllerWithImage:[UIImage imageNamed:@"settings"]
                                      selectedImage:[UIImage imageNamed:@"settings-highlighted"] tag:@"settings"];
    
    self.controller1.navigationBar.hidden = YES;
    self.controller2.navigationBar.hidden = YES;
    self.controller3.navigationBar.hidden = YES;
    self.controller4.navigationBar.hidden = YES;
    self.controller5.navigationBar.hidden = YES;
    
    
    
    //UIViewController *detachedController = [[UIViewController alloc] init];
    
    self.barController = [[CKSideBarController alloc] init];
    self.barController.delegate = self;
//    self.barController.viewControllers = @[
//                                           self.controller1,
//                                           self.controller2,
//                                           self.controller3,
//                                           self.controller4,
//                                           self.controller5
//                                           ];
    
    self.barController.viewControllers = @[
                                           self.controller1,
                                           self.controller2,
                                           self.controller4,
                                           self.controller5
                                           ];
    
    
    self.window.rootViewController = self.barController;
    
    /*
    //Need to set up Facebook login and Parse
    // Whenever a person opens the app, check for a cached session
    if (!FORCE_LOGOUT && FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          // also for intermediate states and NOT just when the session open
                                          [self sessionStateChanged:session state:state error:error];
                                          [self.controller1 dismissViewControllerAnimated:YES completion:nil];
                                      }];
    } else {
        //UIButton *loginButton = [self.loginViewController loginButton];
        //[loginButton setTitle:@"Log in with Facebook" forState:UIControlStateNormal];
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        [self.controller1 presentViewController:loginViewController animated:YES completion:NULL];
        
    }
    
    // At the end of applicationDidFinishLaunching, right before
    // the return YES
    [[GCTurnBasedMatchHelper sharedInstance] authenticateLocalUser];

     */
    return YES;
    
}
							

// During the Facebook login flow, your app passes control to the Facebook iOS app or Facebook in a mobile browser.
// After authentication, your app will be called back with the session information.
// Override application:openURL:sourceApplication:annotation to call the FBsession object that handles the incoming URL
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//Side bar controller stuff
BOOL shouldAlternate = YES;

- (UINavigationController *)navControllerWithImage:(UIImage *)defaultImage selectedImage:(UIImage *)selectedImage tag:(NSString *)s{
    if ([s isEqualToString:@"folder"]) {
        ClassViewController *controller = [[ClassViewController alloc] init];
        controller.view.backgroundColor = [UIColor whiteColor];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        [navController.sideBarItem setImage:defaultImage highlightedImage:selectedImage];
        return navController;
    }
    //check if equal to profile AND if teacher or student to show correct image
    else if ([s isEqualToString:@"profile"]) {
//        TeacherProfileViewController *controller = [[TeacherProfileViewController alloc] init];
        
        StudentProfileViewController *controller = [[StudentProfileViewController alloc]init];
        controller.view.backgroundColor = [UIColor whiteColor];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        [navController.sideBarItem setImage:defaultImage highlightedImage:selectedImage];
        return navController;
    }
    else if ([s isEqualToString:@"search"])
    {
        SearchViewController *controller = [[SearchViewController alloc]init];
        controller.view.backgroundColor = [UIColor whiteColor];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        [navController.sideBarItem setImage:defaultImage highlightedImage:selectedImage];
        return navController;
    }
    else if ([s isEqualToString:@"game"])
    {
        GameViewController *controller = [[GameViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        [navController.sideBarItem setImage:defaultImage highlightedImage:selectedImage];
        return navController;
    }
    
    else {
        CKTestViewController *controller = [[CKTestViewController alloc] init];
        controller.view.backgroundColor = [UIColor whiteColor];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        [navController.sideBarItem setImage:defaultImage highlightedImage:selectedImage];
        return navController;
    }
    return nil;
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
    // Handle the user leaving the app while the Facebook login dialog is being shown
    // For example: when the user presses the iOS "home" button while the login dialog is active
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)logout
{
    // Clear this token
    [FBSession.activeSession closeAndClearTokenInformation];
    // Show the user the logged-out UI
    [self userLoggedOut];
}

// This method will handle ALL the session state changes in the app
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        [self userLoggedIn];
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [self showMessage:alertText withTitle:alertTitle];
                
                // For simplicity, here we just show a generic message for all other errors
                // You can learn how to handle other errors using our guide: https://developers.facebook.com/docs/ios/errors
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [self showMessage:alertText withTitle:alertTitle];
            }
        }
        [self logout];
    }
}

// Show the user the logged-out UI
- (void)userLoggedOut
{
    // Set the button title as "Log in with Facebook"
    UIButton *loginButton = [self.loginViewController loginButton];
    [loginButton setTitle:@"Log in with Facebook" forState:UIControlStateNormal];
    
    // Confirm logout message
    [self showMessage:@"You're now logged out" withTitle:@""];
}

// Show the user the logged-in UI
- (void)userLoggedIn
{
    
    // Set the button title as "Log out"
    UIButton *loginButton = self.loginViewController.loginButton;
    [loginButton setTitle:@"Log out" forState:UIControlStateNormal];
    
    [[FBRequest requestForMe] startWithCompletionHandler:
     ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *aUser, NSError *error) {
         if (error)
             NSLog(@"Error retrieving user: %@", error.description);
         else {
             NSLog(@"User id %@",[aUser objectForKey:@"id"]);
             self.username = aUser[@"id"];
         }
        
         if ([self isTeacher]) {
          //use this to update games list once loaded :p
         }
         
//         if ([self.loginViewController isViewLoaded])
//         {
//             [self.loginViewController dismissViewControllerAnimated:YES completion:^() {
//                 InterestsViewController *interestsViewController = [[InterestsViewController alloc] init];
//                 [self.eventListViewController presentViewController:interestsViewController animated:YES completion:^() {
//                     [self.eventListViewController loadAndUpdateEvents];
//                 }];
//             }];
//         } else {
//             //InterestsViewController *interestsViewController = [[InterestsViewController alloc] init];
//             //[self.eventListViewController presentViewController:interestsViewController animated:YES completion:^() {
//             [self.eventListViewController loadAndUpdateEvents];
//             //}];
//         }
     }];
    
    
}

// Check user's status (teacher or student)
- (void)checkTeacher
{
    Firebase* usersRef = [self.firebase childByAppendingPath:@"users"];
    [usersRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary* users = snapshot.value;
        for (NSDictionary* user in users) {
            if ([user[@"name"] isEqualToString:self.username]) {
                self.isTeacher = YES;
                return;
            }
        }
        self.isTeacher = NO;
    }];
}

// Show an alert message
- (void)showMessage:(NSString *)text withTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:text
                               delegate:self
                      cancelButtonTitle:@"OK!"
                      otherButtonTitles:nil] show];
}

@end
