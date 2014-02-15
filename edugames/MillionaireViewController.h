//
//  MillionaireViewController.h
//  Millionaire
//
//  Created by Angela Zhang on 2/15/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MillionaireViewController : UIViewController

@property (strong, nonatomic) UIViewController *modalView;

@property (strong, nonatomic) IBOutlet UIButton *topLeft;

@property (strong, nonatomic) NSMutableArray *questions;
@property (strong, nonatomic) UILabel *questionLabel;

@end
