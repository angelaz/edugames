//
//  AppDelegate.h
//  edugames
//
//  Created by Angela Zhang on 2/14/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

#import "LoginViewController.h"
#import "CKSideBarController.h"
#import "CKTestViewController.h"
#import "ClassViewController.h"
#import "TeacherProfileViewController.h"
#import "StudentProfileViewController.h"
#import "SearchViewController.h"
#import "GameViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LoginViewController *loginViewController;

@property (strong, nonatomic) NSString *username;
- (void)updateViewControllers;

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
- (void)userLoggedIn;
- (void)userLoggedOut;
- (void)showMessage:(NSString *)text withTitle:(NSString *)title;
- (void)logout;


@end
