//
//  SearchViewController.m
//  edugames
//
//  Created by Lucy Guo on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UITextFieldDelegate>

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self addBackgroundImage];
        [self addSearchBox];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addBackgroundImage
{
    
    UIImage *image = [UIImage imageNamed:@"search-bg.png"];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:backgroundView];
}

- (void)addSearchBox
{
    UIImage *textBG = [UIImage imageNamed:@"searchbar"];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(210, 70, 519, 50)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Search" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    textField.textColor = [UIColor grayColor];
    
    //set padding
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 13)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.borderStyle = UITextBorderStyleNone;
    [textField setBackground:textBG];
    textField.delegate = self;
    [self.view addSubview:textField];
}

- (void)didFinishChoosing
{
 
    [self dismissViewControllerAnimated:YES completion:^() {
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //go to next view :P
    return false;
}

@end
