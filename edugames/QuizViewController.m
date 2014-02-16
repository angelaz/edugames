//
//  QuizViewController.m
//  edugames
//
//  Created by Gregory Rose on 2/16/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "QuizViewController.h"

@implementation QuizViewController

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

- (void)closeModalView
{
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
    // add quiz buttons
    self.buttonA = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonA setTitle:@"A: " forState:UIControlStateNormal];
    
    self.buttonB = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonB setTitle:@"B: " forState:UIControlStateNormal];
    
    self.buttonC = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonC setTitle:@"C: " forState:UIControlStateNormal];
    
    self.buttonD = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonD setTitle:@"D: " forState:UIControlStateNormal];
    
    self.buttonA.frame = CGRectMake((self.view.frame.size.width - 263)/2 + 110, 310 + 83, 301, 63);
    [self.buttonA addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonB.frame = CGRectMake((self.view.frame.size.width - 263)/2 + 110, 310 + 83, 301, 63);
    [self.buttonA addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonC.frame = CGRectMake((self.view.frame.size.width - 263)/2 + 110, 310 + 83, 301, 63);
    [self.buttonA addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonD.frame = CGRectMake((self.view.frame.size.width - 263)/2 + 110, 310 + 83, 301, 63);
    [self.buttonA addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImage *btnImageA = [UIImage imageNamed:@"login-button.png"];
    [self.buttonA setImage:btnImageA forState:UIControlStateNormal];
    self.buttonA.contentMode = UIViewContentModeScaleToFill;
    
    UIImage *btnImageB = [UIImage imageNamed:@"login-button.png"];
    [self.buttonA setImage:btnImageB forState:UIControlStateNormal];
    self.buttonA.contentMode = UIViewContentModeScaleToFill;
    
    UIImage *btnImageC = [UIImage imageNamed:@"login-button.png"];
    [self.buttonA setImage:btnImageC forState:UIControlStateNormal];
    self.buttonA.contentMode = UIViewContentModeScaleToFill;
    
    UIImage *btnImageD = [UIImage imageNamed:@"login-button.png"];
    [self.buttonA setImage:btnImageD forState:UIControlStateNormal];
    self.buttonA.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.buttonA];
    [self.view addSubview:self.buttonB];
    [self.view addSubview:self.buttonC];
    [self.view addSubview:self.buttonD];
    
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
