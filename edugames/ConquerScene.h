//
//  ConquerScene.h
//  edugames
//
//  Created by Gregory Rose on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Game.h"
#import "QuizViewController.h"

@interface ConquerScene : SKScene

- (void) onUpdate:(NSDictionary*) gameData;
- (id)initWithSize:(CGSize)size andGame:(Game*)newGame;
+ (NSMutableDictionary*) createGameState;
- (id)initWithSize:(CGSize)size andGame:(Game*)newGame andController:(ConquerViewController*)cont;

@end
