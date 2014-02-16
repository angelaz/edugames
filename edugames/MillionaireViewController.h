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
@property (strong, nonatomic) IBOutlet UIButton *closeButton;

@property (strong, nonatomic) NSMutableArray *questions;
@property (strong, nonatomic) UILabel *questionLabel;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end
