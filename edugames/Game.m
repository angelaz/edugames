//
//  Game.m
//  edugames
//
//  Created by Gregory Rose on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "Game.h"
#import "ConquerScene.h"

@implementation Game {
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
        
        Firebase* instancesRef = [[self.firebase childByAppendingPath:@"gameInstances"] childByAppendingPath:key];
        NSLog(@"Querying Firebase");
        [instancesRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            NSLog(@"Got result");
            
            // Check Firebase for existing game!
            NSDictionary* instances = snapshot.value;
//            NSString* instanceName = snapshot.name;
            
            NSString* playerId = @"foo"; // TODO: UN-HARDCODE
            
            // Check if existing game has less than 2 players
            for (NSString* instanceName in instances) {
                NSDictionary* instance = [instances objectForKey:instanceName];
                
                if ([instance[@"players"] count] == 1) {
                    
                    turnId = (NSInteger) instance[@"turnId"];
                    self.gameState = [(NSDictionary*)instance[@"gameState"] mutableCopy];
                    
                    // Update players list on Firebase
                    NSLog(@"Adding another player");
                    NSMutableArray* players = instance[@"players"];
                    [players addObject:playerId];
                    
                    gameRef = [instancesRef childByAppendingPath:instanceName];
                    [[gameRef childByAppendingPath:@"players"] setValue:players];
                    
                    NSLog(@"Joined game at %@", [gameRef description]);
                    
                    isMyTurn = NO;
                    
                    // Check for game state updates
                    [gameRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
                        [self onGameDataUpdate:snapshot.value];
                    }];
                    
                    [self gameStart];
                    return;
                }
            }
            
            // @assert !gameState;
            
            // Otherwise, create your own game
            NSLog(@"Creating own game");
            turnId = 0;
            self.gameState = [[NSMutableDictionary alloc] init];
            self.gameState = [self newGameState];
            isMyTurn = YES;
            
            // Push to Firebase
            gameRef = [instancesRef childByAutoId];
            
            [gameRef setValue:@{@"players": @[playerId], @"turnId": @0, @"gameState": self.gameState}];
            
            NSLog(@"Created new value at %@", [gameRef description]);
            
            // Check for game state updates
            [gameRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
                [self onGameDataUpdate:snapshot.value];
            }];
        }];
    }
    return self;
}

- (NSMutableDictionary *) newGameState {
    return [ConquerScene createGameState];
}

- (void) gameStart {
    NSLog(@"ready to start!");
    [cvc gameStart];
}

- (void) pushGameState:(NSMutableDictionary*)newGameState {
    self.gameState = newGameState;
    [[gameRef childByAppendingPath:@"gameState"] setValue:self.gameState];
    NSLog(@"game state pushed");
}

- (void) onGameDataUpdate:(NSDictionary *)newGameData {
    [cvc onUpdate:newGameData];
}



@end
