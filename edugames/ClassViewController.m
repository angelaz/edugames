//
//  ClassViewController.m
//  edugames
//
//  Created by Angela Zhang on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "ClassViewController.h"

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
        _studentList = [NSMutableArray arrayWithObjects:@"Greg", @"Grreg", @"Grog", nil];
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
    [self.view addSubview:_classListView];
    
    CGRect rightTableView = CGRectMake((frame.size.width+84)/2+20, 64, (frame.size.width-84)/2, frame.size.height);
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
    return cell;
}

@end
