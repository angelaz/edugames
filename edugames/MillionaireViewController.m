//
//  MillionaireViewController.m
//  Millionaire
//
//  Created by Angela Zhang on 2/15/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "MillionaireViewController.h"
#import <Firebase/Firebase.h>

@interface MillionaireViewController ()

@end

@implementation MillionaireViewController {
    NSMutableArray *qKeys;
    int qIndex;
    
}

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
        [self addMoneyLabel];
        
        _questions = [[NSMutableDictionary alloc] initWithDictionary:nil];
        qKeys = [[NSMutableArray alloc] initWithArray:nil];
    }
    return self;
}

- (void)addMoneyLabel
{
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(600, 70, 300, 50)];
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(600, 70, 300, 50)];
    [_moneyLabel setText:[NSString stringWithFormat:@"You Have: $%d", [self getMoney]]];
    [_moneyLabel setFont:[UIFont fontWithName:@"Helvetica" size:26]];
    [_moneyLabel setTextColor:[UIColor yellowColor]];
    [self.moneyLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.moneyLabel setNumberOfLines:0];
    [self.moneyLabel setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:_moneyLabel];
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
    
    _bottomLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomLeft setTitle:@"Bottom Left Button" forState:UIControlStateNormal];
    [_bottomLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_bottomLeft setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    _bottomLeft.frame = CGRectMake(30, 670, self.view.frame.size.width/2+20, buttonHeight);
    [_bottomLeft addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"game-button-1.png"];
    [_bottomLeft setBackgroundImage:btnImage forState:UIControlStateNormal];
    _bottomLeft.contentMode = UIViewContentModeScaleToFill;
    
    _bottomLeft.tag = 1;
    
    [self.view addSubview:_bottomLeft];
}

- (void)addBottomRightButton
{
    CGFloat buttonHeight = 60;
    
    _bottomRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomRight setTitle:@"Bottom Left Button" forState:UIControlStateNormal];
    [_bottomRight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_bottomRight setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    _bottomRight.frame = CGRectMake(self.view.frame.size.height/2 - 10, 670, self.view.frame.size.width/2, buttonHeight);
    [_bottomRight addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"game-button-1.png"];
    [_bottomRight setBackgroundImage:btnImage forState:UIControlStateNormal];
    _bottomRight.contentMode = UIViewContentModeScaleToFill;
    
    _bottomRight.tag = 3;
    
    [self.view addSubview:_bottomRight];
}

- (void)addTopRightButton
{
    CGFloat buttonHeight = 60;
    
    _topRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [_topRight setTitle:@"Bottom Left Button" forState:UIControlStateNormal];
    [_topRight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_topRight setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    _topRight.frame = CGRectMake(self.view.frame.size.height/2 - 10, 570, self.view.frame.size.width/2, buttonHeight);
    [_topRight addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"game-button-1.png"];
    [_topRight setBackgroundImage:btnImage forState:UIControlStateNormal];
    _topRight.contentMode = UIViewContentModeScaleToFill;
    
    _topRight.tag = 2;
    
    [self.view addSubview:_topRight];
}

- (NSString *)getButton:(NSInteger)tag
{
    if (tag == 0) {
        return @"a";
    }
    if (tag == 1) {
        return @"b";
    }
    if (tag == 2) {
        return @"c";
    }
    return @"d";
}

- (int)getMoney
{
    switch (qIndex) {
        case 0:
            return 0;
        case 1:
            return 1000;
        case 2:
            return 2000;
        case 3:
            return 4000;
        case 4:
            return 8000;
        case 5:
            return 16000;
        case 6:
            return 32000;
        case 7:
            return 64000;
        case 8:
            return 125000;
        case 9:
            return 250000;
        case 10:
            return 500000;
        case 11:
            return 1000000;
    }
    return 0;  //Should never get here
}

- (void)buttonTouched:(id)sender
{
    UIButton *button = (UIButton*)sender;
    NSString *buttonName = [self getButton:button.tag];
    
    NSString *ans = [[_questions objectForKey:[qKeys objectAtIndex:qIndex]] objectForKey:@"correct"];
    
    if ([buttonName isEqualToString:ans] && qIndex < 10) {
        qIndex ++;
    } else {
        if (qIndex < 10) {
            qIndex ++;
        }
    }
    
    [self refreshQuestion:sender];
}

- (void)refreshQuestion:(id)sender
{
    // TODO: Angela change index of array we're getting question from, change question and button labels, change tag for
    //   which answer is correct, also keep track of where we are money-wise in the game and display some appropriate dialogue
    UIButton *button = (UIButton*)sender;
    [button setTitle:@"Changed!" forState:UIControlStateNormal];
    NSDictionary *curQuestion = [_questions objectForKey:[qKeys objectAtIndex:qIndex]];
    _questionLabel.text = [curQuestion objectForKey:@"text"];
    [_topLeft setTitle:[curQuestion objectForKey:@"a"] forState:UIControlStateNormal];
    [_bottomLeft setTitle:[curQuestion objectForKey:@"b"] forState:UIControlStateNormal];
    [_topRight setTitle:[curQuestion objectForKey:@"c"] forState:UIControlStateNormal];
    [_bottomRight setTitle:[curQuestion objectForKey:@"d"] forState:UIControlStateNormal];
    [_moneyLabel setText:[NSString stringWithFormat:@"You Have: $%d", [self getMoney]]];
}

- (void)updateKeys
{
    NSMutableArray *allKeys = [[_questions allKeys] mutableCopy];
    for (NSString *key in allKeys) {
        //id object = [_questions objectForKey: key];
        [qKeys addObject:key];
    }
    qIndex = 0;
    [self refreshQuestion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //  Firebase
    //  Firebase
    NSString* url = @"https://edugames.firebaseio.com/games/-JFolzigUK-BhNxu3jRv/questions"; // Hardcoded for now
    Firebase* dataRef = [[Firebase alloc] initWithUrl:url];
    [dataRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        _questions = snapshot.value;
        //[_questions setObject:@"" forKey:@"extra"]; //TODO: add extra object so it doesn't crash later
        [self updateKeys];
    }];

    
    NSURL *url2 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/pokemon.mp3", [[NSBundle mainBundle] resourcePath]]];
	
	NSError *error;
	_audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:&error];
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
