//
//  QuizViewController.h
//  edugames
//
//  Created by Gregory Rose on 2/16/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *buttonA;
@property (strong, nonatomic) IBOutlet UIButton *buttonB;
@property (strong, nonatomic) IBOutlet UIButton *buttonC;
@property (strong, nonatomic) IBOutlet UIButton *buttonD;

@property (strong, nonatomic) UIViewController *modalView;

@end
