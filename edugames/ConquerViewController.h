//
//  ConquerViewController.h
//  edugames
//
//  Created by Gregory Rose on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConquerViewController : UIViewController

- (id)initWithKey:(NSString*) key;

- (void) onUpdate:(NSDictionary*) gameData;
- (void) gameStart; // called when both players ready

@end
