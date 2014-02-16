//
//  ClassViewController.h
//  edugames
//
//  Created by Angela Zhang on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentProfileViewController.h"

@interface ClassViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *classList;
@property (nonatomic, strong) UITableView *classListView;

@property (nonatomic, strong) NSMutableArray *studentList;
@property (nonatomic, strong) UITableView *studentListView;

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) StudentProfileViewController *temp;

@end
