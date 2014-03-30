//
//  GameOverViewController.h
//  edugames
//
//  Created by Lucy Guo on 3/30/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameOverViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *closeButton;

- (id)initWithWinner:(int)winner andPlayerId:(int)playerId;

@property (strong, nonatomic) UILabel *pointsLabel1;

@property (strong, nonatomic) UILabel *pointsLabel2;

@property (strong, nonatomic) UILabel *winner;

@end
