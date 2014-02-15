//
//  ConquerScene.m
//  edugames
//
//  Created by Gregory Rose on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "ConquerScene.h"

@implementation ConquerScene
{
    bool hexagons[5][5];
}

CGPoint coordToPointWith(int i, int j)
{
    int startx,starty;
    if (i == 0)
    {
        startx = 80;
        starty = 570;
    } else
    {
        startx = 80 + 100*(i-1);
        starty = 455 + 100*(i-1);
    }
    int x = startx + j*100;
    int y = starty + j*60;
    
    return CGPointMake(x,y);
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
//        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        for (int i = 0; i < 5; i++) {
            int limit = 5;
            if (i == 0 || i == 4)
                limit = 4;
            
            int blocked = arc4random() % limit;
            for (int j = 0; j < limit; j++) {
                hexagons[i][j] = (blocked == j);
            }
        }
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"game-bg-2.png"];
        background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:background];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Conqueror!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame) + 250);
        
        [self addChild:myLabel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"close-button"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
