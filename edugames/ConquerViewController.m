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
}

- (void) onUpdate:(NSDictionary*) gameData {
    if (scene)
        [scene onUpdate:gameData];
    
    id x = gameData[@"turnId"];
    int y =[gameData[@"turnId"] intValue];

    // HACK to start game faster
    if (!didStart) //(!didStart && [gameData[@"turnId"] intValue] != 0)
    {
        [self gameStart];
        didStart = true;
    }
    
};

- (void) playerInput:(NSDictionary*) inputData {
    
};

- (id)initWithKey:(NSString*) key
{
    self = [super init];
    if (self) {
        didStart = false;
        conquerorGame = [[Game alloc] initWithKey:key andController:self];
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
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 360, 400, 50)];
    loadingLabel.text = @"Waiting for player...";
    loadingLabel.font = [UIFont fontWithName:@"Chalkduster" size:30];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loadingLabel];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    [loadingLabel setBackgroundColor:[UIColor whiteColor]];
    
    //[self gameStart];
}

- (void)gameStart
{
    
    
    [loadingLabel setHidden:YES];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
    
    // Create and configure the scene.

    scene = [[ConquerScene alloc] initWithSize:skView.bounds.size andGame:conquerorGame];
    scene.scaleMode = SKSceneScaleModeAspectFill;
//    
//    UIImage *image = [UIImage imageNamed:@"game-bg-2.png"];
//    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:image];
//    [skView addSubview:backgroundView];
    
    // Present the scene.
    [skView presentScene:scene];
}



@end
