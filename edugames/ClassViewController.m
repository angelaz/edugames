//
//  ClassViewController.m
//  edugames
//
//  Created by Angela Zhang on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "ClassViewController.h"
#import "StudentProfileViewController.h"

@interface ClassViewController ()

@end

@implementation ClassViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //TODO: Ivan+Gregory, please replace this with a Firebase query of the currently logged in's teacher's classes!
        _classList = [NSMutableArray arrayWithObjects:@"Spanish", @"English", @"Math", nil];
        
        //TODO: Same here, except then also fill in the didSelectRowAtIndexPath method so that
        //      selecting a course will populate table with relevant students
        _studentList = [NSMutableArray arrayWithObjects:@"Matthew Thomas", @"Hailey Rah", @"Cara Roe", nil];
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    CGRect leftTableView = CGRectMake(0, 0, (frame.size.width-84)/2, frame.size.height);
    _classListView = [[UITableView alloc] initWithFrame:leftTableView style:UITableViewStylePlain];
    _classListView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _classListView.delegate = self;
    _classListView.dataSource = self;
    [_classListView reloadData];
    _classListView.backgroundColor = [UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1.0];
    [self.view addSubview:_classListView];
    
    CGRect rightTableView = CGRectMake((frame.size.width+84)/2+20, 20, (frame.size.width-84)/2, frame.size.height);
    _studentListView = [[UITableView alloc] initWithFrame:rightTableView style:UITableViewStylePlain];
    _studentListView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _studentListView.delegate = self;
    _studentListView.dataSource = self;
    [_studentListView reloadData];
    [self.view addSubview:_studentListView];
    


    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Table View Stuff
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _classListView) {
        return [_classList count];
    }
    return [_studentList count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == _classListView) {
        return @"My Classes";
    }
    return @"My Students";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.classListView])
        return 120;
    else
        return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    if (tableView == _classListView) {
        cell.textLabel.text = [_classList objectAtIndex:indexPath.row];
    }
    if (tableView == _studentListView) {
        cell.textLabel.text = [_studentList objectAtIndex:indexPath.row];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //checking for double taps here
    self.temp = [[StudentProfileViewController alloc] init];
    [self presentViewController:self.temp animated:YES completion:nil];
    [self addCloseButton];
    
}

- (void)addCloseButton
{
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_closeButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    _closeButton.frame = CGRectMake(25, 25, 28,28);
    [_closeButton addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"close-button.png"];
    [_closeButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    _closeButton.contentMode = UIViewContentModeScaleToFill;
    
    _closeButton.tag = 0;
    
    [self.temp.view addSubview:_closeButton];
}

- (void)closeButton:(UIButton *)sender
{
    [self.temp.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}



@end
