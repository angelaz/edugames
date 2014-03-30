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
    Firebase* gameRef;
    
    ConquerViewController* cvc;
    NSDictionary*  gameInfo;
}

- (id) initWithKey:(NSString *)key andController:(ConquerViewController*)newCvc andGameInfo:(NSDictionary*)newGameInfo
{
    if (self = [super init])
    {
        cvc = newCvc;
        gameInfo = newGameInfo;
        
        // Initialize the root of our Firebase namespace.
        self.firebase = [[Firebase alloc] initWithUrl:firebaseURL];
        
        Firebase* instancesRef = [[self.firebase childByAppendingPath:@"gameInstances"] childByAppendingPath:key];
        NSLog(@"Querying Firebase at %@", [instancesRef description]);
        [instancesRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            NSLog(@"Got result");
            
            // Check Firebase for existing game!
            id x = snapshot.value;
            NSDictionary* instances = snapshot.value;
//            NSString* instanceName = snapshot.name;
            
            NSString* playerId = @"foo"; // TODO: UN-HARDCODE
            
            // Check if existing game has less than 2 players
            if (instances != (id)[NSNull null])
            {
                for (NSString* instanceName in instances) {
                    NSDictionary* instance = [instances objectForKey:instanceName];
                    
                    if ([instance[@"players"] count] == 1) {
                        
                        self.turnId = 2;
                        self.gameState = [(NSDictionary*)instance[@"gameState"] mutableCopy];
                        self.gameState[@"turnId"] = @1;
                        
                        // Update players list on Firebase
                        NSLog(@"Adding another player");
                        NSMutableArray* players = instance[@"players"];
                        [players addObject:playerId];
                        
                        gameRef = [instancesRef childByAppendingPath:instanceName];
                        [[gameRef childByAppendingPath:@"players"] setValue:players];
                        [self pushGameState:self.gameState];
                        
                        NSLog(@"Joined game at %@", [gameRef description]);
                        
                        // Check for game state updates
                        [gameRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
                            [self onGameDataUpdate:snapshot.value];
                        }];
                        
                        [self gameStart];
                        return;
                    }
                }
            }
            
            // @assert !gameState;
            
            // Otherwise, create your own game
            NSLog(@"Creating own game");
            self.turnId = 1;
            self.gameState = [[NSMutableDictionary alloc] init];
            self.gameState = [self newGameState];
            
            // Push to Firebase
            gameRef = [instancesRef childByAutoId];
            [gameRef setValue:@{@"players": @[playerId], @"gameState": self.gameState}];
            
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

-(void)endGame:(int)winner {
    self.gameState[@"turnId"] = [NSNumber numberWithInt:(-winner)];
    [self pushGameState:self.gameState];
}

- (void) pushGameState:(NSMutableDictionary*)newGameState {
    self.gameState = newGameState;
    [[gameRef childByAppendingPath:@"gameState"] setValue:self.gameState];
    NSLog(@"game state pushed");
}

- (void) onGameDataUpdate:(NSDictionary *)newGameData {
    self.gameState = [(NSDictionary*)newGameData[@"gameState"] mutableCopy];
    
    [cvc onUpdate:newGameData];
}

- (void) deleteInstance {
    [gameRef removeAllObservers];
    //[gameRef removeValue];
}



@end
