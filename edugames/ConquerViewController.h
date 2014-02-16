//
//  ConquerViewController.h
//  edugames
//
//  Created by Gregory Rose on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConquerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *closeButton;

- (id)initWithKey:(NSString*) key andGameInfo:(NSDictionary*)gameInfo;

- (void) onUpdate:(NSDictionary*) gameData;
- (void) gameStart; // called when both players ready
- (void) showQuestions;
- (void) showQuestionsWithCallback:(void (^)(bool))callback;

@end
