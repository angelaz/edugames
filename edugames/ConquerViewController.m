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
}

- (void) onUpdate:(NSDictionary*) gameData {
    [scene onUpdate:gameData];
};

- (void) playerInput:(NSDictionary*) inputData {
    
};

- (id)initWithKey:(NSString*) key
{
    self = [super init];
    if (self) {
        Game* conquerorGame = [[Game alloc] initWithKey:key andController:self];
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Hack to change view to SKView
    self.view = [[SKView alloc] initWithFrame:self.view.frame];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    scene = [ConquerScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
//    
//    UIImage *image = [UIImage imageNamed:@"game-bg-2.png"];
//    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:image];
//    [skView addSubview:backgroundView];
    
    // Present the scene.
    [skView presentScene:scene];
}



@end
