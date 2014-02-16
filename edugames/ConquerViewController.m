//
//  ConquerViewController.m
//  edugames
//
//  Created by Gregory Rose on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "ConquerViewController.h"
#import "Game.h"
#import "ConquerScene.h"

@implementation ConquerViewController
{
    ConquerScene* scene;
    Game* conquerorGame;
    
    UILabel* loadingLabel;
    bool didStart;
    CGRect saved;
    NSDictionary* gameInfo;
}

- (void) onUpdate:(NSDictionary*) gameData {
    if (scene)
        [scene onUpdate:gameData];

    if (!didStart && [gameData[@"gameState"][@"turnId"] intValue] != 0)
    {
        [self gameStart];
        didStart = true;
    }
    
};

- (void) playerInput:(NSDictionary*) inputData {
    
};

- (id)initWithKey:(NSString*) key andGameInfo:(NSDictionary*)newGameInfo
{
    self = [super init];
    if (self) {
        didStart = false;
        conquerorGame = [[Game alloc] initWithKey:key andController:self andGameInfo:newGameInfo];
        gameInfo = newGameInfo;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    // Hack to change view to SKView
    self.view = [[SKView alloc] initWithFrame:saved];
    
    // TODO(Greg): remove later
//    [self gameStart];
//    return;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 360, 400, 50)];
    loadingLabel.text = @"Waiting for player...";
    loadingLabel.font = [UIFont fontWithName:@"Chalkduster" size:30];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loadingLabel];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    //[self gameStart];
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

- (void) showQuestionsWithCallback:(void (^)(bool))callback
{
    NSArray* questionSets = [(NSDictionary*)gameInfo[@"questions"] allValues];
//    @{@"a":@"Wa-pa-pa-pa-pa-pa-pow!",
//      @"b":@"Hatee-hatee-hatee-ho!",
//      @"c":@"Ring-ding-ding-ding-dingeringeding!",
//      @"d":@"Jacha-chacha-chacha-chow!",
//      @"text":@"What does the fox say?",
//      @"correct":@"b"}
    
    uint32_t rnd = arc4random_uniform([questionSets count]);
    NSDictionary* question = [questionSets objectAtIndex:rnd];
    
    
    QuizViewController *quizViewController = [[QuizViewController alloc] initWithQuestions:question andCallback:callback];
    [self presentViewController:quizViewController animated:YES completion:NULL];
}


- (void)gameStart
{
    
    
    [loadingLabel setHidden:YES];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
    
    // Create and configure the scene.

    scene = [[ConquerScene alloc] initWithSize:skView.bounds.size andGame:conquerorGame andController:self];
    scene.scaleMode = SKSceneScaleModeAspectFill;
//    
//    UIImage *image = [UIImage imageNamed:@"game-bg-2.png"];
//    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:image];
//    [skView addSubview:backgroundView];
    
    // Present the scene.
//    QuizViewController *quizViewController = [[QuizViewController alloc] initWithQuestions:
//                                              @{@"a":@"Wa-pa-pa-pa-pa-pa-pow!",
//                                                @"b":@"Hatee-hatee-hatee-ho!",
//                                                @"c":@"Ring-ding-ding-ding-dingeringeding!",
//                                                @"d":@"Jacha-chacha-chacha-chow!",
//                                                @"text":@"What does the fox say?",
//                                                @"correct":@"b"}];
//    [self.view.window.rootViewController presentViewController:quizViewController animated:YES completion:NULL];
    [skView presentScene:scene];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        [self presentViewController:quizViewController animated:YES completion:NULL];
//    });
    
    
}



@end
