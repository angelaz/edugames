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
    NSDictionary* gameState;
    // map of hexagons
    // player locations
}

int geti(int u)
{
    return u / 5;
}

int getj(int u)
{
    return u % 5;
}

int pack(int i, int j)
{
    return 5*i + j;
}

CGPoint coordToPoint(int i, int j)
{
    int startx, starty;
    if (i == 0)
    {
        startx = 80;
        starty = 570;
    } else
    {
        startx = 80 + 100*(i-1);
        starty = 455 - 60*(i-1);
    }
    int x = startx + j*100;
    int y = starty + j*60;
    
    NSLog(@"i: %d, j: %d, x: %d, y: %d", i, j, x, y);
    
    return CGPointMake(x,y);
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
//        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"game-bg-2.png"];
        background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:background];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Conqueror!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame) + 250);
        
        [self addChild:myLabel];
        
        
        NSMutableDictionary* points = [[NSMutableDictionary alloc] init];
        NSMutableDictionary* hexagons = [[NSMutableDictionary alloc] init];
        
        for (int i = 0; i < 5; i++) {
            int limit = 5;
            if (i == 0 || i == 4)
                limit = 4;
            
            int blocked = arc4random() % limit;
            for (int j = 0; j < limit; j++) {
                NSNumber* u = [NSNumber numberWithInt:pack(i, j)];
                points[u] = [NSNumber numberWithBool:(blocked == j)];
                
                SKSpriteNode *hexagon = [SKSpriteNode spriteNodeWithImageNamed:@"close-button.png"];
                hexagon.position = coordToPoint(i, j);
                //hexagon.isHidden = (blocked == j);
                [self addChild:hexagon];
                hexagons[u] = hexagon;
            }
        }
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
