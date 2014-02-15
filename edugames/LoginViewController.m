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
    }
    return self;
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
