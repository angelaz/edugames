//
//  GameOverViewController.m
//  edugames
//
//  Created by Lucy Guo on 3/30/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "GameOverViewController.h"

@interface GameOverViewController ()

@end

@implementation GameOverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self addBackgroundImage];
        [self addCloseButton];
    }
    return self;
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

- (void)addBackgroundImage
{
    
    UIImage *image = [UIImage imageNamed:@"gameover.png"];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:backgroundView];
}

- (void)addCloseButton
{
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_closeButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    _closeButton.frame = CGRectMake(25, 25, 46, 46);
    [_closeButton addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"game-close.png"];
    [_closeButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    _closeButton.contentMode = UIViewContentModeScaleToFill;
    
    _closeButton.tag = 0;
    
    [self.view addSubview:_closeButton];
}

- (void)closeButton:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}

@end
