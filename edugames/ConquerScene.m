//
//  ConquerScene.m
//  edugames
//
//  Created by Gregory Rose on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "ConquerScene.h"
#import "Game.h"

@implementation ConquerScene
{
    NSMutableDictionary* hexagons;
    
    SKSpriteNode* player1Sprite;
    SKSpriteNode* player2Sprite;
    Game* game;
    
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

CGPoint unpack(NSNumber* x)
{
    int u = [x intValue];
    return CGPointMake(geti(u), getj(u));
}

NSNumber* pack(int i, int j)
{
    return [NSNumber numberWithInt:(5*i + j)];
}

NSNumber* cgpack(CGPoint p)
{
    return pack(p.x, p.y);
}

CGPoint cgCoordToPoint(CGPoint p)
{
    return coordToPoint(p.x, p.y);
}

static const int STARTX = 205;
static const int STARTYLOWER = 330;
static const int STARTYUPPER = 445;
static const int DX = 100;
static const int DY = 60;

CGPoint coordToPoint(int i, int j)
{
    int startx, starty;
    if (i == 0)
    {
        startx = STARTX;
        starty = STARTYUPPER;
    } else
    {
        startx = STARTX + DX*(i-1);
        starty = STARTYLOWER - DY*(i-1);
    }
    
    int x = startx + j*DX;
    int y = starty + j*DY;
    
    return CGPointMake(x,y);
}

// Given a position p, return the board coordinates
// of the nearest hexagon
CGPoint pointToCoord(CGPoint p)
{
    int col = round(((int)p.x - STARTX)/(double)DX);
    int x = STARTX + col*DX;
    
    int starty;
    // avoids issues with 1 vs -1
    if (col % 2 == 0)
        starty = STARTYUPPER;
    else
        starty = STARTYLOWER + DY;
    
    int row = round(((int)p.y - starty)/(double)(2*DY));
    int y = starty + row*(2*DY);
    
    int base = -round(((y - col*DY) - STARTYUPPER)/(double)(2*DY));
    int basecol;
    if (base == 0)
        basecol = 0;
    else
        basecol = base - 1;
    
    int baseOffset = col - basecol;
    
    return CGPointMake(base, baseOffset);
}

+ (NSMutableDictionary*) createGameState {
    NSMutableDictionary* points = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < 5; i++) {
        int limit = 5;
        if (i == 0 || i == 4)
            limit = 4;
        
        int blocked = arc4random() % limit;
        for (int j = 0; j < limit; j++) {
            NSString* u = [NSString stringWithFormat:@"%@", pack(i, j)];
            points[u] = [NSNumber numberWithBool:YES /*(blocked == j) */];
        }
    }
    
    // Create game state
    NSNumber* player1 = pack(0, 0);
    NSNumber* player2 = pack(4, 3);
    
    
    return [NSMutableDictionary dictionaryWithObjects:@[points, player1, player2] forKeys:@[@"points", @"player1", @"player2"]];
}

/* Setup your scene here */
- (id)initWithSize:(CGSize)size andGame:(Game*)newGame {
    if (self = [super initWithSize:size]) {
        game = newGame;
        
        //self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"game-bg-2.png"];
        background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:background];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Conqueror!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame) + 250);
        
        [self addChild:myLabel];
        
        hexagons = [[NSMutableDictionary alloc] init];
        NSMutableArray* points = game.gameState[@"points"];
        
        for (int i = 0; i < [points count]; i++)
        {
            if (points[i] == (id)[NSNull null]) continue;
            
            NSNumber* n = [NSNumber numberWithInt:i];
            
            SKSpriteNode *hexagon = [SKSpriteNode spriteNodeWithImageNamed:@"singlehexagon"];
            [hexagon setColor:[UIColor redColor]];
            hexagon.color = [UIColor blueColor];
            hexagon.colorBlendFactor = 0.5;
            
            hexagon.position = cgCoordToPoint(unpack(n));
            [hexagon setHidden:![points[i] boolValue]];
            [self addChild:hexagon];
            hexagons[n] = hexagon;
        }
        
        player1Sprite = [SKSpriteNode spriteNodeWithImageNamed:@"leafers.png"];
        [player1Sprite setScale:0.5];
        player1Sprite.xScale *= -1.0;
        player1Sprite.position = coordToPoint(0, 0);
        
        [self addChild:player1Sprite];
        
        player2Sprite = [SKSpriteNode spriteNodeWithImageNamed:@"piceratops.png"];
        [player2Sprite setScale:0.5];
        player2Sprite.position = coordToPoint(4, 3);
        [self addChild:player2Sprite];
        
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        //SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"singlehexagon"];
        
        CGPoint coord = pointToCoord(location);
        NSArray *nodes = [self nodesAtPoint:[touch locationInNode:self]];
        
        SKSpriteNode* hexagon = hexagons[cgpack(coord)];
        [hexagon setColor:[UIColor greenColor]];

        
        SKAction *moveNodeUp = [SKAction moveTo:cgCoordToPoint(coord) duration:0.5];
        [player1Sprite runAction: moveNodeUp];
        
        // TODO:
//        for (SKSpriteNode *other in nodes)
//        {
//            for (SKSpriteNode *spr in [hexagons allValues])
//            {
//                if (other == spr)
//                {
//                    [spr setColor:[UIColor greenColor]];
//                    
//                    SKAction *moveNodeUp = [SKAction moveTo:spr.position duration:0.5];
//                    [player1Sprite runAction: moveNodeUp];
//                }
//            }
//        }
            //[spr setColor:[UIColor greenColor]];
        
        
        //sprite.position = location;
        
        NSLog(@"x: %f, y: %f", location.x, location.y);
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        //[sprite runAction:[SKAction repeatActionForever:action]];
        
        //[self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}
- (void) onUpdate:(NSDictionary*) gameData {
    NSLog(@"Got update");
    NSDictionary* gameState = gameData[@"gameState"];
    
    id x = gameState[@"player1"];
    CGPoint y = unpack(gameState[@"player1"]);
    CGPoint z = cgCoordToPoint(unpack(gameState[@"player1"]));
    
    player1Sprite.position = cgCoordToPoint(unpack(gameState[@"player1"]));
    player2Sprite.position = cgCoordToPoint(unpack(gameState[@"player2"]));
    NSArray* points = gameState[@"points"];
    
    for (int i = 0; i < [points count]; i++)
    {
        if (points[i] == (id)[NSNull null]) continue;
        
        NSNumber* n = [NSNumber numberWithInt:i];
        SKSpriteNode *hexagon = hexagons[n];// [NSNumber numberWithBool:(blocked == j)];
        [hexagon setHidden:![points[i] boolValue]];
    }
//    player1Sprite.position = CGPointMake(400,400);
    //player1Sprite.position = coordToPoint(0, 0);
    //[self addChild:player1Sprite];

    
    NSLog(@"Updated!");
};

@end
