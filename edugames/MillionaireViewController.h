//
//  MillionaireViewController.h
//  Millionaire
//
//  Created by Angela Zhang on 2/15/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MillionaireViewController : UIViewController

@property (strong, nonatomic) UIViewController *modalView;

@property (strong, nonatomic) IBOutlet UIButton *topLeft;
@property (strong, nonatomic) IBOutlet UIButton *bottomLeft;
@property (strong, nonatomic) IBOutlet UIButton *topRight;
@property (strong, nonatomic) IBOutlet UIButton *bottomRight;

@property (strong, nonatomic) NSMutableDictionary *questions;
@property (strong, nonatomic) UILabel *questionLabel;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) UILabel *moneyLabel;
@property (strong, nonatomic) UIButton *closeButton;

@end
