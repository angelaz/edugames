//
//  LoginViewController.h
//  edugames
//
//  Created by Lucy Guo on 2/14/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

#import "AppDelegate.h"
#import "LoginViewController.h"

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) IBOutlet UIButton *registerButton;

@property (strong, nonatomic) UIViewController *modalView;



@end
