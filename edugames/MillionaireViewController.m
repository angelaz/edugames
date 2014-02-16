//
//  MillionaireViewController.m
//  Millionaire
//
//  Created by Angela Zhang on 2/15/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "MillionaireViewController.h"

@interface MillionaireViewController ()

@end

@implementation MillionaireViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"game-bg-1.png"];
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:image];
        [self.view addSubview:backgroundView];
        [self addTopLeftButton];
        [self addBottomLeftButton];
        [self addTopRightButton];
        [self addBottomRightButton];
        [self addQuestionLabel];
        [self addCloseButton];
        
        //  TODO: Hey guys, can you populate this with the result of querying for some random set of questions please? :D
        _questions = [[NSMutableArray alloc] initWithObjects:@"", nil];
    }
    return self;
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
    [self.navigationController popToRootViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];

}

- (void)addQuestionLabel
{
    _questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.height/4, self.view.frame.size.width/2-20, self.view.frame.size.width/1.4, 200)];
    [_questionLabel setText:@"Look it's a really long sample question to test the size of this box and also to check if the word wrapping is working correctly hopefully it is oh look at my lack of commas or coherency. Question?"];
    [_questionLabel setTextColor:[UIColor blackColor]];
    [_questionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [_questionLabel setNumberOfLines:0];
    [_questionLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_questionLabel];
}

- (void)addTopLeftButton
{
    CGFloat buttonHeight = 60;
    
    _topLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [_topLeft setTitle:@"Top Left Button" forState:UIControlStateNormal];
    [_topLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_topLeft setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    _topLeft.frame = CGRectMake(30, 570, self.view.frame.size.width/2+20, buttonHeight);
    [_topLeft addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"game-button-1.png"];
    [_topLeft setBackgroundImage:btnImage forState:UIControlStateNormal];
    _topLeft.contentMode = UIViewContentModeScaleToFill;
    
    _topLeft.tag = 0;
    
    [self.view addSubview:_topLeft];
}

- (void)addBottomLeftButton
{
    CGFloat buttonHeight = 60;
    
    _topLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [_topLeft setTitle:@"Bottom Left Button" forState:UIControlStateNormal];
    [_topLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_topLeft setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    _topLeft.frame = CGRectMake(30, 670, self.view.frame.size.width/2+20, buttonHeight);
    [_topLeft addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"game-button-1.png"];
    [_topLeft setBackgroundImage:btnImage forState:UIControlStateNormal];
    _topLeft.contentMode = UIViewContentModeScaleToFill;
    
    _topLeft.tag = 1;
    
    [self.view addSubview:_topLeft];
}

- (void)addBottomRightButton
{
    CGFloat buttonHeight = 60;
    
    _topLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [_topLeft setTitle:@"Bottom Left Button" forState:UIControlStateNormal];
    [_topLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_topLeft setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    _topLeft.frame = CGRectMake(self.view.frame.size.height/2 - 10, 670, self.view.frame.size.width/2, buttonHeight);
    [_topLeft addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"game-button-1.png"];
    [_topLeft setBackgroundImage:btnImage forState:UIControlStateNormal];
    _topLeft.contentMode = UIViewContentModeScaleToFill;
    
    _topLeft.tag = 3;
    
    [self.view addSubview:_topLeft];
}

- (void)addTopRightButton
{
    CGFloat buttonHeight = 60;
    
    _topLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [_topLeft setTitle:@"Bottom Left Button" forState:UIControlStateNormal];
    [_topLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_topLeft setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    _topLeft.frame = CGRectMake(self.view.frame.size.height/2 - 10, 570, self.view.frame.size.width/2, buttonHeight);
    [_topLeft addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"game-button-1.png"];
    [_topLeft setBackgroundImage:btnImage forState:UIControlStateNormal];
    _topLeft.contentMode = UIViewContentModeScaleToFill;
    
    _topLeft.tag = 2;
    
    [self.view addSubview:_topLeft];
}

- (void)buttonTouched:(id)sender
{
    NSLog(@"button touched!");
    UIButton *button = (UIButton*)sender;
    NSLog(@"%zd", button.tag);
    
    [self refreshQuestion:sender];
}

- (void)refreshQuestion:(id)sender
{
    // TODO: Angela change index of array we're getting question from, change question and button labels, change tag for
    //   which answer is correct, also keep track of where we are money-wise in the game and display some appropriate dialogue
    UIButton *button = (UIButton*)sender;
    [button setTitle:@"Changed!" forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/pokemon.mp3", [[NSBundle mainBundle] resourcePath]]];
	
	NSError *error;
	_audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	_audioPlayer.numberOfLoops = -1;
	
	if (_audioPlayer == nil)
		NSLog([error description]);
	else
		[_audioPlayer play];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
