//
//  QuizViewController.m
//  edugames
//
//  Created by Gregory Rose on 2/16/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "QuizViewController.h"

@implementation QuizViewController
{
    NSDictionary* questions;
    void (^callbackOnResponse)(bool);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //[self addBackgroundImage];
//        questions = @{@"a":@"Wa-pa-pa-pa-pa-pa-pow!",
//                      @"b":@"Hatee-hatee-hatee-ho!",
//                      @"c":@"Ring-ding-ding-ding-dingeringeding!",
//                      @"d":@"Jacha-chacha-chacha-chow!",
//                      @"text":@"What does the fox say?",
//                      @"correct":@"b"};
        
        [self addButtons];
        self.view.backgroundColor = [UIColor colorWithRed:0.65 green:0.95 blue:0.95 alpha:1.0];
        
        
    }
    return self;
}

- (id)initWithQuestions:(NSDictionary*)newQuestions andCallback:(void (^)(bool))callback
{
    questions = newQuestions;
    callbackOnResponse = callback;
    self = [super init];
    if (self) {
        
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

- (void) buttonTouched:(id)obj
{
//    NSLog(((UIButton*)obj).titleLabel.text);
    NSString* button;
    if (obj == self.buttonA)
        button = @"a";
    else if (obj == self.buttonB)
        button = @"b";
    else if (obj == self.buttonC)
        button = @"c";
    else
        button = @"d";
    
    bool correct = [button isEqualToString:questions[@"correct"]];
    
    if (correct)
    {
        NSLog(@"that is correct!");
        self.view.backgroundColor = [UIColor greenColor];
    }
    else
    {
        NSLog(@"wah wah");
        self.view.backgroundColor = [UIColor redColor];

    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:^{
            callbackOnResponse(correct);
        }];
    });
}

- (void)addButtons
{
    UIColor *bg = [UIColor colorWithRed:0.35 green:0.65 blue:0.65 alpha:1.0];
    
    // add quiz buttons
    self.buttonA = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonA setTitle:questions[@"a"] forState:UIControlStateNormal];
    self.buttonA.backgroundColor = bg;
    
    self.buttonB = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonB setTitle:questions[@"b"] forState:UIControlStateNormal];
    self.buttonB.backgroundColor = bg;
    
    self.buttonC = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonC setTitle:questions[@"c"] forState:UIControlStateNormal];
    self.buttonC.backgroundColor = bg;
    
    self.buttonD = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonD setTitle:questions[@"d"] forState:UIControlStateNormal];
    self.buttonD.backgroundColor = bg;
    

//    self.question.backgroundColor = bg;
    
    int screenWidth = self.view.frame.size.height;
    int screenHeight = self.view.frame.size.width;
    int width = 0.8 * screenWidth;
    int left = (self.view.frame.size.height - width)/2;
    int top = 310;
    int height = screenHeight * 0.1;
    int padding = height + 10;
    
    UILabel* question = [[UILabel alloc] init];
    question.frame = CGRectMake(left, top - padding, width, height);
    question.text = questions[@"text"];
    question.textColor = [UIColor blackColor];
    question.textAlignment = NSTextAlignmentCenter;
    [question adjustsFontSizeToFitWidth];
//    [question setCenter:self.view.center];
//    self.question = [UIButton buttonWithType:UIButtonTypeCustom];
    //[self.question setTitle:@"What does the fox say? " forState:UIControlStateNormal];
    
    //self.question.frame = CGRectMake(left, top - padding, width, height);
    
    self.buttonA.frame = CGRectMake(left, top, width, height);
    [self.buttonA addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonB.frame = CGRectMake(left, top + padding, width, height);
    [self.buttonB addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonC.frame = CGRectMake(left, top + 2*padding, width, height);
    [self.buttonC addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonD.frame = CGRectMake(left, top + 3*padding, width, height);
    [self.buttonD addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    UIImage *btnImageA = [UIImage imageNamed:@"login-button.png"];
//    [self.buttonA setImage:btnImageA forState:UIControlStateNormal];
//    self.buttonA.contentMode = UIViewContentModeScaleToFill;
//    
//    UIImage *btnImageB = [UIImage imageNamed:@"login-button.png"];
//    [self.buttonA setImage:btnImageB forState:UIControlStateNormal];
//    self.buttonA.contentMode = UIViewContentModeScaleToFill;
//    
//    UIImage *btnImageC = [UIImage imageNamed:@"login-button.png"];
//    [self.buttonA setImage:btnImageC forState:UIControlStateNormal];
//    self.buttonA.contentMode = UIViewContentModeScaleToFill;
//    
//    UIImage *btnImageD = [UIImage imageNamed:@"login-button.png"];
//    [self.buttonA setImage:btnImageD forState:UIControlStateNormal];
//    self.buttonA.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:question];
    [self.view addSubview:self.buttonA];
    [self.view addSubview:self.buttonB];
    [self.view addSubview:self.buttonC];
    [self.view addSubview:self.buttonD];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        [[self presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
//    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
