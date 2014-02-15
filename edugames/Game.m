//
//  Game.m
//  edugames
//
//  Created by Gregory Rose on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "Game.h"

@implementation Game {
    NSMutableDictionary* gameState;
    NSInteger turnId;
    Boolean isMyTurn;
    Firebase* gameRef;
    
    ConquerViewController* cvc;
}

- (id) initWithKey:(NSString *)key andController:(ConquerViewController*)newCvc
{
    if (self = [super init])
    {
        cvc = newCvc;
        
        // Initialize the root of our Firebase namespace.
        self.firebase = [[Firebase alloc] initWithUrl:firebaseURL];
        
        gameRef = [[self.firebase childByAppendingPath:@"gameInstances"] childByAppendingPath:key];
        NSLog(@"Querying Firebase");
        [gameRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            NSLog(@"Got result");
            
            // Check Firebase for existing game!
            NSDictionary* instances = snapshot.value;
            NSString* instanceName = snapshot.name;
            
            NSString* playerId = @"foo"; // TODO: UN-HARDCODE
            
            // Check if existing game has less than 2 players
            for (NSString* instanceName in instances) {
                NSDictionary* instance = [instances objectForKey:instanceName];
                
                if ([instance[@"players"] count] == 1) {
                    
                    turnId = (NSInteger) instance[@"turnId"];
                    gameState = [(NSDictionary*)instance[@"gameState"] mutableCopy];
                    
                    // Update players list on Firebase
                    NSLog(@"Adding another player");
                    NSMutableArray* players = instance[@"players"];
                    [players addObject:playerId];
                    
                    Firebase* instanceRef = [gameRef childByAppendingPath:instanceName];
                    [[instanceRef childByAppendingPath:@"players"] setValue:players];
                    
//                    NSLog(@"Set value at %@ to %@", [instanceRef description], @{@"players": players});
                    
                    isMyTurn = NO;
                    [self gameStart];
                    
                    // Check for game state updates
                    [instanceRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
                        [self onGameStateUpdate:snapshot.value];
                    }];
                    return;
                }
            }
            
            // @assert !gameState;
            
            // Otherwise, create your own game
            NSLog(@"Creating own game");
            turnId = 0;
            gameState = [self newGameState];
            isMyTurn = YES;
            
            // Push to Firebase
            Firebase* newInstance = [gameRef childByAutoId];
            
            [newInstance setValue:@{@"players": @[playerId], @"turnId": @0, @"gameState": gameState}];
            
            NSLog(@"Created new value at %@", [newInstance description]);
            
            // Check for game state updates
            [newInstance observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
                [self onGameStateUpdate:snapshot.value];
            }];
        }];
    }
    return self;
}

- (NSMutableDictionary *) newGameState {
    return @{@"points": @5};
}

- (void) gameStart {
    NSLog(@"game started");
}

- (void) pushGameState {
    NSLog(@"game state pushed");
}

- (void) onGameStateUpdate:(NSDictionary *)newGameState {
    [cvc onUpdate:newGameState];
}



@end
