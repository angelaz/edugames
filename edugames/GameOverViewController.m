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
        [self addLabels];
    }
    return self;
}

- (id)initWithWinner:(int)winner andPlayerId:(int)playerId
{
    // TODO(Mar 30): put winner text
    // TODO(Lucy): display name of person
    
    bool youWin = (winner == playerId);
    
    return [self init];
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

- (void)addLabels
{
    //player 1 points
    _pointsLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.height/4 - 13, self.view.frame.size.width/2-20, self.view.frame.size.width/1.4, 300)];
    [_pointsLabel1 setText:@"2047"];
    _pointsLabel1.font = [_pointsLabel1.font fontWithSize:30];
    
    [_pointsLabel1 setTextColor:[UIColor whiteColor]];
    [_pointsLabel1 setLineBreakMode:NSLineBreakByWordWrapping];
    [_pointsLabel1 setNumberOfLines:0];
    [self.view addSubview:_pointsLabel1];
    
    //player2 points
    _pointsLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.height/4 +500, self.view.frame.size.width/2-20, self.view.frame.size.width/1.4, 300)];
    [_pointsLabel2 setText:@"2047"];
    _pointsLabel2.font = [_pointsLabel1.font fontWithSize:30];
    
    [_pointsLabel2 setTextColor:[UIColor whiteColor]];
    [_pointsLabel2 setLineBreakMode:NSLineBreakByWordWrapping];
    [_pointsLabel2 setNumberOfLines:0];
    [self.view addSubview:_pointsLabel2];
    
    //add player name
    _winner = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.height/4 + 230, self.view.frame.size.width/2-20, self.view.frame.size.width/1.4, 610)];
    [_winner setText:@"Matthew Thomas"];
    _winner.font = [_winner.font fontWithSize:60];
    [_winner setTextColor:[UIColor whiteColor]];
    [_winner setLineBreakMode:NSLineBreakByWordWrapping];
    [_winner setNumberOfLines:0];
    [self.view addSubview:_winner];

    
}

@end
