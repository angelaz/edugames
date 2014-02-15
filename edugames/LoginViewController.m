//
//  LoginViewController.m
//  edugames
//
//  Created by Lucy Guo on 2/14/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self addBackgroundImage];
        [self addButtons];
    }
    return self;
}

- (IBAction)buttonTouched:(id)sender
{
    // If the session state is any of the two "open" states when the button is clicked
//    if (FBSession.activeSession.state == FBSessionStateOpen
//        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
//        
//        // Close the session and remove the access token from the cache
//        // The session state handler (in the app delegate) will be called automatically
//        [FBSession.activeSession closeAndClearTokenInformation];
//        
//        // If the session state is not any of the two "open" states when the button is clicked
//    } else {
//        // Open a session showing the user the login UI
//        // You must ALWAYS ask for basic_info permissions when opening a session
//        [FBSession openActiveSessionWithPublishPermissions:@[@"basic_info", @"create_event"] defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:YES completionHandler:
//         ^(FBSession *session, FBSessionState state, NSError *error) {
//             // Retrieve the app delegate
//             AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
//             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
//             [appDelegate sessionStateChanged:session state:state error:error];
//         }];
//    }
}

- (void)addBackgroundImage
{
//    UIGraphicsBeginImageContext(self.view.frame.size);
//    [[UIImage imageNamed:@"login-bg.png"] drawInRect:self.view.bounds];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UIImage *image = [UIImage imageNamed:@"login-bg.png"];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:backgroundView];
}

- (void)addButtons
{
    // add login button
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.loginButton.frame = CGRectMake((self.view.frame.size.width - 263)/2 + 110, 310 + 83, 301, 63);
    [self.loginButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"login-button.png"];
    [self.loginButton setImage:btnImage forState:UIControlStateNormal];
    self.loginButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.loginButton];
    
    // add register button
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.loginButton.frame = CGRectMake((self.view.frame.size.width - 263)/2 + 110, 310, 301, 63);
    [self.loginButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage2 = [UIImage imageNamed:@"register-button.png"];
    [self.loginButton setImage:btnImage2 forState:UIControlStateNormal];
    self.loginButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.loginButton];


}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //trying to put in weird rectangle
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
