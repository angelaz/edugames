//
//  LoginViewController.m
//  edugames
//
//  Created by Lucy Guo on 2/14/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

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
    //trying to put in weird rectangle
    self.modalView = [[UIViewController alloc] init];
    self.modalView.modalPresentationStyle = UIModalPresentationFormSheet;
    self.modalView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:self.modalView animated:YES];
    self.modalView.view.superview.frame = CGRectMake(0, 0, 540, 620); //it's important to do this after presentModalViewController
    self.modalView.view.superview.center = self.view.center;
    
    //self.modalView.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"modal-bg.png"];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:image];
    
    [self.modalView.view addSubview:backgroundView];
    
    //add close button to modal view controller
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    closeButton.frame = CGRectMake(12, 12, 17, 17);
    [closeButton addTarget:self action:@selector(closeModalView) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"close-button.png"];
    [closeButton setImage:btnImage forState:UIControlStateNormal];
    closeButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.modalView.view addSubview:closeButton];
    
    //add facebook button to modal view controller
    UIButton *facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    facebookButton.frame = CGRectMake(78, 100, 395, 59);
    [facebookButton addTarget:self action:@selector(facebookLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *fbImg = [UIImage imageNamed:@"facebook-login.png"];
    [facebookButton setImage:fbImg forState:UIControlStateNormal];
    facebookButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.modalView.view addSubview:facebookButton];
    
    //add regular button to modal view controller
    UIButton *regularLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [regularLogin setTitle:@"Show View" forState:UIControlStateNormal];
    
    regularLogin.frame = CGRectMake(78, 100+350, 395, 59);
    [regularLogin addTarget:self action:@selector(facebookLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *regImg = [UIImage imageNamed:@"regular-login.png"];
    [regularLogin setImage:regImg forState:UIControlStateNormal];
    regularLogin.contentMode = UIViewContentModeScaleToFill;
    
    [self.modalView.view addSubview:regularLogin];

}

- (IBAction)facebookLogin:(id)sender
{
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for basic_info permissions when opening a session
        [FBSession openActiveSessionWithPublishPermissions:@[@"basic_info", @"create_event"] defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:YES completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             // Retrieve the app delegate
             AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [appDelegate sessionStateChanged:session state:state error:error];
         }];
    }
}

- (void)closeModalView
{
    NSLog(@"did it go in here");
    [self.modalView dismissViewControllerAnimated:YES completion:nil];
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
