//
//  GameViewController.m
//  edugames
//
//  Created by Lucy Guo on 2/15/14.
//  Copyright (c) 2014 Angela Zhang, Lucy Guo, Ivan Wang, Gregory Rose. All rights reserved.
//

#import "GameViewController.h"
#import "ConquerViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController {
    NSArray *games;
    NSMutableArray *myGames;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //  TODO: Need to populate this properly with teacher's games.
        //  Would be nice if teacher games could be stored with format [Title, Image Name, Game ID] (or if necessary we can
        //    have numbers that correspond to different game templates and associate those)
        myGames = [[NSMutableArray alloc] initWithObjects:@[@"Simple Addition", @1, @12345], @[@"Chapter 1 History", @2, @12345], @[@"Hyrodgen Facts", @3, @12345], @[@"Millionaire Test", @0, @1342], nil];
    }
    return self;
}

//  Collection view methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20); //  Top, left, bottom, right
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.height-100, frame.size.width)  collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1.0]];
    
    [self.view addSubview:_collectionView];
    
    // Set up games with Firebase
    games = [NSArray arrayWithObject:@"login-button.png"]; // TODO: change icons
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //[super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [myGames count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    NSLog(@"%zd", indexPath.row);
    cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"card-millionaire.png"]];
    
    //  TODO: This is temporary before we associate either image names directly or use IDs for templates
    if ([[[myGames objectAtIndex:indexPath.row] objectAtIndex:1] isEqual:@2]) {
        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"card-millionaire-alt.png"]];
    }
    
    UILabel *gameNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, 280, 25)];
    gameNameLabel.text = [[myGames objectAtIndex:indexPath.row] objectAtIndex:0];
    gameNameLabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:gameNameLabel];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Look: %zd", indexPath.row);
    
    MillionaireViewController *mvc = [[MillionaireViewController alloc] initWithNibName:nil bundle:nil];
    //[self presentViewController:mvc animated:YES completion:nil];
    
    [self.navigationController pushViewController:mvc animated:YES];
    /*
    // TODO: case on games
    //if ([games objectAtIndex:indexPath.row] isEqualToString:@"conqueror") {
        ConquerViewController *conquerViewController = [[ConquerViewController alloc] initWithKey:@"-JFolzigUK-BhNxu3jRv"]; // TODO: replace with actual key!
        [self presentViewController:conquerViewController animated:YES completion:nil];
    //}
    
    NSLog(@"%@", [[myGames objectAtIndex:indexPath.row] objectAtIndex:1]);
    if ([[[myGames objectAtIndex:indexPath.row] objectAtIndex:1] isEqual:@0]) {
        MillionaireViewController *mvc = [[MillionaireViewController alloc] init];
        //[self presentViewController:mvc animated:YES completion:nil];
        //[self.navigationController presentViewController:mvc animated:YES completion:nil];
    }
    
    
    // TODO: what is this?*/
//    [collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(280, 325);
}

/*

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)presentGCTurnViewController:(id)sender
{
    [[GCTurnBasedMatchHelper sharedInstance]
     findMatchWithMinPlayers:2 maxPlayers:3 viewController:self];
}*/

@end
