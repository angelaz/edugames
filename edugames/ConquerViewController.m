//
//  ConquerViewController.m
//  edugames
//
//  Created by Gregory Rose on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "ConquerViewController.h"
#import "Game.h"

@implementation ConquerViewController

- (void) onUpdate:(NSDictionary*) gameData {
    
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
	[self.view setBackgroundColor:[UIColor whiteColor]];

}



@end
